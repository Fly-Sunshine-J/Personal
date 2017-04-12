//
//  CircleLayer.m
//  BezierPath
//
//  Created by vcyber on 16/6/22.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "CircleLayer.h"
#import <UIKit/UIKit.h>

@interface CircleLayer ()

@property (nonatomic, strong) UIBezierPath *cicleSamllPath;
@property (nonatomic, strong) UIBezierPath *circleBigPath;
@property (nonatomic, strong) UIBezierPath *cicleVerticalSquishPath;
@property (nonatomic, strong) UIBezierPath *cicleHorizontalSquishPath;

@end

static const NSTimeInterval KAnimationDuration = 0.3;
static const NSTimeInterval KAnimationBeginTime = 0.0;

@implementation CircleLayer

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.fillColor = [UIColor cyanColor].CGColor;
        self.path = self.cicleSamllPath.CGPath;
    }
    return self;
}

- (UIBezierPath *)cicleSamllPath {
    
    if (!_cicleSamllPath) {
        _cicleSamllPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(50, 50, 0, 0)];
    }
    return _cicleSamllPath;
}

- (UIBezierPath *)circleBigPath {
    
    if (!_circleBigPath) {
        _circleBigPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(2.5, 2.5, 95.0, 95.0)];
    }
    return _circleBigPath;
}

- (UIBezierPath *)cicleVerticalSquishPath {
    
    if (!_cicleVerticalSquishPath) {
        _cicleVerticalSquishPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(2.5, 5, 95.0, 90)];
    }
    return _cicleVerticalSquishPath;
}

- (UIBezierPath *)cicleHorizontalSquishPath {
    
    if (!_cicleHorizontalSquishPath) {
        _cicleHorizontalSquishPath = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(5, 2.5, 90, 90)];
    }
    
    return _cicleHorizontalSquishPath;
}

- (void)wobbleAnimation {
    
    //1
    CABasicAnimation *annimation1 = [CABasicAnimation animationWithKeyPath:@"path"];
    annimation1.fromValue = (__bridge id _Nullable)(self.circleBigPath.CGPath);
    annimation1.toValue = (__bridge id _Nullable)(self.cicleVerticalSquishPath.CGPath);
    annimation1.beginTime = KAnimationBeginTime;
    annimation1.duration = KAnimationDuration;
    
    //2
    CABasicAnimation *annimation2 = [CABasicAnimation animationWithKeyPath:@"path"];
    annimation2.fromValue = (__bridge id _Nullable)(self.cicleVerticalSquishPath.CGPath);
    annimation2.toValue = (__bridge id _Nullable)(self.cicleHorizontalSquishPath.CGPath);
    annimation2.beginTime = annimation1.beginTime+KAnimationDuration;
    annimation2.duration = KAnimationDuration;
    
    //3
    CABasicAnimation *annimation3 = [CABasicAnimation animationWithKeyPath:@"path"];
    annimation3.fromValue = (__bridge id _Nullable)(self.cicleHorizontalSquishPath.CGPath);
    annimation3.toValue = (__bridge id _Nullable)(self.cicleVerticalSquishPath.CGPath);
    annimation3.beginTime = annimation2.beginTime+KAnimationDuration;
    annimation3.duration = KAnimationDuration;
    
    //4
    CABasicAnimation *annimation4 = [CABasicAnimation animationWithKeyPath:@"path"];
    annimation4.fromValue = (__bridge id _Nullable)(self.cicleVerticalSquishPath.CGPath);
    annimation4.toValue = (__bridge id _Nullable)(self.circleBigPath.CGPath);
    annimation4.beginTime = annimation3.beginTime+KAnimationDuration;
    annimation4.duration = KAnimationDuration;
    
    //5
    CAAnimationGroup *group = [[CAAnimationGroup alloc] init];
    group.animations = @[annimation1, annimation2, annimation3, annimation4];
    group.duration = 4 * KAnimationDuration;
    group.repeatCount = 2;
    [self addAnimation:group forKey:nil];
}

- (void)expand {
    
    CABasicAnimation *expandAnnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    expandAnnimation.fromValue = (__bridge id _Nullable)(self.cicleSamllPath.CGPath);
    expandAnnimation.toValue = (__bridge id _Nullable)(self.circleBigPath.CGPath);
    expandAnnimation.fillMode = kCAFillModeForwards;
    expandAnnimation.removedOnCompletion =NO;
    [self addAnimation:expandAnnimation forKey:nil];
}

- (void)contract {
    
    CABasicAnimation *contractAnnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    contractAnnimation.fromValue = (__bridge id _Nullable)(self.circleBigPath.CGPath);
    contractAnnimation.toValue = (__bridge id _Nullable)(self.cicleSamllPath.CGPath);
    contractAnnimation.fillMode = kCAFillModeForwards;
    contractAnnimation.removedOnCompletion = NO;
    [self addAnimation:contractAnnimation forKey:nil];
}

@end
