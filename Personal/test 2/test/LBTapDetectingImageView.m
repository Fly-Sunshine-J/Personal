//
//  LBTapDetectingImageView.m
//  test
//
//  Created by dengweihao on 2017/3/16.
//  Copyright © 2017年 dengweihao. All rights reserved.
//

#import "LBTapDetectingImageView.h"
#import "UIView+Frame.h"
@interface LBTapDetectingImageView ()
@property (nonatomic , assign)CGPoint lastPoint;
@property (nonatomic , assign)BOOL movable;
@property (nonatomic , assign)CGPoint originalPoint;
@property (nonatomic , assign)CGAffineTransform originalTransform;
@property (nonatomic , assign)CGRect originalFrame ;
@property (nonatomic , assign)BOOL isSingleTap;
@property (nonatomic , assign)CGPoint originalCenter;

@end

@implementation LBTapDetectingImageView


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (id)initWithImage:(UIImage *)image {
    if ((self = [super initWithImage:image])) {
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (id)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage {
    if ((self = [super initWithImage:image highlightedImage:highlightedImage])) {
        self.userInteractionEnabled = YES;
    }
    return self;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    NSUInteger tapCount = touch.tapCount;
    _isSingleTap = YES;
    switch (tapCount) {
        case 1:
            [self performSelector:@selector(handleSingleTap:) withObject:touch afterDelay:0.2];
            break;
        case 2:
            [self handleDoubleTap:touch];
            break;
        case 3:
            [self handleTripleTap:touch];
            break;
        default:
            break;
    }
    [[self nextResponder] touchesEnded:touches withEvent:event];
    _lastPoint = CGPointZero;
    if (_movable == NO) return;
    if (self.width/self.originalFrame.size.width < 0.6) {
        if ([_tapDelegate respondsToSelector:@selector(imageViewNeedDismiss)]) {
            [_tapDelegate imageViewNeedDismiss];
        }
        return;
    }
    [UIView animateWithDuration:0.25 animations:^{
        self.transform = self.originalTransform;
        self.frame = self.originalFrame;
        self.center = self.originalCenter;
        self.superview.backgroundColor = [UIColor blackColor];
    }completion:^(BOOL finished) {
        UIScrollView *sc =(UIScrollView *)self.superview;
        [sc  setScrollEnabled:YES];
        if ([_tapDelegate respondsToSelector:@selector(imageViewNeedSuperViewBeginLayout)]) {
            [_tapDelegate imageViewNeedSuperViewBeginLayout];
        }
        _movable = NO;
    }];

}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:[UIApplication sharedApplication].keyWindow];
    if (_lastPoint.y >= point.y && _movable == NO) return;
    CGFloat deviationX = point.x - _lastPoint.x;
    CGFloat deviationY = point.y - _lastPoint.y;
    _lastPoint = point;
    _movable = YES;
    [(UIScrollView *)self.superview  setScrollEnabled:NO];
    self.center = CGPointMake(self.center.x + deviationX, self.center.y + deviationY);
    if ([_tapDelegate respondsToSelector:@selector(imageViewDidMoved:)]) {
        [_tapDelegate imageViewDidMoved:self];
    }
    CGFloat currentDeviationFromBegin = point.y - self.originalPoint.y;
    if (currentDeviationFromBegin > (LB_DISMISS_DISTENCE - 40)) {
        currentDeviationFromBegin = (LB_DISMISS_DISTENCE - 40);
    }
    if (currentDeviationFromBegin <= 0) {
        currentDeviationFromBegin = 0;
    }
    if ([_tapDelegate respondsToSelector:@selector(imageViewNeedSuperViewStopLayout)]) {
        [_tapDelegate imageViewNeedSuperViewStopLayout];
    }
    CGFloat ration = 1 - currentDeviationFromBegin/LB_DISMISS_DISTENCE;
    self.transform = CGAffineTransformScale(self.originalTransform, ration, ration);
    self.superview.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:(LB_DISMISS_DISTENCE-currentDeviationFromBegin)/(LB_DISMISS_DISTENCE - 40)];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint point = [touch locationInView:[UIApplication sharedApplication].keyWindow];
    self.originalCenter = self.center;
    self.originalTransform = self.transform;
    self.originalFrame = self.frame;
    self.originalPoint = point;
    self.lastPoint = point;
}


- (void)handleSingleTap:(UITouch *)touch {
    if (_isSingleTap == NO) return;
    if ([_tapDelegate respondsToSelector:@selector(imageView:singleTapDetected:)])
        [_tapDelegate imageView:self singleTapDetected:touch];
}

- (void)handleDoubleTap:(UITouch *)touch {
    _isSingleTap = NO;
    if ([_tapDelegate respondsToSelector:@selector(imageView:doubleTapDetected:)])
        [_tapDelegate imageView:self doubleTapDetected:touch];
}

- (void)handleTripleTap:(UITouch *)touch {
    if ([_tapDelegate respondsToSelector:@selector(imageView:tripleTapDetected:)])
        [_tapDelegate imageView:self tripleTapDetected:touch];
}
@end
