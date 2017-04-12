//
//  YYNavigationController.h
//  截获导航栏系统返回按钮事件和右划pop事件
//
//  Created by vcyber on 16/7/27.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYNavigationControllerShouldPopProtocol.h"

@interface UINavigationController (UINavigationControllerNeedsShouldPopItem)

- (BOOL)navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item;

@end

@interface YYNavigationController : UINavigationController

@end
