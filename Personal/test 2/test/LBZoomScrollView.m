//
//  LBZoomScrollView.m
//  test
//
//  Created by dengweihao on 2017/3/15.
//  Copyright © 2017年 dengweihao. All rights reserved.
//

#import "LBZoomScrollView.h"
#import "LBTapDetectingImageView.h"


@interface LBZoomScrollView ()<UIScrollViewDelegate,LBTapDetectingImageViewDelegate>

@property (nonatomic , weak)LBTapDetectingImageView *imageView;
@property (nonatomic , assign)CGSize imageSize;
@property (nonatomic , assign)BOOL stop;
@property (nonatomic , strong)NSURL *url;
@property (nonatomic , assign)CGRect oldFrame;
@property (nonatomic , weak)UIImageView *thumbnailImageView;
@end

@implementation LBZoomScrollView
- (LBTapDetectingImageView *)imageView {
    if (!_imageView) {
        LBTapDetectingImageView *imageView  = [[LBTapDetectingImageView alloc]init];
        imageView.tapDelegate = self;
        imageView.userInteractionEnabled = YES;
        [self addSubview:imageView];
        _imageView = imageView;
    }
    return _imageView;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        self.delegate = self;
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.decelerationRate = UIScrollViewDecelerationRateFast;
        self.frame = [UIScreen mainScreen].bounds;
    }
    return self;
}
- (void)showImageWithURL:(NSURL *)url andPlaceHoldImage:(UIImage *)image andFrom:(UIImageView *)fromView andFromViewLocationView:(UIView *)locationView {
//    if (!url) return;
    _url = url;
    CGRect rect = [locationView convertRect:fromView.frame toView:[UIApplication sharedApplication].keyWindow];
    ;
    self.oldFrame = rect;
    _thumbnailImageView = fromView;
    [self setImage:[UIImage imageNamed:@"test.jpg"]];
}

- (void)setImage:(UIImage *)image {
    _image = image;
    _imageSize = [self newSizeForImageViewWithImage:image];
    self.maximumZoomScale = 3.0;
    self.minimumZoomScale = 1.0;
    self.zoomScale = 1.0;
    self.contentSize = CGSizeMake(0, 0);
    // Set image
    self.imageView.image = image;
    // Setup photo frame
    CGRect photoImageViewFrame;
    photoImageViewFrame.origin = CGPointZero;
    photoImageViewFrame.size = _imageSize;
    self.imageView.frame = self.oldFrame;
    [ UIView animateWithDuration:0.25 animations:^{
        self.imageView.frame = photoImageViewFrame;
    }];
    self.contentSize = photoImageViewFrame.size;
    [self setNeedsLayout];
   
}
- (void)layoutSubviews {
    [super layoutSubviews];
    if (_stop == YES) return;
    CGSize boundsSize = self.bounds.size;
    CGRect frameToCenter =  self.imageView.frame;
    // Horizontally floor：如果参数是小数，则求最大的整数但不大于本身.
    if (frameToCenter.size.width < boundsSize.width) {
        frameToCenter.origin.x = floorf((boundsSize.width - frameToCenter.size.width) / 2.0);
    } else {
        frameToCenter.origin.x = 0;
    }
    
    // Vertically
    if (frameToCenter.size.height < boundsSize.height) {
        frameToCenter.origin.y = floorf((boundsSize.height - frameToCenter.size.height) / 2.0);
    } else {
        frameToCenter.origin.y = 0;
    }
    // Center
    if (!CGRectEqualToRect( self.imageView.frame, frameToCenter)){
        self.imageView.frame = frameToCenter;
    }
}

#pragma mark - 比例尺寸处理-
- (CGSize)newSizeForImageViewWithImage:(UIImage *)image {
    float width = 0;
    float height = 0;
    float maxWidth = SCREEN_WIDTH;
    float maxHeight = SCREEN_HEIGHT;
    
    float bili=(float)image.size.width/image.size.height;
    float newBili=(float)maxWidth/maxHeight;
    if (bili >= newBili) {
        width = (float)image.size.width /maxWidth;
        height = (float)image.size.height/width;
        width = maxWidth;
    }else
    {
        height = (float)image.size.height/maxHeight;
        width = (float)image.size.width/height;
        height = maxHeight;
    }
    return CGSizeMake(width,height);
}


#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (void)scrollViewDidZoom:(UIScrollView *)scrollView {
    [self setNeedsLayout];
    [self layoutIfNeeded];
}
- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale{
    if (scrollView.minimumZoomScale != scale) return;
    [self setZoomScale:self.minimumZoomScale animated:YES];
    self.imageView.frame = CGRectMake(0, 0, self.imageSize.width, self.imageSize.height);
    self.frame = [UIScreen mainScreen].bounds;
    self.contentSize = self.imageView.frame.size;
    [self setNeedsLayout];
}
- (void)imageView:(UIImageView *)imageView doubleTapDetected:(UITouch *)touch {
    [self handleDoubleTap:[touch locationInView:imageView]];
}

- (void)imageView:(UIImageView *)imageView singleTapDetected:(UITouch *)touch {
    [self handlesingleTap:[touch locationInView:imageView]];
}




- (void)handlesingleTap:(CGPoint)touchPoint {
    self.backgroundColor = [UIColor clearColor];
    self.stop = YES;
    self.thumbnailImageView.hidden = YES;
    [UIView animateWithDuration:0.25 animations:^{
        self.imageView.frame = self.oldFrame;
    }completion:^(BOOL finished) {
        [self.imageView removeFromSuperview];
        [self removeFromSuperview];
        self.thumbnailImageView.hidden = NO;
    }];
}

- (void)handleDoubleTap:(CGPoint)touchPoint {
    
    if (self.zoomScale != self.minimumZoomScale) {
        [self setZoomScale:self.minimumZoomScale animated:YES];
    } else {
        CGFloat newZoomScale =self.maximumZoomScale ;
        CGFloat xsize = self.bounds.size.width / newZoomScale;
        CGFloat ysize = self.bounds.size.height / newZoomScale;
        [self zoomToRect:CGRectMake(touchPoint.x - xsize/2, touchPoint.y - ysize/2, xsize, ysize) animated:YES];
        
    }

}




- (void)imageViewNeedSuperViewBeginLayout {
    _stop = NO;
}
- (void)imageViewNeedSuperViewStopLayout {
    _stop = YES;
}
- (void)imageViewDidMoved:(UIImageView *)imageView {
    self.thumbnailImageView.hidden = YES;
}
- (void)imageViewNeedDismiss {
    [self handlesingleTap:CGPointZero];
}

@end
