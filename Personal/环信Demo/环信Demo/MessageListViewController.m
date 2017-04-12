//
//  MessageListViewController.m
//  环信Demo
//
//  Created by vcyber on 16/6/1.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "MessageListViewController.h"

@interface MessageListViewController ()<BaseViewDelegate>

@end

@implementation MessageListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"aaa";

}

- (void)logSomething {
    
    NSLog(@"aaa");
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
