//
//  TriangleLayer.m
//  BezierPath
//
//  Created by vcyber on 16/6/22.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "TriangleLayer.h"
#import <UIKit/UIKit.h>

@interface TriangleLayer ()

@property (nonatomic, strong) UIBezierPath *smallTrianglePath;
@property (nonatomic, strong) UIBezierPath *topTrianglePath;
@property (nonatomic, strong) UIBezierPath *leftTrianglePath;
@property (nonatomic, strong) UIBezierPath *rightTrianglePath;

@end

@implementation TriangleLayer
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.fillColor = [UIColor cyanColor].CGColor;
        self.strokeColor = [UIColor cyanColor].CGColor;
        self.lineWidth = 7.0;
        self.lineCap = kCALineCapRound;
        self.lineJoin = kCALineJoinRound;
        self.path = self.smallTrianglePath.CGPath;
    }
    return self;
}

- (UIBezierPath *)smallTrianglePath {
    
    if (!_smallTrianglePath) {
        _smallTrianglePath = [[UIBezierPath alloc] init];
        [_smallTrianglePath moveToPoint:CGPointMake(50, 10)];
        [_smallTrianglePath addLineToPoint:CGPointMake(25, 80)];
        [_smallTrianglePath addLineToPoint:CGPointMake(75, 80)];
        [_smallTrianglePath closePath];
    }
    
    return _smallTrianglePath;
}


- (UIBezierPath *)topTrianglePath {
    
    if (!_topTrianglePath) {
        _topTrianglePath = [[UIBezierPath alloc] init];
        [_topTrianglePath moveToPoint:CGPointMake(50, 0)];
        [_topTrianglePath addLineToPoint:CGPointMake(20, 80)];
        [_topTrianglePath addLineToPoint:CGPointMake(80, 80)];
        [_topTrianglePath closePath];
    }
    return _topTrianglePath;
}

- (UIBezierPath *)leftTrianglePath {
    
    if (!_leftTrianglePath) {
        _leftTrianglePath = [[UIBezierPath alloc] init];
        [_leftTrianglePath moveToPoint:CGPointMake(50, 0)];
        [_leftTrianglePath addLineToPoint:CGPointMake(0, 80)];
        [_leftTrianglePath addLineToPoint:CGPointMake(80, 80)];
        [_leftTrianglePath closePath];
    }
    return _leftTrianglePath;
}

- (UIBezierPath *)rightTrianglePath {
    
    if (!_rightTrianglePath) {
        _rightTrianglePath = [[UIBezierPath alloc] init];
        [_rightTrianglePath moveToPoint:CGPointMake(50, 0)];
        [_rightTrianglePath addLineToPoint:CGPointMake(0, 80)];
        [_rightTrianglePath addLineToPoint:CGPointMake(100, 80)];
        [_rightTrianglePath closePath];
    }
    return _rightTrianglePath;
}

- (void)triangleAnimation {
    //top
    CABasicAnimation *animation1 =[CABasicAnimation animationWithKeyPath:@"path"];
    animation1.fromValue = (__bridge id _Nullable)(self.smallTrianglePath.CGPath);
    animation1.toValue = (__bridge id _Nullable)(self.topTrianglePath.CGPath);
    animation1.beginTime = 0;
    animation1.duration = 0.3;
    
    //left
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"path"];
    animation2.fromValue = (__bridge id _Nullable)(self.topTrianglePath.CGPath);
    animation2.toValue = (__bridge id _Nullable)(self.leftTrianglePath.CGPath);
    animation2.beginTime = animation1.beginTime + animation1.duration;
    animation2.duration = 0.25;
    
    //right
    CABasicAnimation *animation3 = [CABasicAnimation animationWithKeyPath:@"path"];
    animation3.fromValue = (__bridge id _Nullable)(self.leftTrianglePath.CGPath);
    animation3.toValue = (__bridge id _Nullable)(self.rightTrianglePath.CGPath);
    animation3.beginTime = animation2.beginTime + animation2.duration;
    animation3.duration = 0.2;
    
    //group
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.animations = @[animation1, animation2, animation3];
    group.duration = animation1.duration + animation2.duration + animation3.duration;
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    [self addAnimation:group forKey:nil];
}


@end
