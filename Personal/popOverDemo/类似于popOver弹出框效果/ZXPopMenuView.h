//
//  ZXPopMenuView.h
//  类似于popOver弹出框效果
//
//  Created by ZouXu on 16/6/16.
//  Copyright © 2016年 ZouXu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZXPopMenuView : UIView

@property (nonatomic, assign) CGFloat menuWidth;
@property (nonatomic, copy) void(^action)(NSInteger index);
@property (nonatomic, copy) NSArray * menuItem;
@property (nonatomic, strong) UITableView * tableView;

/*!
 *  函数名称：
 *  函数描述：初始化彩蛋
 *  返回参数：popmenuview
 *  参数描述：frame：整体view的位置大小
            menuwidth：menuview的位置
            items：数据源
            itemRect：被点击控件的位置，是相对于当前屏幕而言，并不是控件在容器中的位置
            action： 回调点击方法
 */
- (instancetype) initWithFrame:(CGRect)frame
                     menuWidth:(CGFloat)menuWidth
                         items:(NSArray *)items
                     itemRect :(CGRect)itemRect
                        action:(void(^)(NSInteger index))action;

@end
