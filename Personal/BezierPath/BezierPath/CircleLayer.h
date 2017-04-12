//
//  CircleLayer.h
//  BezierPath
//
//  Created by vcyber on 16/6/22.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

@interface CircleLayer : CAShapeLayer

/**
 *  摆动动画组
 */
- (void)wobbleAnimation;

/**
 *  放大动画
 */
- (void)expand;

/**
 *  缩小动画
 */
- (void)contract;

@end
