//
//  YYNavigationController.m
//  截获导航栏系统返回按钮事件和右划pop事件
//
//  Created by vcyber on 16/7/27.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "YYNavigationController.h"


@implementation UINavigationController (UINavigationControllerNeedsShouldPopItem)

@end

@interface YYNavigationController ()<UINavigationBarDelegate>

@end

@implementation YYNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
    
    UIViewController *vc = self.topViewController;
    if (item != vc.navigationItem) {
        return [super navigationBar:navigationBar shouldPopItem:item];
    }
    
    if ([vc conformsToProtocol:@protocol(YYNavigationControllerShouldPopProtocol)]) {
        if ([(id<YYNavigationControllerShouldPopProtocol>)vc yy_navigationControllerShouldPopWhenSystemBackBtnSelected:self]) {
            return [super navigationBar:navigationBar shouldPopItem:item];
        }else {
            return NO;
        }
    }else {
        return [super navigationBar:navigationBar shouldPopItem:item];
    }
    
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
