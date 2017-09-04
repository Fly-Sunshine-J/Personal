//
//  ViewController.m
//  消息转发
//
//  Created by vcyber on 17/9/4.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"changeColor" style:UIBarButtonItemStylePlain target:self action:NSSelectorFromString(@"changeColor")];
    self.navigationItem.rightBarButtonItem = right;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.navigationController pushViewController:[[ViewController alloc] init] animated:YES];
}

@end
