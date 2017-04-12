//
//  BaseViewController.h
//  Demo测试
//
//  Created by vcyber on 16/6/28.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseTableViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataArray;

@end
