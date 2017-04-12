//
//  ZXPopMenuOptions.h
//  类似于popOver弹出框效果
//
//  Created by ZouXu on 16/6/16.
//  Copyright © 2016年 ZouXu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface ZXPopMenuOptions : NSObject

/** 创建单例 */
+ (ZXPopMenuOptions *) shareManager;

/*
 *  函数名称：
 *  函数描述：构建一个弹出菜单
 *  返回参数：nil
 *  参数描述：width：菜单tableview的宽度 
            item：数据源 
            basicItemRect：被点击控件的位置，是相对于当前屏幕而言，并不是控件在容器中的位置
            action： 回调点击方法
 */
- (void) showPopMenuSelecteWithFrame:(CGFloat)width
                                items:(NSArray *)items
                      basicItemRect :(CGRect)basicItemRect
                              action:(void (^)(NSInteger))action;

/** 隐藏菜单 */
- (void) hideMenu;


@end
