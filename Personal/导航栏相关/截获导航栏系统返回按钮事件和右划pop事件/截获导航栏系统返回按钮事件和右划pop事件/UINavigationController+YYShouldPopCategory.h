//
//  UINavigationController+YYShouldPopCategory.h
//  截获导航栏系统返回按钮事件和右划pop事件
//
//  Created by vcyber on 16/7/27.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YYNavigationControllerShouldPopDelegate <NSObject>
@optional
- (BOOL)navigationControllerShouldPop:(UINavigationController *)navigationController;
- (BOOL)navigationControllerStartInteractivepopGestureRecoginizer:(UINavigationController *)navigationCotroller;

@end

@interface UINavigationController (YYShouldPopCategory)<UIGestureRecognizerDelegate, UINavigationBarDelegate>


@end
