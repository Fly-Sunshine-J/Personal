//
//  RectangleLayer.m
//  BezierPath
//
//  Created by vcyber on 16/6/22.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "RectangleLayer.h"


@interface RectangleLayer ()

@property (nonatomic, strong) UIBezierPath *rectanglePath;

@end

static const CGFloat LineWidth = 5;

@implementation RectangleLayer

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.fillColor = [UIColor clearColor].CGColor;
        self.lineWidth = 5;
        self.path = self.rectanglePath.CGPath;
    }
    return self;
}

- (UIBezierPath *)rectanglePath {
    if (!_rectanglePath) {
        _rectanglePath = [UIBezierPath new];
        [_rectanglePath moveToPoint:CGPointMake(-LineWidth, -LineWidth)];
        [_rectanglePath addLineToPoint:CGPointMake(100+LineWidth, -LineWidth)];
        [_rectanglePath addLineToPoint:CGPointMake(100+LineWidth, 100+LineWidth)];
        [_rectanglePath addLineToPoint:CGPointMake(-LineWidth, 100 + LineWidth)];
        [_rectanglePath closePath];
    }
    return _rectanglePath;
}

- (void)showRectangleLayerAnimationWithStrokeColor:(UIColor *)color {
    self.strokeColor = color.CGColor;
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue = @0;
    animation.toValue = @1;
    animation.duration = 0.4;
    [self addAnimation:animation forKey:nil];
}

@end
