//
//  PictureRootVC.h
//  ComicAndPicture
//
//  Created by MS on 16/3/8.
//  Copyright © 2016年 JFY. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import <MJRefresh.h>

@interface PictureRootVC : UIViewController<UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>


@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, assign) int page_num;

@property (nonatomic, strong) NSString *categoryId;

@property (nonatomic, getter=isPulling) BOOL isPulling;

@property (nonatomic, copy) NSString *url;

/**
 *  请求数据
 */
- (void)createDataWithURL:(NSString *)urlString;

/**
 *  刷新数据
 */
- (void)createRefreshWith:(int)page ;

/**
 *  创建collectionView
 *
 *  @param identifier   重用标识符
 *  @param registeClass 注册的cell类
 */
- (void)createCollectionViewWithReuseIdentifier:(NSString *)identifier AndClass:(Class)registeClass;

/**
 *  返回按钮
 */
- (void)createBackButton;

/**
 *  返回方法
 */
- (void)back;

@end
