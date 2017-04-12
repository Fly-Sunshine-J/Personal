//
//  ShowCalendarViewController.m
//  Demo测试
//
//  Created by vcyber on 16/7/1.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "ShowCalendarViewController.h"
#import "CalendarHomeViewController.h"
#import "CalendarDayModel.h"

@interface ShowCalendarViewController ()

@property (nonatomic, strong) CalendarHomeViewController *chvc;

@end

@implementation ShowCalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.SourceArray = [NSMutableArray arrayWithObjects:@[@"CalendarHomeViewController.h", @"DemoSourceViewController"], @[@"CalendarHomeViewController.m", @"DemoSourceViewController"], @[@"CalendarViewController.h", @"DemoSourceViewController"], @[@"CalendarViewController.m", @"DemoSourceViewController"],@[@"CalendarDayModel.h", @"DemoSourceViewController"], @[@"CalendarDayModel.m", @"DemoSourceViewController"], @[@"CalendarLogic.h", @"DemoSourceViewController"], @[@"CalendarLogic.m", @"DemoSourceViewController"], @[@"CalendarMonthLayout.h", @"DemoSourceViewController"], @[@"CalendarMonthLayout.m", @"DemoSourceViewController"], @[@"CalendarDayCell.h", @"DemoSourceViewController"], @[@"CalendarDayCell.m", @"DemoSourceViewController"], @[@"CalendarMonthHeaderView.h", @"DemoSourceViewController"], @[@"CalendarMonthHeaderView.m", @"DemoSourceViewController"], @[@"NSDate+CalendarLogic.h", @"DemoSourceViewController"], @[@"NSDate+CalendarLogic.m", @"DemoSourceViewController"], nil];
    
}
- (IBAction)btnClik:(UIButton *)sender {
    
    if (!_chvc) {
        _chvc = [[CalendarHomeViewController alloc] init];
        [_chvc setCalendarToDay:365 * 5 ToDateforString:@"2000-1-1"];
    }
    
    _chvc.calendarBlock = ^(CalendarDayModel *model){
        
        if (model.holiday) {
            [sender setTitle:[NSString stringWithFormat:@"%@ %@ %@", [model toString], [model getWeek], [model holiday]] forState:UIControlStateNormal];
        }else {
            
            [sender setTitle:[NSString stringWithFormat:@"%@ %@", [model toString], [model getWeek]] forState:UIControlStateNormal];
        }
    };
    
    [self.navigationController pushViewController:_chvc animated:YES];
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
