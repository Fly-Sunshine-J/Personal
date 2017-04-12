//
//  ViewController.m
//  三张图片无线轮播图
//
//  Created by vcyber on 16/6/14.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "ViewController.h"
#import "RollScrollView.h"

@interface ViewController ()<RollScrollViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    RollScrollView *roll = [[RollScrollView alloc] initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, 200)];
    roll.imageArray = @[[NSURL URLWithString:@"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=1916500820,874871263&fm=116&gp=0.jpg"], [UIImage imageNamed:@"1"], @"2", @"3"];
    roll.placeholder = [UIImage imageNamed:@"placeHoder"];
    roll.delegate =self;
//    [roll setPageControlCurrentImage:[UIImage imageNamed:@"pageControl_nor"] OtherImage:[UIImage imageNamed:@"pageControl_current"]];
    [self.view addSubview:roll];
}

- (void)clickRollScrollView:(RollScrollView *)rollScrollView didSelectScrollViewIndex:(NSInteger)index {
    
    
    NSLog(@"%ld", index);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
