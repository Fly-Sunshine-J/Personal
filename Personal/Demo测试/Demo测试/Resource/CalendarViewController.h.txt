//
//  CalendarViewController.h
//  Demo测试
//
//  Created by vcyber on 16/7/1.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CalendarDayModel;
@class CalendarLogic;

typedef void(^CalendarBlock)(CalendarDayModel *model);

@interface CalendarViewController : UIViewController

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *calendarMonths;
@property (nonatomic, strong) CalendarLogic *logic;
@property (nonatomic, strong) CalendarBlock calendarBlock;

@end
