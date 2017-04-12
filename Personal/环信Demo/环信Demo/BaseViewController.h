//
//  BaseViewController.h
//  环信Demo
//
//  Created by vcyber on 16/5/31.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import <UIKit/UIKit.h>
#define KCELLDEFAULTHEIGHT 50

@protocol BaseViewDelegate <NSObject>

- (void)logSomething;

@end

@interface BaseViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (strong, nonatomic) NSMutableArray *dataArray;
@property (strong, nonatomic) NSMutableDictionary *dataDictionary;
@property (nonatomic) int page;

@property (nonatomic) BOOL showRefreshHeader;//是否支持下拉刷新
@property (nonatomic) BOOL showRefreshFooter;//是否支持上拉加载
@property (nonatomic) BOOL showTableBlankView;//是否显示无数据时默认背景

- (instancetype)initWithStyle:(UITableViewStyle)style;

- (void)tableViewDidTriggerHeaderRefresh;//下拉刷新事件
- (void)tableViewDidTriggerFooterRefresh;//上拉加载事件

- (void)tableViewDidFinishTriggerHeader:(BOOL)isHeader reload:(BOOL)reload;

#warning Test
@property (nonatomic, weak)id delegate;
- (void)log;
@end
