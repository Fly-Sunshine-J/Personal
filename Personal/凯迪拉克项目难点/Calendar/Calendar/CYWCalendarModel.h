//
//  CalendarModel.h
//  Calendar
//
//  Created by vcyber on 17/5/16.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CYWCalendarModel;

@interface CYWCalendarHeaderModel : NSObject

@property (nonatomic,copy)NSString *headerText;
@property (nonatomic,strong)NSArray<CYWCalendarModel *> *calendarItemArray;

@end

@interface CYWCalendarModel : NSObject

@property (nonatomic,assign)NSInteger year;
@property (nonatomic,assign)NSInteger month;
@property (nonatomic,assign)NSInteger day;
@property (nonatomic,assign)NSInteger week;// 星期
@property (nonatomic, strong) NSString *dateString;

@end


