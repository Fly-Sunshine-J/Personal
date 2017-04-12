//
//  textViewController.m
//  类似于popOver弹出框效果
//
//  Created by ZouXu on 16/6/16.
//  Copyright © 2016年 ZouXu. All rights reserved.
//

#import "textViewController.h"
#import "ZXBasicViewController.h"

@interface textViewController ()

@end

@implementation textViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.textBtn addTarget:self action:@selector(respondsToBackButton:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)respondsToBackButton :(UIButton*)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
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
