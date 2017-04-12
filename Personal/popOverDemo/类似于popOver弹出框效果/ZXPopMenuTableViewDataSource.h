//
//  ZXPopMenuTableViewDataSource.h
//  类似于popOver弹出框效果
//
//  Created by ZouXu on 16/6/16.
//  Copyright © 2016年 ZouXu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ZXPopMenuDataModel,ZXPopOverTableViewCell;

typedef void(^TableViewCellConfigureBlock) (ZXPopOverTableViewCell * cell,ZXPopMenuDataModel * model); /** cell回调 */

@interface ZXPopMenuTableViewDataSource : NSObject<UITableViewDataSource>

/*!
 *  函数名称：
 *  函数描述：数据源
 *  返回参数：
 *  参数描述：anitems ：数据源
            cellclass ：cell类
            aConfigureCellBlock ：cell回调
 */
- (instancetype) initWithItems:(NSArray *)anItems
                     cellClass:(Class)cellClass
            configureCellBlock:(TableViewCellConfigureBlock)aConfigureCellBlock;



@end
