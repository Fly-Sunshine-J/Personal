//
//  ContainerViewController.h
//  Demo测试
//
//  Created by vcyber on 16/7/7.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "BaseViewController.h"

@interface ContainerViewController : BaseViewController

@property (nonatomic, strong) NSDictionary *item;

@property (nonatomic, getter=isShow) BOOL show;
- (void)showMenu:(BOOL)show animation:(BOOL)animation;

@end
