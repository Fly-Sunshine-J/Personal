//
//  CalendarDayModel.h
//  Demo测试
//
//  Created by vcyber on 16/7/1.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, CellDayType) {
    CellDayTypeEmpty,
    CellDayTypePast,
    CellDayTypeFuture,
    CellDayTypeWeek,
    CellDayTypeSelected,
};

@interface CalendarDayModel : NSObject

@property (nonatomic, assign) CellDayType type;

@property (nonatomic, assign) NSUInteger day;//天
@property (nonatomic, assign) NSUInteger month;//月
@property (nonatomic, assign) NSUInteger year;//年
@property (nonatomic, assign) NSUInteger week;//周

@property (nonatomic, strong) NSString *Chinese_calendar;//农历
@property (nonatomic, strong) NSString *holiday;//节日

+ (instancetype)calendarDayWithYear:(NSUInteger)year month:(NSUInteger)month day:(NSUInteger)day;
- (NSDate *)date;//返回当前NSDate对象
- (NSString *)toString;//返回当前天的NSString对象
- (NSString *)getWeek;//返回星期

@end
