//
//  YYNavigationControllerShouldPopProtocol.h
//  截获导航栏系统返回按钮事件和右划pop事件
//
//  Created by vcyber on 16/7/27.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import <Foundation/Foundation.h>

@class YYNavigationController;

@protocol YYNavigationControllerShouldPopProtocol <NSObject>

- (BOOL)yy_navigationControllerShouldPopWhenSystemBackBtnSelected:(YYNavigationController *)navigationController;

@end
