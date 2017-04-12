//
//  ComicRootVC.h
//  ComicAndPicture
//
//  Created by MS on 16/3/3.
//  Copyright © 2016年 JFY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking.h>
#import <MJRefresh.h>

@interface ComicRootVC : UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) NSString *urlString;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, assign) int page;

@property (nonatomic, getter=isPulling) BOOL isPulling;

/**
 *  获取并解析数据
 *
 *  @param urlString url
 */
- (void)createDataWithURL:(NSString *)urlString;


/**
 *  创建刷新
 */
- (void)createRefresh;


/**
 *  刷新
 */
- (void)refresh;

/**
 *  获取更多数据
 */
- (void)getMore;

@end
