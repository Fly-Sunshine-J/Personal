//
//  TimerView.m
//  Demo测试
//
//  Created by vcyber on 16/7/1.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "TimerView.h"

#define RADISU self.frame.size.width / 2 

@interface TimerView ()


@end

@implementation TimerView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        [self start];
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    
    UIImage *image = [UIImage imageNamed:@"timer"];
    [image drawInRect:rect];
    
    NSDate *nowDate              = [NSDate date];
    NSCalendar *calendar         = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond  fromDate:nowDate];
    NSInteger hour               = components.hour >= 12 ? components.hour - 12 : components.hour;
    NSInteger minute             = components.minute;
    NSInteger second             = components.second;
//    NSLog(@"H:%zd , M:%zd, S:%zd", hour, minute, second);

    UIBezierPath *ciclePath      = [UIBezierPath bezierPathWithArcCenter:CGPointMake(RADISU, RADISU) radius:RADISU startAngle:0 endAngle:2 *M_PI clockwise:YES];
    [ciclePath stroke];

    UIBezierPath *hourPath       = [UIBezierPath bezierPath];
    [hourPath moveToPoint:CGPointMake(RADISU, RADISU)];
    [hourPath addLineToPoint:[self getPointWithAngle:(hour * 60 * 60 + minute * 60 + second)  * 2 * M_PI / (12 * 60 * 60) - M_PI_2 Radius:RADISU - 50]];
    hourPath.lineWidth           = 2;
    [hourPath stroke];

    UIBezierPath *minutePath     = [UIBezierPath bezierPath];
    [minutePath moveToPoint:CGPointMake(RADISU, RADISU)];
    [minutePath addLineToPoint:[self getPointWithAngle:(minute * 60 + second)  * 2 * M_PI / (60 * 60) - M_PI_2 Radius:RADISU - 30]];
    minutePath.lineWidth         = 3;
    [[UIColor yellowColor] setStroke];
    [minutePath stroke];

    UIBezierPath *secondPath     = [UIBezierPath bezierPath];
    [secondPath moveToPoint:CGPointMake(RADISU, RADISU)];
    [secondPath addLineToPoint:[self getPointWithAngle:(second)  * 2 * M_PI / (60) - M_PI_2 Radius:RADISU]];
    secondPath.lineWidth         = 2;
    [[UIColor purpleColor] setStroke];
    [secondPath stroke];
    
 
}

- (CGPoint)getPointWithAngle:(CGFloat)angle Radius:(CGFloat)radius{
    
    CGFloat y = radius * sin(angle);
    CGFloat x= radius *cos(angle);
    CGPoint position = CGPointMake(RADISU, RADISU);
    position.x += x;
    position.y += y;
    return position;
    
}


- (void)start {
    
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(refresh) userInfo:nil repeats:YES];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
}

- (void)refresh {
    
    [self setNeedsDisplay];
}

@end
