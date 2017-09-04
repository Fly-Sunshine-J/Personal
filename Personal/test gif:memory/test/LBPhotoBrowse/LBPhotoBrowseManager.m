//
//  LBPhotoBrowseManager.m
//  test
//
//  Created by dengweihao on 2017/8/1.
//  Copyright © 2017年 dengweihao. All rights reserved.
//

#import "LBPhotoBrowseManager.h"
#import "UIImage+Decoder.h"
#if __has_include(<SDWebImage/SDWebImageManager.h>)

#import <SDWebImage/SDWebImageManager.h>
#import <SDWebImage/UIImageView+WebCache.h>

#else

#import "SDWebImageManager.h"
#import "UIImageView+WebCache.h"

#endif

static const NSTimeInterval kMaxTimeStep = 1; //note: To avoid spiral-o-death
static LBPhotoBrowseManager *mgr = nil;

static inline void resetManagerData(LBPhotoBrowseView *photoBrowseView, LBUrlsMutableArray *urls ,LBImageViewsArray *imageViews) {
    [urls removeAllObjects];
    [imageViews removeAllObjects];
    if (photoBrowseView) {
        [photoBrowseView removeFromSuperview];
    }
}

@interface LBPhotoBrowseManager ()

@property (nonatomic , copy)void (^titleClickBlock)(UIImage *, NSIndexPath *, NSString *);

@property (nonatomic , copy)UIView *(^LongPressCustomViewBlock)(UIImage *, NSIndexPath *);

@property (nonatomic , strong)NSArray *titles;


// timer
// in ios 9 this property can be weak Replace strong
@property (nonatomic , strong)CADisplayLink *displayLink;
@property (nonatomic , assign) NSTimeInterval accumulator;
@property (nonatomic, assign) NSTimeInterval *frameDurations;
@property (nonatomic, assign) int currentFrameIndex;


@end


@implementation LBPhotoBrowseManager

@synthesize urls = _urls;

@synthesize imageViews = _imageViews;

- (LBUrlsMutableArray *)urls {
    if (!_urls) {
        _urls = [[LBUrlsMutableArray alloc]init];
    }
    return _urls;
}


- (LBImageViewsArray *)imageViews {
    if (!_imageViews) {
        _imageViews = [[LBImageViewsArray alloc]init];
    }
    return _imageViews;
}

+ (instancetype)defaultManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mgr = [[self alloc]init];
        mgr.style = LBMaximalImageViewOnDragDismmissStyleOne;
    });
    return mgr;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.isNeedBounces = YES;
        self.errorImage = [UIImage imageNamed:@"LBLoadError.jpg"];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(displayLinkInvalidate) name:LBImageViewWillDismissNot object:nil];

    }
    return self;
}

- (void)showImageWithURLArray:(NSArray *)urls fromImageViews:(NSArray *)imageViews andSelectedIndex:(int)index andImageViewSuperView:(UIView *)superView {
    
    if (urls.count == 0 || !urls) return;
    if (imageViews.count == 0 || !imageViews) return;
    
    resetManagerData(_photoBrowseView, self.urls, self.imageViews);
    for (id obj in urls) {
        NSURL *url = nil;
        if ([obj isKindOfClass:[NSURL class]]) {
            url = obj;
        }
        if ([obj isKindOfClass:[NSString class]]) {
            url = [NSURL URLWithString:obj];
        }
        NSAssert(url, @"url数组里面的数据有问题!");
        if (url) {
            [self.urls addObject:url];
        }
    }
    
    for (id obj in imageViews) {
        UIImageView *imageView = nil;
        if ([obj isKindOfClass:[UIImageView class]]) {
            imageView = obj;
        }
        NSAssert(imageView, @"imageView数组里面的数据有问题!");
        if (imageView) {
            [self.imageViews addObject:imageView];
        }
    }
    NSAssert(self.urls.count == self.imageViews.count, @"请检查传入的urls 和 imageViews数组");
    
    _selectedIndex = index;
    _imageViewSuperView = superView;
    
    LBPhotoBrowseView *photoBrowseView = [[LBPhotoBrowseView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [photoBrowseView showImageViewsWithURLs:self.urls fromImageView:self.imageViews andSelectedIndex:index andImageViewSuperView:superView];
    [[UIApplication sharedApplication].keyWindow addSubview:photoBrowseView];
    _photoBrowseView = photoBrowseView;
}

#pragma mark - longPressAction

- (instancetype)addLongPressShowTitles:(NSArray <NSString *> *)titles {
    _titles = titles;
    return self;
}

- (instancetype)addTitleClickCallbackBlock:(void (^)(UIImage *, NSIndexPath *, NSString *))titleClickCallBackBlock {
    _titleClickBlock = titleClickCallBackBlock;
    return self;
}
- (instancetype)addLongPressCustomViewBlock:(UIView *(^)(UIImage *, NSIndexPath *))longPressBlock {
    _LongPressCustomViewBlock = longPressBlock;
    return self;
}

- (instancetype)addPlaceHoldImageCallBackBlock:(UIImage *(^)(NSIndexPath * indexPath))placeHoldImageCallBackBlock {
    _placeHoldImageCallBackBlock = placeHoldImageCallBackBlock;
    return self;
}

- (NSArray<NSString *> *)currentTitles {
    return _titles;
}

- (void (^)(UIImage *, NSIndexPath *, NSString *))titleClickBlock {
    return _titleClickBlock;
}

- (UIView *(^)(UIImage *, NSIndexPath *))LongPressCustomViewBlock {
    return _LongPressCustomViewBlock;
}

#pragma mark - gif&定时器

- (void)setCurrentShowImageView:(UIImageView *)currentShowImageView {
    if (_currentShowImageView && _currentShowImageView == currentShowImageView) {
        return;
    }
    _currentShowImageView = currentShowImageView;
    if (self.lowGifMemory == NO) return;
    [self startAnimation];
}
- (CADisplayLink *)displayLink {
    if (!_displayLink) {
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(changeKeyframe:)];
        [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
    return _displayLink;
}
- (void)changeKeyframe:(CADisplayLink *)displayLink
{
    if (!self.gifImages) {
        return;
    }
    self.accumulator += fmin(displayLink.duration, kMaxTimeStep);
    while (self.accumulator >= self.frameDurations[self.currentFrameIndex]) {
        self.accumulator -= self.frameDurations[self.currentFrameIndex];
        if (++self.currentFrameIndex >= [self.gifImages count]) {
            self.currentFrameIndex = 0;
        }
        self.currentFrameIndex = MIN(self.currentFrameIndex, (int)self.gifImages.count - 1);
        self.currentShowImageView.image = self.gifImages[self.currentFrameIndex];
    }
}

- (void)displayLinkInvalidate {
    if (_displayLink) {
        [_displayLink invalidate];
        _displayLink = nil;
    }
    self.gifImages = nil;
    self.currentShowImageView = nil;
}


- (void)startAnimation {
    // 每次取10帧 --》 用完之后立即释放 然后再取10帧-->
    self.displayLink.paused = YES;
    weak_self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIView *superView = wself.currentShowImageView.superview;
        if (![superView isKindOfClass:[UIScrollView class]]) return ;
        
        NSURL *currentUrl = [superView valueForKeyPath:@"url"];
        [[SDImageCache sharedImageCache] queryCacheOperationForKey:currentUrl.absoluteString done:^(UIImage * _Nullable image, NSData * _Nullable data, SDImageCacheType cacheType) {
            if (image.images.count < 1) return;
            NSTimeInterval totalDuration;
            NSTimeInterval *frameDurations;
            wself.gifImages = [image lb_animatedGIFDuration:&frameDurations andTotalDuration: &totalDuration fromData:data];
            wself.frameDurations = frameDurations;
            wself.accumulator = 0;
            wself.currentFrameIndex = 0;
            wself.displayLink.paused = NO;
        }];
    });
}

/**
 预取的思路:
 取出20帧 分别放在两个数组 
 第一个用完之后 用第二个 第一个再去取
 */


@end
