//
//  ViewController.m
//  运行时改变字体大小
//
//  Created by vcyber on 16/8/19.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "ViewController.h"
#import "NextViewController.h"
#import "CustomLabel.h"
#import "CustomBtn.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    CustomLabel *label = [[CustomLabel alloc] initWithFrame:CGRectMake(40, 100, 200, 100)];
    label.backgroundColor = [UIColor redColor];
    label.text = @"hello , 你好";
    label.font = [UIFont systemFontOfSize:[[[NSUserDefaults standardUserDefaults] objectForKey:@"fontsize"] floatValue] > 1 ?  [[[NSUserDefaults standardUserDefaults] valueForKey:@"fontsize"] floatValue] * 11 : 11];
    [self.view addSubview:label];
    
    CustomBtn *btn = [CustomBtn buttonWithType:UIButtonTypeSystem];
    [btn setBackgroundColor:[UIColor yellowColor]];
    btn.frame = CGRectMake(100, 200, 100, 100);
    [btn setTitle:@"按钮" forState:UIControlStateNormal];
    [btn setTintColor:[UIColor blackColor]];
    btn.titleLabel.font = [UIFont systemFontOfSize:[[[NSUserDefaults standardUserDefaults] valueForKey:@"fontsize"] floatValue] > 1 ?  [[[NSUserDefaults standardUserDefaults] valueForKey:@"fontsize"] floatValue] * 11 : 11];
    [self.view addSubview:btn];
    
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.navigationController pushViewController:[[NextViewController alloc] init] animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
