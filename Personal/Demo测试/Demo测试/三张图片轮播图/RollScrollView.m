//
//  RollScrollView.m
//  三张图片无线轮播图
//
//  Created by vcyber on 16/6/14.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "RollScrollView.h"
#import "UIImageView+WebCache.h"
#import "WeakTimer.h"

static int const imageViewCount = 3;

//pageControl底部间距
#define pageControl_bottom_Margin    10
//scrollView的宽度
#define scrollView_Width self.scrollView.frame.size.width
//scrollView的高度
#define scrollView_Height self.scrollView.frame.size.height

@interface RollScrollView ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIPageControl *pageControl;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) BOOL isFirstLoadImage;
/**
 *  自定义页码指示图片大小
 */
@property (nonatomic, assign) CGSize   customPageControlImageSize;

@end

@implementation RollScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        self.scrollView = [[UIScrollView alloc] init];
        self.scrollView.showsVerticalScrollIndicator= NO;
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.pagingEnabled = YES;
        self.scrollView.bounces = NO;
        self.scrollView.delegate = self;
        self.scrollView.scrollEnabled = YES;
        [self addSubview:self.scrollView];
        
        for (int i = 0; i < imageViewCount; i++) {
            UIImageView *imageView = [[UIImageView alloc] init];
            UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImage:)];
            imageView.userInteractionEnabled = YES;
            [imageView addGestureRecognizer:tap];
            [self.scrollView addSubview:imageView];
        }
        
        self.pageControl = [[UIPageControl alloc] init];
        [self addSubview:self.pageControl];
    }
    return self;
}

- (void)clickImage:(UITapGestureRecognizer *)tap {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickRollScrollView:didSelectScrollViewIndex:)]) {
        [self.delegate clickRollScrollView:self didSelectScrollViewIndex:self.pageControl.currentPage];
    }
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    self.scrollView.frame = self.bounds;
    if (self.isPortrait) {
        self.scrollView.contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height * imageViewCount);
    }else {
        self.scrollView.contentSize = CGSizeMake(self.frame.size.width * imageViewCount, self.frame.size.height);
    }
    
    for (int i = 0; i < imageViewCount; i++) {
        UIImageView *imageView = self.scrollView.subviews[i];
        if (self.isPortrait) {
            imageView.frame = CGRectMake(0, i * self.scrollView.frame.size.height, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
        }else {
            
            imageView.frame = CGRectMake(i * self.scrollView.frame.size.width, 0, self.scrollView.frame.size.width, self.scrollView.frame.size.height);
        }
    }
    
    //pageControl的位置
    self.pageControlPosition = PageControlPosition_None;
    [self displayImage];
}


#pragma mark --<UIScrollViewDelegate>
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSInteger page = 0;
    CGFloat minDistance = MAXFLOAT;
    
    for (int i = 0; i < imageViewCount; i ++) {
        UIImageView *imageView = self.scrollView.subviews[i];
        CGFloat distance = 0;
        if (self.portrait) {
            distance = ABS(imageView.frame.origin.y - scrollView.contentOffset.y);
        }else {
            distance = ABS(imageView.frame.origin.x - scrollView.contentOffset.x);
        }
        
        if (distance < minDistance) {
            minDistance = distance;
            page = imageView.tag;
        }
    }
    self.pageControl.currentPage = page;

}

//开始拖拽  结束定时器
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    [self stopTimer];
}

//结束拖拽 开启定时器
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    [self startTimer];
}


- (void)stopTimer {
    [self.timer invalidate];
    self.timer = nil;
}


- (void)startTimer {
    
//    self.timer = [WeakTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(displayNextImage:) userInfo:nil repeats:YES];
//    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

//定时器方法  下一张图片
- (void)displayNextImage:(NSTimer *)timer {
    
    if (self.portrait) {
        [self.scrollView setContentOffset:CGPointMake(0, self.scrollView.frame.size.height * 2) animated:YES];
    }else {
        [self.scrollView setContentOffset:CGPointMake(self.scrollView.frame.size.width * 2,0 ) animated:YES];
    }
}

//手指拖动停止的时候 显示下一张图片
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    [self displayImage];
}

//定时器滚动停止时  显示下一张图片
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    [self displayImage];
}

- (void)displayImage {
    if (self.imageArray.count > 2) {
        
        // 设置图片，三张imageview显示无限张图片
        for (int i = 0; i<imageViewCount; i++) {
            UIImageView *imageView = self.scrollView.subviews[i];
            NSInteger index = self.pageControl.currentPage;
            /**
             *  滚到第一张，并且是程序刚启动是第一次加载图片，index才减一。
             加上这个判断条件，是为了防止当程序第一次加载图片时，此时第一张图片的i=0，那么此时index--导致index<0，进入下面index<0的判断条件，让第一个imageview显示的是最后一张图片
             */
            if (i == 0 && self.isFirstLoadImage) {
                index--;
            }else if (i == 2) {//滚到最后一张图片，index加1
                index++;
            }
            
            if (index < 0) {//如果滚到第一张还继续向前滚，那么就显示最后一张
                index = self.pageControl.numberOfPages-1 ;
            }else if (index >= self.pageControl.numberOfPages) {//滚动到最后一张的时候，由于index加了一，导致index大于总的图片个数，此时把index重置为0，所以此时滚动到最后再继续向后滚动就显示第一张图片了
                index = 0;
            }
            
            imageView.tag = index;
            [self loadImage:index withImageView:imageView];
        }
        
        self.isFirstLoadImage =YES;
        
        // 偏移一个scrollview的高度或者宽度，让scrollview显示中间的imageview
        if (self.isPortrait) {
            self.scrollView.contentOffset = CGPointMake(0, self.scrollView.frame.size.height);
        } else {
            self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
        }
    }
}


- (void)loadImage:(NSInteger)imageIndex withImageView:(UIImageView *)imageView {
    
    id obj = self.imageArray[imageIndex];
    if ([obj isKindOfClass:[UIImage class]]) {
        imageView.image = obj;
    }else if ([obj isKindOfClass:[NSString class]]) {
        imageView.image = [UIImage imageNamed:obj];
    }else if ([obj isKindOfClass:[NSURL class]]) {
        [imageView sd_setImageWithURL:obj placeholderImage:self.placeholder];
    }
}


- (void)setPageControlPosition:(PageControlPosition)pageControlPosition {
    
    _pageControlPosition = pageControlPosition;
    self.pageControl.hidden = (pageControlPosition == PageControlPosition_Hidden);
    if (self.pageControl.hidden) {
        return;
    }
    //设置pageControl的位置
    CGSize size;
    if (self.customPageControlImageSize.width) {
        size = CGSizeMake(self.customPageControlImageSize.width * (self.pageControl.numberOfPages * 2 -1), self.customPageControlImageSize.height);
    }else {
        size = [self.pageControl sizeForNumberOfPages:self.pageControl.numberOfPages];
    }
    
    self.pageControl.frame = CGRectMake(101.5 ,161.5, 117, 20);
    CGFloat centerY = scrollView_Height - pageControl_bottom_Margin - size.height * 0.5;
    self.pageControl.center = CGPointMake(scrollView_Width * 0.5, centerY);
}



- (void)setpageControlCurrentColor:(UIColor *)currentColor OtherColor:(UIColor *)otherColor
{
    if(!currentColor || !otherColor)  return;
    
    self.pageControl.currentPageIndicatorTintColor = currentColor;
    self.pageControl.pageIndicatorTintColor = otherColor;
}

- (void)setPageControlCurrentImage:(UIImage *)currentImage OtherImage:(UIImage *)otherImage
{
    if(!currentImage  || !otherImage)  return;
    self.customPageControlImageSize = currentImage.size;
    [self.pageControl setValue:currentImage forKey:@"_currentPageImage"];
    [self.pageControl setValue:otherImage forKey:@"_pageImage"];
}


- (void)setImageArray:(NSArray *)imageArray {
    
    _imageArray= imageArray;
    self.pageControl.numberOfPages = imageArray.count;
    self.pageControl.currentPage = 0;
    
    [self displayImage];
    
    [self startTimer];
}

- (void)dealloc {
    NSLog(@"RollScrollView被销毁");
}

@end
