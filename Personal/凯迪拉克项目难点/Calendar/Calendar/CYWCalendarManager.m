//
//  CalendarManager.m
//  Calendar
//
//  Created by vcyber on 17/5/16.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import "CYWCalendarManager.h"
#import "CYWCalendarModel.h"

#define YEAR 2016
#define MONTH 2
#define DAY 24

@interface CYWCalendarManager ()

@property (nonatomic, strong) NSDate *todayDate;
@property (nonatomic,strong)NSDateComponents *todayCompontents;
@property (nonatomic,strong)NSCalendar *greCalendar;
@property (nonatomic, strong) NSDateFormatter *formatter;

@property (nonatomic, strong) NSDate *startDate;

@end

@implementation CYWCalendarManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        _formatter = [[NSDateFormatter alloc] init];
        _greCalendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
        _todayDate = [NSDate date];
        _todayCompontents = [self dateToComponents:_todayDate];
    }
    return self;
}



- (NSArray<CYWCalendarHeaderModel *> *)getCalendarDataSourceWithType:(CYWCalendarType)type{
    NSMutableArray *result = [NSMutableArray array];
    NSDateComponents *component = [self dateToComponents:_todayDate];
    component.day = 1;
    NSInteger yearSpace = component.year - YEAR;
    NSInteger monthSpace = yearSpace * 12 + _todayCompontents.month - MONTH + 1;
    
    if (type == CYWCalendarTypeOfDay) {
        component.month -= monthSpace;
        for (int i = 0; i < monthSpace; i++) {
            component.month ++;
            CYWCalendarHeaderModel *model = [[CYWCalendarHeaderModel alloc] init];
            NSDate *date = [self componentsToDate:component];
            [_formatter setDateFormat:@"yyyy年MM月"];
            NSString *dateString = [_formatter stringFromDate:date];
            model.headerText = dateString;
            model.calendarItemArray = [self getCalendarItemArrayWithDate:date];
            [result addObject:model];
        }
    }else if (type == CYWCalendarTypeOfMonth){
        for (int i = 0; i < yearSpace + 1; i++) {
            CYWCalendarHeaderModel *model = [[CYWCalendarHeaderModel alloc] init];
            model.headerText = [NSString stringWithFormat:@"%@年", @(YEAR + i)];
            
            NSMutableArray *months = [NSMutableArray array];
            
            for (int j = 1; j <= 16; j++) {
                CYWCalendarModel *calendarModel = [[CYWCalendarModel alloc] init];
                calendarModel.year = YEAR + i;
                calendarModel.month = j - j / 4;
                if (j % 4 == 0) {
                    calendarModel.dateString = @"";
                }else {
                    calendarModel.dateString = @(j - j / 4).stringValue;
                }
                [months addObject:calendarModel];
            }
            model.calendarItemArray = months;
            [result addObject:model];
        }
    }else {
//        NSInteger section = (yearSpace + 1) / 4 + ((yearSpace + 1) % 4 == 0 ? 0 : 1);
        NSInteger section = 5;
        for (int i = 0; i < section; i++) {
            CYWCalendarHeaderModel *model = [[CYWCalendarHeaderModel alloc] init];
            model.headerText = @"年份";
            NSMutableArray *years = [NSMutableArray array];
            for (int j = i * 4; j < (i + 1) * 4; j++) {
                CYWCalendarModel *calendarModel = [[CYWCalendarModel alloc] init];
                calendarModel.year = 2017 + j;
                calendarModel.dateString = @(2017 + j).stringValue;
                [years addObject:calendarModel];
            }
            model.calendarItemArray = years;
            [result addObject:model];
        }
    }
    
    return result;
}


- (NSArray<CYWCalendarModel *> *)getCalendarItemArrayWithDate:(NSDate *)date {
    NSMutableArray *resultArray = [NSMutableArray array];
    NSInteger totalDay = [self numberOfDayInCurrentMonth:date];
    NSInteger firstDay = [self firstDayOfWeek:date];
    if (firstDay == 1) {
        firstDay = 7;
    }else {
        firstDay--;
    }
    NSDateComponents *components = [self dateToComponents:date];
    
    NSInteger tempDay = totalDay + firstDay - 1;
    components.day = 0;
    
    for (int i = 0; i < 6; i++) {
        for (int j = 1; j < 8; j++) {
            if (i == 0 && j < firstDay) {
                CYWCalendarModel *blankModel = [[CYWCalendarModel alloc] init];
                [resultArray addObject:blankModel];
                continue;
            }
            
            if (components.day == totalDay) {
                for (int k = 0; k < 42 - tempDay; k++) {
                    CYWCalendarModel *blankModel = [[CYWCalendarModel alloc] init];
                    [resultArray addObject:blankModel];
                }
                i = 6;
                break;
            }
            components.day += 1;
            CYWCalendarModel *model = [[CYWCalendarModel alloc] init];
            model.year = components.year;
            model.month = components.month;
            model.day = components.day;
            model.week = j;
            [resultArray addObject:model];
            if (_todayCompontents.year == components.year &&
                _todayCompontents.month == components.month &&
                _todayCompontents.day == components.day) {
                model.dateString = @"今天";
            }else {
                model.dateString = @(components.day).stringValue;
            }
            
        }
    }
    return resultArray;
}


/**
 一个月有多少天

 @param date 日期
 @return 天数
 */
- (NSUInteger)numberOfDayInCurrentMonth:(NSDate *)date {
    return [_greCalendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date].length;
}


/**
 日期对应月的第一天是星期几

 @param date 日期
 @return 星期几
 */
- (NSUInteger)firstDayOfWeek:(NSDate *)date {
    NSDate *firstDate = nil;
    BOOL result = [_greCalendar rangeOfUnit:NSCalendarUnitDay startDate:&firstDate interval:NULL forDate:date];
    if (result) {
        return [_greCalendar ordinalityOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitWeekOfMonth forDate:firstDate];
    }
    return 0;
}


#pragma mark NSDate和NSCompontents转换
- (NSDateComponents *)dateToComponents:(NSDate *)date
{
    NSDateComponents *components = [_greCalendar components:(NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return components;
}

- (NSDate *)componentsToDate:(NSDateComponents *)components
{
    // 不区分时分秒
    components.hour = 0;
    components.minute = 0;
    components.second = 0;
    NSDate *date = [_greCalendar dateFromComponents:components];
    return date;
}

@end
