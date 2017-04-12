//
//  ZXBasicViewController.m
//  类似于popOver弹出框效果
//
//  Created by ZouXu on 16/6/16.
//  Copyright © 2016年 ZouXu. All rights reserved.
//

#import "ZXBasicViewController.h"
#import "ZXPopMenuOptions.h"
#import "ZXPopMenuDataModel.h"

#import "textViewController.h"

@interface ZXBasicViewController ()

@end

@implementation ZXBasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.showMenuBtn addTarget:self action:@selector(respondsToShowMenuButton:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)respondsToShowMenuButton :(UIButton*)sender{
    NSMutableArray *items = [NSMutableArray array];
    
    for (NSInteger i = 0; i < [self titles].count; i++) {
        
        ZXPopMenuDataModel * popMenuModel = [ZXPopMenuDataModel new];
        popMenuModel.leftImageStr = [self images][i];
        popMenuModel.rightLabelStr = [self titles][i];
        [items addObject:popMenuModel];
    }
    
    CGRect basicItemRect =[[sender superview ]convertRect:((UIButton*)sender).frame toView:self.view];
    [[ZXPopMenuOptions shareManager]showPopMenuSelecteWithFrame:150
                                                             items:items
                                                    basicItemRect:basicItemRect
                                                           action:^(NSInteger index) {
                                                               NSLog(@"这里处理事件");
                                                               textViewController *textVC = [[textViewController alloc]init];
                                                               [self presentViewController:textVC animated:YES completion:nil];
                                                           }];

}



- (NSArray *) titles {
    return @[@"基地公示",
             @"基地名单",
             @"申请资格",
             @"工资单",
             @"问卷调查",
             @"申请记录"];
}

- (NSArray *) images {
    
    return @[@"right_menu_payMoney@3x",
             @"right_menu_payMoney@3x",
             @"right_menu_payMoney@3x",
             @"right_menu_payMoney@3x",
             @"right_menu_payMoney@3x",
             @"right_menu_payMoney@3x",
             @"right_menu_payMoney@3x"];
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
