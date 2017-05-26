//
//  CalendarModel.m
//  Calendar
//
//  Created by vcyber on 17/5/16.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import "CYWCalendarModel.h"

@implementation CYWCalendarModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _year = 0;
        _month = 0;
        _day = 0;
        _week = -1;
        _dateString = @"";
    }
    return self;
}


@end

@implementation CYWCalendarHeaderModel

@end
