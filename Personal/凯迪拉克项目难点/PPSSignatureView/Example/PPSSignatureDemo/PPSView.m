//
//  PPSView.m
//  PPSSignatureDemo
//
//  Created by user_ on 2016/11/24.
//  Copyright © 2016年 Jason Harwig. All rights reserved.
//


static CGPoint midpoint(CGPoint p0, CGPoint p1) {
    return (CGPoint) {
        (p0.x + p1.x) / 2.0,
        (p0.y + p1.y) / 2.0
    };
}


#import "PPSView.h"


@interface PPSView()

@property (nonatomic, strong) UIBezierPath *bPath;

@end



@implementation PPSView
{
    CGPoint previousPoint;
}


- (void)awakeFromNib
{
    [super awakeFromNib];
    [self addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(erase)]];
}

- (UIImage *)getImageFromSignView {
    UIGraphicsBeginImageContext(self.frame.size);
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:NO];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    return image;
}

- (void)erase
{
    self.bPath = [UIBezierPath bezierPath];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    [[UIColor blackColor] setStroke];
    [self.bPath stroke];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    UITouch *curretTouch = [touches anyObject];
    CGPoint currentPoint = [curretTouch locationInView:self];
    previousPoint = currentPoint;
    [self.bPath moveToPoint:currentPoint];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint currentPoint = [[touches anyObject] locationInView:self];
    CGPoint midPoint = midpoint(previousPoint, currentPoint);
    [self.bPath addQuadCurveToPoint:midPoint controlPoint:previousPoint];
    previousPoint = currentPoint;
    [self setNeedsDisplay];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    CGPoint currentPoint = [[touches anyObject] locationInView:self];
    CGPoint midPoint = midpoint(previousPoint, currentPoint);
    [self.bPath addQuadCurveToPoint:midPoint controlPoint:previousPoint];
    previousPoint = currentPoint;
    [self setNeedsDisplay];
}

- (UIBezierPath *)bPath
{
    if (!_bPath) {
        _bPath = [UIBezierPath bezierPath];
    }
    return _bPath;
}


@end
