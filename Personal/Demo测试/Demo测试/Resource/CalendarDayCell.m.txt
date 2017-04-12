//
//  CalendarDayCell.m
//  Demo测试
//
//  Created by vcyber on 16/7/1.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "CalendarDayCell.h"
#import "CalendarDayModel.h"

#define COLOR_THEME1 ([UIColor redColor])//大红色
#define COLOR_THEME ([UIColor colorWithRed:26/256.0  green:168/256.0 blue:186/256.0 alpha:1])//去哪儿绿

@interface CalendarDayCell () {
    UILabel *day_lab;//今天的日期或者是节日
    UILabel *day_title;//显示标签
    UIImageView *imgview;//选中时的图片
}

@end

@implementation CalendarDayCell


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUI];
//        self.backgroundColor = [UIColor redColor];
    }
    return self;
}


- (void)setUI {
    
    imgview = [[UIImageView alloc] initWithFrame:CGRectMake(5, 15, self.bounds.size.width - 10, self.bounds.size.width - 10)];
    imgview.image = [UIImage imageNamed:@"chack"];
    [self addSubview:imgview];
    
    day_lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 15, self.bounds.size.width, self.bounds.size.width - 10)];
    day_lab.textAlignment = NSTextAlignmentCenter;
    day_lab.font = [UIFont systemFontOfSize:14];
    [self addSubview:day_lab];
    
    day_title = [[UILabel alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 13, self.bounds.size.width, 13)];
    day_title.textColor = [UIColor lightGrayColor];
    day_title.font = [UIFont boldSystemFontOfSize:10];
    day_title.textAlignment = NSTextAlignmentCenter;
    [self addSubview:day_title];
    
}


- (void)setModel:(CalendarDayModel *)model {
    
    switch (model.type) {
        case CellDayTypeEmpty:
            [self hidden_YES];
            break;
        case CellDayTypePast:
            [self hidden_NO];
            if (model.holiday) {
                day_lab.text = model.holiday;
            }else {
                day_lab.text = [NSString stringWithFormat:@"%zd", model.day];
            }
            day_lab.textColor = [UIColor lightGrayColor];
            day_title.text = model.Chinese_calendar;
            imgview.hidden = YES;
            break;
        case CellDayTypeFuture:
            [self hidden_NO];
            if (model.holiday) {
                day_lab.text = model.holiday;
                day_lab.textColor = [UIColor orangeColor];
            }else {
                day_lab.text = [NSString stringWithFormat:@"%zd", model.day];
                day_lab.textColor = COLOR_THEME;
            }
            day_title.text = model.Chinese_calendar;
            imgview.hidden = YES;
            break;
        case CellDayTypeWeek:
            [self hidden_NO];
            if (model.holiday) {
                day_lab.text = model.holiday;
                day_lab.textColor = [UIColor orangeColor];
            }else {
                day_lab.text = [NSString stringWithFormat:@"%zd", model.day];
                day_lab.textColor = COLOR_THEME1;
            }
            day_title.text = model.Chinese_calendar;
            imgview.hidden = YES;
            break;
        case CellDayTypeSelected:
            [self hidden_NO];
            day_lab.text = [NSString stringWithFormat:@"%zd", model.day];
            day_lab.textColor = [UIColor whiteColor];
            day_title.text = model.Chinese_calendar;
            imgview.hidden = NO;
            break;
            
        default:
            break;
    }
}

- (void)hidden_YES{
    
    day_lab.hidden = YES;
    day_title.hidden = YES;
    imgview.hidden = YES;
    
}


- (void)hidden_NO{
    
    day_lab.hidden = NO;
    day_title.hidden = NO;
    
}


@end
