//
//  CalendarView.h
//  Calendar
//
//  Created by vcyber on 17/5/16.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYWCalendarManager.h"
#import "CYWCalendarModel.h"

@interface CYWCalendarView : UIView

- (instancetype)initWithFrame:(CGRect)frame CalendarType:(CYWCalendarType)type;

@property (nonatomic, copy) void(^selectDateModelCallBack)(CYWCalendarModel *);

@end
