//
//  CalendarCollectionViewCell.h
//  Calendar
//
//  Created by vcyber on 17/5/16.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYWCalendarModel.h"

@interface CYWCalendarCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) CYWCalendarModel *model;

@property (nonatomic, copy) void(^selectDateCallBack)(CYWCalendarModel *);

@end
