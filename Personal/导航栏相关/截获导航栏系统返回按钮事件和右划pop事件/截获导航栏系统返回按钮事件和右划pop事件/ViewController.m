//
//  ViewController.m
//  截获导航栏系统返回按钮事件和右划pop事件
//
//  Created by vcyber on 16/7/27.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "ViewController.h"
#import "SceondVC.h"
#import "ThridVC.h"

@interface ViewController ()<SecondVCDelegate, ThridVCDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(100, 100, 100, 100);
    [btn setTitle:@"first" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(first) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeSystem];
    btn1.frame = CGRectMake(100, 300, 100, 100);
    [btn1 setTitle:@"second" forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(second) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
}


- (void)first {
    SceondVC *svc = [[SceondVC alloc] init];
    svc.delegate = self;
    [self.navigationController pushViewController:svc animated:YES];
    
}

- (void)backWithColor:(UIColor *)color {
    
    self.view.backgroundColor = color;
}

- (void)second {
    ThridVC *tvc = [[ThridVC alloc] init];
    tvc.delegate = self;
    [self.navigationController pushViewController:tvc animated:YES];
}


- (void)gobackWithColor:(UIColor *)color {
    
    self.view.backgroundColor = color;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
