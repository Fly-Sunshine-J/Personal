//
//  CalendarDayModel.m
//  Demo测试
//
//  Created by vcyber on 16/7/1.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "CalendarDayModel.h"
#import "NSDate+CalendarLogic.h"

@implementation CalendarDayModel

+ (instancetype)calendarDayWithYear:(NSUInteger)year month:(NSUInteger)month day:(NSUInteger)day {
    
    CalendarDayModel *model = [[CalendarDayModel alloc] init];
    model.year = year;
    model.month = month;
    model.day = day;
    
    return model;
}

//返回当天的NSDate对象
- (NSDate *)date {
    
    NSDateComponents *components = [[NSDateComponents alloc] init];
    components.day = self.day;
    components.month = self.month;
    components.year = self.year;
    
    return [[NSCalendar currentCalendar] dateFromComponents:components];
}


//返回当天的字符串对象
- (NSString *)toString {
    
    NSDate *date  = [self date];
    NSString *str = [date stringFromDate:date];
    return str;
}

- (NSString *)getWeek {
    
    NSDate *date = [self date];
    return [date compareIfTodayWithDate];
}

@end
