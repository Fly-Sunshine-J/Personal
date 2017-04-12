//
//  CicleProgressView.h
//  Demo测试
//
//  Created by vcyber on 16/6/27.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CircleProgressDelegate <NSObject>

- (void)CircleProgressEnd;

@end

@interface CicleProgressView : UIView

- (instancetype)initWithFrame:(CGRect)frame andCicleRadius:(CGFloat)radius;

- (void)setTotalSecondTime:(CGFloat)time;

- (void)startTimer;
- (void)pauseTimer;
- (void)stopTimer;

@property (nonatomic, weak) id<CircleProgressDelegate>delegate;

@end
