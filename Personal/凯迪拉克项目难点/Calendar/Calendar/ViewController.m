//
//  ViewController.m
//  Calendar
//
//  Created by vcyber on 17/5/16.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import "ViewController.h"
#import "CYWCalendarView.h"
#import "Masonry.h"
#import <objc/runtime.h>

FOUNDATION_EXPORT NSNotificationName const AAA;
NSNotificationName const AAA = @"AAA";
@interface ViewController ()

@property (nonatomic, strong) CYWCalendarView *dayCalendar;
@property (nonatomic, strong) CYWCalendarView *monthCalendar;
@property (nonatomic, strong) CYWCalendarView *yearCalendar;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    NSLog(@"%@", AAA);
    
    _dayCalendar = [[CYWCalendarView alloc] initWithFrame:CGRectMake(20, 100, self.view.frame.size.width - 40, (self.view.frame.size.width - 40) / 7 * 6 + 80) CalendarType:CYWCalendarTypeOfDay];
    _dayCalendar.selectDateModelCallBack = ^(CYWCalendarModel *model) {
        NSLog(@"%@-%@-%@", @(model.year), @(model.month), @(model.day));
    };
    [self.view addSubview:_dayCalendar];
    
    _monthCalendar = [[CYWCalendarView alloc] initWithFrame:CGRectMake(20, 100, self.view.frame.size.width - 40, (self.view.frame.size.width - 40) / 7 * 6 + 80) CalendarType:CYWCalendarTypeOfMonth];
    _monthCalendar.hidden = YES;
    _monthCalendar.selectDateModelCallBack = ^(CYWCalendarModel *model) {
        NSLog(@"%@-%@", @(model.year), @(model.month));
    };
    [self.view addSubview:_monthCalendar];
    
    _yearCalendar = [[CYWCalendarView alloc] initWithFrame:CGRectMake(20, 100, self.view.frame.size.width - 40, (self.view.frame.size.width - 40) / 7 * 6 + 80) CalendarType:CYWCalendarTypeOfYear];
    _yearCalendar.hidden = YES;
    _yearCalendar.selectDateModelCallBack = ^(CYWCalendarModel *model) {
        NSLog(@"%@", @(model.year));
    };
    [self.view addSubview:_yearCalendar];
    
    
}

- (IBAction)showDay:(id)sender {
    _dayCalendar.hidden = NO;
    _monthCalendar.hidden = YES;
    _yearCalendar.hidden = YES;
}
- (IBAction)showMonth:(id)sender {
    _dayCalendar.hidden = YES;
    _monthCalendar.hidden = NO;
    _yearCalendar.hidden = YES;
}
- (IBAction)showYear:(id)sender {
    _dayCalendar.hidden = YES;
    _monthCalendar.hidden = YES;
    _yearCalendar.hidden = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
