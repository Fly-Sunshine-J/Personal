
//
//  SceondVC.m
//  截获导航栏系统返回按钮事件和右划pop事件
//
//  Created by vcyber on 16/7/27.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "SceondVC.h"
#import "YYNavigationControllerShouldPopProtocol.h"

@interface SceondVC ()<YYNavigationControllerShouldPopProtocol>

@end

@implementation SceondVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor yellowColor];
}


- (BOOL)yy_navigationControllerShouldPopWhenSystemBackBtnSelected:(YYNavigationController *)navigationController {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(backWithColor:)]) {
        [self.delegate backWithColor:[UIColor greenColor]];
    }
    
    return YES;
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
