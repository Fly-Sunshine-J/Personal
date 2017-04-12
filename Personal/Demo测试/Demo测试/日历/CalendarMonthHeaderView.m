//
//  CalendarMonthHeaderView.m
//  Demo测试
//
//  Created by vcyber on 16/7/1.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "CalendarMonthHeaderView.h"


#define COLOR_THEME1 ([UIColor redColor])//大红色
#define COLOR_THEME ([UIColor colorWithRed:26/256.0  green:168/256.0 blue:186/256.0 alpha:1])//去哪儿绿

#define CATDayLabelWidth  40.0f
#define CATDayLabelHeight 20.0f

@interface CalendarMonthHeaderView ()

@end

@implementation CalendarMonthHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}


- (void)createUI {
    
    CGFloat Width =  [UIScreen mainScreen].bounds.size.width;
    
    self.clipsToBounds = YES;
    self.masterLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, Width,30)];
    self.masterLabel.backgroundColor = [UIColor clearColor];
    self.masterLabel.textAlignment = NSTextAlignmentCenter;
    self.masterLabel.textColor = COLOR_THEME;
    [self addSubview:self.masterLabel];
    
    NSArray *nameArray = @[@"日", @"一", @"二", @"三", @"四", @"五", @"六"];
    
    CGFloat padding = (Width - CATDayLabelWidth * nameArray.count) / (nameArray.count + 1);
    
    for (int i = 0; i < nameArray.count; i++) {
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(padding + i * (padding + CATDayLabelWidth), 45, CATDayLabelWidth, CATDayLabelHeight)];
        label.backgroundColor = [UIColor clearColor];
        label.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:15];
        label.textAlignment = NSTextAlignmentCenter;
        if (i == 0 || i == 6) {
            label.textColor = COLOR_THEME1;
        }else {
            label.textColor = COLOR_THEME;
        }
        label.text = nameArray[i];
        [self addSubview:label];
        
    }
}


@end
