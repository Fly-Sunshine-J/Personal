//
//  CalendarManager.h
//  Calendar
//
//  Created by vcyber on 17/5/16.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CYWCalendarHeaderModel;

typedef NS_ENUM(NSInteger, CYWCalendarType) {
    CYWCalendarTypeOfDay,
    CYWCalendarTypeOfMonth,
    CYWCalendarTypeOfYear,
};

@interface CYWCalendarManager : NSObject

/**
 获取日历
 */
- (NSArray<CYWCalendarHeaderModel *> *)getCalendarDataSourceWithType:(CYWCalendarType)type;



@end
