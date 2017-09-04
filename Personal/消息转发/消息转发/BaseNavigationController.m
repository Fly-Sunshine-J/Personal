//
//  BaseNavigationController.m
//  消息转发
//
//  Created by vcyber on 17/9/4.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import "BaseNavigationController.h"
#import "AppDelegate.h"

@interface BaseNavigationController ()

@property (nonatomic, weak) AppDelegate *appDelegate;

@end

@implementation BaseNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   _appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    [_appDelegate.targets addObject:viewController];
    [super pushViewController:viewController animated:animated];
}

- (UIViewController *)popViewControllerAnimated:(BOOL)animated {
    UIViewController *viewController = [super popViewControllerAnimated:animated];
    [_appDelegate.targets removeObject:viewController];
    return viewController;
}

- (NSArray<UIViewController *> *)popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSArray<UIViewController *> *array = [super popToViewController:viewController animated:animated];
    [_appDelegate.targets removeObjectsInArray:array];
    return array;
}

- (NSArray<UIViewController *> *)popToRootViewControllerAnimated:(BOOL)animated {
    NSArray<UIViewController *> *array = [super popToRootViewControllerAnimated:animated];
    [_appDelegate.targets removeObjectsInArray:array];
    return array;
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
