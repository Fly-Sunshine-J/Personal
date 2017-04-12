//
//  NSDate+CalendarLogic.h
//  Demo测试
//
//  Created by vcyber on 16/7/1.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (CalendarLogic)

- (NSUInteger)numberOfDaysInCurrentMonth;//这个月的天数

- (NSUInteger)numberOfWeeksInCurrentMonth;//这个月的周数

- (NSUInteger)weeklyOrdinality;//计算这个月的第一天是礼拜几

- (NSDate *)firstDayOfCurrentMonth;//这个月第一天的时间

- (NSDate *)lastDayOfCurrentMonth;//这个月最后一天的时间

- (NSDate *)dayInThePreviousMonth;//上个月

- (NSDate *)dayInTheFollowingMonth;//下个月

- (NSDate *)dayInTheFollowingMonth:(int)month;//获取当前日期之后的几个月

- (NSDate *)dayInTheFollowingDay:(int)day;//获取当前日期之后的几个天

- (NSDateComponents *)YMDComponents;//获取年月日对象

- (NSDate *)dateFromString:(NSString *)dateString;//NSString转NSDate

- (NSString *)stringFromDate:(NSDate *)dat;//NSDate转NSString

+ (NSUInteger)getDayNumbertoDay:(NSDate *)today beforDay:(NSDate *)beforday;

- (NSUInteger)getWeekIntValueWithDate;



//判断日期是今天,明天,后天,周几
-(NSString *)compareIfTodayWithDate;
//通过数字返回星期几
+(NSString *)getWeekStringFromInteger:(int)week;

@end
