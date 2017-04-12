//
//  MainViewController.m
//  CAAnimation-转场动画
//
//  Created by vcyber on 16/7/19.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "MainViewController.h"
#import "ViewController.h"


@interface MainViewController ()<ViewControllerDelegate>



@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    button.frame = CGRectMake(80.0, 210.0, 60.0, 40.0);
    [button setTitle:@"Click me" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    self.navigationItem.titleView = button;
}




- (void)buttonClicked:(UIButton *)btn {
    
    ViewController *vc = [[ViewController alloc] init];
    vc.delegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}


- (void)modalViewControllerDidClickedDismissBtn:(UIViewController *)viewController {
    
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
