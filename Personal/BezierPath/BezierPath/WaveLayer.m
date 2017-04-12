//
//  WaveLayer.m
//  BezierPath
//
//  Created by vcyber on 16/6/22.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "WaveLayer.h"
#import <UIKit/UIKit.h>

@interface WaveLayer ()

@property (nonatomic, strong) UIBezierPath *wavePathPre;
@property (nonatomic, strong) UIBezierPath *wavePathStarting;
@property (nonatomic, strong) UIBezierPath *wavePathLow;
@property (nonatomic, strong) UIBezierPath *wavePathMid;
@property (nonatomic, strong) UIBezierPath *wavePathHigh;
@property (nonatomic, strong) UIBezierPath *wavePathComplete;

@end

static const CGFloat KAnimationDuration = 0.2;
static const CGFloat LineWidth = 5;
@implementation WaveLayer

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.fillColor = [UIColor yellowColor].CGColor;
        self.path = self.wavePathStarting.CGPath;
    }
    return self;
}

- (UIBezierPath *)wavePathPre {
    
    if (!_wavePathPre) {
        _wavePathPre = [UIBezierPath new];
        [_wavePathPre moveToPoint:CGPointMake(-LineWidth, 100 + LineWidth)];
        [_wavePathPre addLineToPoint:CGPointMake(-LineWidth, 99 + LineWidth)];
        [_wavePathPre addLineToPoint:CGPointMake(100 + LineWidth, 99 + LineWidth)];
        [_wavePathPre addLineToPoint:CGPointMake(100 + LineWidth, 100 + LineWidth)];
        [_wavePathPre closePath];
    }
    return _wavePathPre;
}

- (UIBezierPath *)wavePathStarting {
    
    if (!_wavePathStarting) {
        _wavePathStarting = [UIBezierPath new];
        [_wavePathStarting moveToPoint:CGPointMake(-LineWidth, 100 + LineWidth)];
        [_wavePathStarting addLineToPoint:CGPointMake(-LineWidth, 80 + LineWidth)];
        [_wavePathStarting addCurveToPoint:CGPointMake(100 +LineWidth, 80 + LineWidth) controlPoint1:CGPointMake(30, 70) controlPoint2:CGPointMake(60, 90)];
        [_wavePathStarting addLineToPoint:CGPointMake(100 + LineWidth, 100 + LineWidth)];
        [_wavePathStarting closePath];
    }
    return _wavePathStarting;
}

- (UIBezierPath *)wavePathLow {
    
    if (!_wavePathLow) {
        _wavePathLow = [[UIBezierPath alloc] init];
        [_wavePathLow moveToPoint:CGPointMake(-LineWidth, 100 + LineWidth)];
        [_wavePathLow addLineToPoint:CGPointMake(-LineWidth, 60 + LineWidth)];
        [_wavePathLow addCurveToPoint:CGPointMake(100 + LineWidth, 60 + LineWidth) controlPoint1:CGPointMake(30, 60) controlPoint2:CGPointMake(60, 50)];
        [_wavePathLow addLineToPoint:CGPointMake(100 + LineWidth, 100 + LineWidth)];
        [_wavePathLow closePath];
    }
    return _wavePathLow;
}

- (UIBezierPath *)wavePathMid {
    
    if (!_wavePathMid) {
        _wavePathMid = [[UIBezierPath alloc] init];
        [_wavePathMid moveToPoint:CGPointMake(-LineWidth, 100 + LineWidth)];
        [_wavePathMid addLineToPoint:CGPointMake(-LineWidth, 40 + LineWidth)];
        [_wavePathMid addCurveToPoint:CGPointMake(100 + LineWidth, 40 + LineWidth) controlPoint1:CGPointMake(30, 30) controlPoint2:CGPointMake(60, 50)];
        [_wavePathMid addLineToPoint:CGPointMake(100 + LineWidth, 100 + LineWidth)];
        [_wavePathMid closePath];
    }
    return _wavePathMid;
}

- (UIBezierPath *)wavePathHigh {
    
    if (!_wavePathHigh) {
        _wavePathHigh = [[UIBezierPath alloc] init];
        [_wavePathHigh moveToPoint:CGPointMake(-LineWidth, 100 + LineWidth)];
        [_wavePathHigh addLineToPoint:CGPointMake(-LineWidth, 20 + LineWidth)];
        [_wavePathHigh addCurveToPoint:CGPointMake(100 + LineWidth, 20 + LineWidth) controlPoint1:CGPointMake(30, 20) controlPoint2:CGPointMake(60, 40)];
        [_wavePathHigh addLineToPoint:CGPointMake(100 + LineWidth, 100 + LineWidth)];
        [_wavePathHigh closePath];
    }
    return _wavePathHigh;
}

- (UIBezierPath *)wavePathComplete {
    
    if (!_wavePathComplete) {
        _wavePathComplete = [UIBezierPath new];
        [_wavePathComplete moveToPoint:CGPointMake(-LineWidth, 100 + LineWidth)];
        [_wavePathComplete addLineToPoint:CGPointMake(-LineWidth, - LineWidth)];
        [_wavePathComplete addLineToPoint:CGPointMake(100 + LineWidth, -LineWidth)];
        [_wavePathComplete addLineToPoint:CGPointMake(100 + LineWidth, 100 + LineWidth)];
        [_wavePathComplete closePath];
    }
    return _wavePathComplete;
}

- (void)showWaveLayerAnimation {
    
    //1
    CABasicAnimation *animation1 = [CABasicAnimation animationWithKeyPath:@"path"];
    animation1.fromValue = (__bridge id _Nullable)(self.wavePathPre.CGPath);
    animation1.toValue = (__bridge id _Nullable)(self.wavePathStarting.CGPath);
    animation1.beginTime = 0;
    animation1.duration = KAnimationDuration;
    
    //2
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"path"];
    animation2.fromValue = (__bridge id _Nullable)(self.wavePathStarting.CGPath);
    animation2.toValue = (__bridge id _Nullable)(self.wavePathLow.CGPath);
    animation2.beginTime = animation1.beginTime + animation1.duration;
    animation2.duration = KAnimationDuration;
    
    //3
    CABasicAnimation *animation3 = [CABasicAnimation animationWithKeyPath:@"path"];
    animation3.fromValue = (__bridge id _Nullable)(self.wavePathLow.CGPath);
    animation3.toValue = (__bridge id _Nullable)(self.wavePathMid.CGPath);
    animation3.beginTime = animation2.beginTime + animation2.duration;
    animation3.duration = KAnimationDuration;
    
    //4
    CABasicAnimation *animation4 = [CABasicAnimation animationWithKeyPath:@"path"];
    animation4.fromValue = (__bridge id _Nullable)(self.wavePathMid.CGPath);
    animation4.toValue = (__bridge id _Nullable)(self.wavePathHigh.CGPath);
    animation4.beginTime = animation3.beginTime + animation3.duration;
    animation4.duration = KAnimationDuration;
    
    //5
    CABasicAnimation *animation5 = [CABasicAnimation animationWithKeyPath:@"path"];
    animation5.fromValue = (__bridge id _Nullable)(self.wavePathHigh.CGPath);
    animation5.toValue = (__bridge id _Nullable)(self.wavePathComplete.CGPath);
    animation5.beginTime = animation4.beginTime + animation4.duration;
    animation5.duration = KAnimationDuration;
    
    //6
    CAAnimationGroup *group = [[CAAnimationGroup alloc] init];
    group.animations =@[animation1, animation2, animation3, animation4, animation5];
    group.duration = 5 * KAnimationDuration;
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    [self addAnimation:group forKey:nil];
}


@end
