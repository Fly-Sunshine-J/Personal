//
//  BaseViewController.m
//  Demo测试
//
//  Created by vcyber on 16/6/28.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "BaseViewController.h"
#import "DemoSourceListViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor whiteColor];
    [self addRightItem];
    
}

- (void)addRightItem {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"查看源码" forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, 80, 40);
    [btn addTarget:self action:@selector(pushToDemoSourceList) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
}

- (void)pushToDemoSourceList {
    DemoSourceListViewController *demoSource = [[DemoSourceListViewController alloc] init];
    demoSource.dataArray = self.SourceArray;
    [self.navigationController pushViewController:demoSource animated:YES];
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
