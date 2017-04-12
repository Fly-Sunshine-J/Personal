//
//  AnimationView.m
//  BezierPath
//
//  Created by vcyber on 16/6/22.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "AnimationView.h"
#import "CircleLayer.h"
#import "TriangleLayer.h"
#import "RectangleLayer.h"
#import "WaveLayer.h"

@interface AnimationView ()

@property (nonatomic, strong) CircleLayer *cirleLayer;
@property (nonatomic, strong) TriangleLayer *triangleLayer;
@property (nonatomic, strong) RectangleLayer *rectagleLayer;
@property (nonatomic, strong) WaveLayer *waveLayer;

@end

@implementation AnimationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self addCicleLayer];
    }
    return self;
}


- (void)addCicleLayer {
    [self.layer addSublayer:self.cirleLayer];
    [self.cirleLayer expand];
    [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(wobbleCirleLayer) userInfo:nil repeats:NO];
}

- (void)wobbleCirleLayer {
    [_cirleLayer wobbleAnimation];
    [self.layer addSublayer:self.triangleLayer];
    [NSTimer scheduledTimerWithTimeInterval:0.9 target:self selector:@selector(showTriangleAnimation) userInfo:nil repeats:NO];
}

- (void)showTriangleAnimation {
    [_triangleLayer triangleAnimation];
    [NSTimer scheduledTimerWithTimeInterval:0.9 target:self selector:@selector(rolling) userInfo:nil repeats:NO];
}

- (void)rolling {
    
    [self rollingZ];
    [_cirleLayer contract];
    [NSTimer scheduledTimerWithTimeInterval:0.4 target:self selector:@selector(rectangleAnimation) userInfo:nil repeats:NO];
}

- (void)rollingZ {
    
    CABasicAnimation *rotationZ = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationZ.toValue = @(M_PI * 2);
    rotationZ.duration = 0.5;
    rotationZ.removedOnCompletion = YES;
    [self.layer addAnimation:rotationZ forKey:nil];
}

- (void)rectangleAnimation {
    
    [self.layer addSublayer:self.rectagleLayer];
    [self.rectagleLayer showRectangleLayerAnimationWithStrokeColor:[UIColor yellowColor]];
    [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(waveAnimation) userInfo:nil repeats:NO];
}

- (void)waveAnimation {
    [self.layer addSublayer:self.waveLayer];
    [self.waveLayer showWaveLayerAnimation];
    [NSTimer scheduledTimerWithTimeInterval:0.8 target:self selector:@selector(expandView) userInfo:nil repeats:NO];
}

- (void)expandView {
    
    self.backgroundColor = [UIColor colorWithRed:50 / 255.0 green:220 / 255.0 blue:158 / 255.0 alpha:1];
    self.frame = CGRectMake(self.frame.origin.x - self.rectagleLayer.lineWidth, self.frame.origin.y - self.rectagleLayer.lineWidth, self.frame.size.width + self.rectagleLayer.lineWidth * 2, self.rectagleLayer.lineWidth * 2 + self.frame.size.height);
    self.layer.sublayers = nil;
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
       
        self.frame = [UIScreen mainScreen].bounds;
        
    } completion:^(BOOL finished) {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(completeAnimation)]) {
            [self.delegate completeAnimation];
        }
    }];
}



- (CircleLayer *)cirleLayer {
    
    if (!_cirleLayer) {
        _cirleLayer = [[CircleLayer alloc] init];
    }
    return _cirleLayer;
}

- (TriangleLayer *)triangleLayer {
    
    if (!_triangleLayer) {
        _triangleLayer = [[TriangleLayer alloc] init];
    }
    return _triangleLayer;
}

- (RectangleLayer *)rectagleLayer {
    
    if (!_rectagleLayer) {
        _rectagleLayer = [RectangleLayer new];
    }
    return _rectagleLayer;
}

- (WaveLayer *)waveLayer {
    
    if (!_waveLayer) {
        _waveLayer = [[WaveLayer alloc] init];
    }
    return _waveLayer;
}

@end
