//
//  Scratch.m
//  Demo测试
//
//  Created by vcyber on 16/7/6.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "ScratchView.h"

@interface ScratchView ()

@property (nonatomic, strong) CALayer *maskLayer;
@property (nonatomic, assign) CGPoint startPoint;

@end

@implementation ScratchView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor greenColor];
        CAShapeLayer *layer = [CAShapeLayer layer];
        self.layer.mask = layer;
        self.scratchLineWidth = 15;
    }
    return self;
}

- (void)setText:(NSString *)text {
    _text = text;
    UILabel *label = [[UILabel alloc] initWithFrame:self.bounds];
    label.text = text;
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.startPoint = [[touches anyObject] locationInView:self];
}

- (void) touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint piont = [[touches anyObject] locationInView:self];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = [self createPathWithPointA:self.startPoint AndPointB:piont].CGPath;
    [self.maskLayer addSublayer:layer];
    self.layer.mask = self.maskLayer;
    self.startPoint = piont;
}

- (void) touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint piont = [[touches anyObject] locationInView:self];
    
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.path = [self createPathWithPointA:self.startPoint AndPointB:piont].CGPath;
    [self.maskLayer addSublayer:layer];
    self.layer.mask = self.maskLayer;
}

- (UIBezierPath *)createPathWithPointA:(CGPoint)a AndPointB:(CGPoint)b {
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    UIBezierPath *path1 = [UIBezierPath bezierPathWithArcCenter:a radius:self.scratchLineWidth startAngle:[self getAngleBetweenPointA:a AndPonitb:b] + M_PI_2 endAngle:[self getAngleBetweenPointA:a AndPonitb:b] + M_PI_2 + M_PI clockwise:b.x >= a.x];
    [path appendPath:path1];
    UIBezierPath *path2 = [UIBezierPath bezierPathWithArcCenter:b radius:self.scratchLineWidth  startAngle:[self getAngleBetweenPointA:a AndPonitb:b] - M_PI_2 endAngle:[self getAngleBetweenPointA:a AndPonitb:b] + M_PI_2 clockwise:b.x >= a.x];
    [path addLineToPoint:CGPointMake(b.x * 2 - path2.currentPoint.x, b.y * 2- path2.currentPoint.y)];
    [path appendPath:path2];
    [path addLineToPoint:CGPointMake(a.x * 2 - path1.currentPoint.x, a.y * 2 - path1.currentPoint.y)];
    [path closePath];
    return path;
    
}


- (CGFloat )getAngleBetweenPointA:(CGPoint)a AndPonitb:(CGPoint)b {
    
    if (a.y == b.y) {
        return M_PI;
    }
    
    if (a.x == b.x) {
        return M_PI_2;
    }
    
    return atan((a.y - b.y) / (a.x - b.x));
    
}

- (CALayer *)maskLayer {
    
    if (!_maskLayer) {
        _maskLayer = [CALayer layer];
    }
    return _maskLayer;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
