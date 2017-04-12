//
//  CalendarHomeViewController.m
//  Demo测试
//
//  Created by vcyber on 16/7/1.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "CalendarHomeViewController.h"
#import "NSDate+CalendarLogic.h"
#import "CalendarLogic.h"

@interface CalendarHomeViewController () {
    
    int daynumber;//天数
    int optiondaynumber;//选择日期数量
}

@end

@implementation CalendarHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)setCalendarToDay:(int)day ToDateforString:(NSString *)today {
    
    daynumber = day;
    optiondaynumber = 1;
    super.calendarMonths = [self getMonthArrayOfDayNumber:daynumber ToDateforString:today];
    [super.collectionView reloadData];
}

//获取时间段内的天数数组
- (NSMutableArray *)getMonthArrayOfDayNumber:(int)day ToDateforString:(NSString *)todate
{
    
    NSDate *date = [NSDate date];
    
    NSDate *selectdate  = [NSDate date];
    
    if (todate) {
        
        selectdate = [selectdate dateFromString:todate];
        
    }
    
    super.logic = [[CalendarLogic alloc]init];
    
    return [super.logic reloadCalendarView:date selectDate:selectdate  needDays:day];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
