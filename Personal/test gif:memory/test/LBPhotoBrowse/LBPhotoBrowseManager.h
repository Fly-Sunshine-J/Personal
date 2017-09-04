//
//  LBPhotoBrowseManager.h
//  test
//
//  Created by dengweihao on 2017/8/1.
//  Copyright © 2017年 dengweihao. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "LBPhotoBrowseConst.h"
#import "LBPhotoBrowseView.h"

/**
                            控件的基本结构
 
 |-------------------------LBTapDetectingImageView------------------------| (最上层)
 
 |-------------------------LBZoomScrollView------------------------|

 |-------------------------UICollectionViewCell------------------------|
 
 |-------------------------UICollectionView------------------------|
 
 |-------------------------LBPhotoBrowseView------------------------|       (最下层)

 
 */
/**
   一行代码搞定微信的图片浏览(当前只支持图片)
 */
typedef NS_ENUM(NSInteger, LBMaximalImageViewOnDragDismmissStyle) {
    LBMaximalImageViewOnDragDismmissStyleOne,// 类似微信的动画
    LBMaximalImageViewOnDragDismmissStyleTwo // 自定义的动画
};

@interface LBPhotoBrowseManager : NSObject

// 传入的urls
@property (nonatomic , strong, readonly)LBUrlsMutableArray *urls;

// 传入的imageViews
@property (nonatomic , strong, readonly)LBImageViewsArray *imageViews;

// 用来展示图片的UI控件
@property (nonatomic , weak, readonly)LBPhotoBrowseView *photoBrowseView;

// 传入的imageViews的共同父View
@property (nonatomic , weak, readonly)UIView *imageViewSuperView;

// 传入的点击imageview的index
@property (nonatomic , assign)int selectedIndex;

// 展示图片使用collectionView来提高效率
@property (nonatomic , weak)UICollectionView *currentCollectionView;

//是否需要弹性效果 default = YES
@property (nonatomic , assign)BOOL isNeedBounces;

//当图片加载出现错误时候显示的图片 if nil default is [UIImage imageNamed:@"LBLoadError.jpg"]
@property (nonatomic , strong)UIImage *errorImage;

// 每张正在加载的图片的站位图
@property (nonatomic , copy ,readonly)UIImage *(^placeHoldImageCallBackBlock)(NSIndexPath *indexPath);

// 当图片放大到超过屏幕尺寸时候 拖动的消失方式 Default is LBMaximalImageViewOnDragDismmissStyleTwo
@property (nonatomic , assign)LBMaximalImageViewOnDragDismmissStyle style;

@property (nonatomic , assign)BOOL lowGifMemory;

@property (nonatomic , strong)UIImageView *currentShowImageView;

@property (nonatomic , strong)NSArray <UIImage *> *gifImages;

/**
 返回当前的一个单例(不完全单利)
 */
+ (instancetype)defaultManager;

/**
 展示图片
 @param urls 需要加载的图片的URL数组
 @param imageViews 传入需要大图显示的imageViews 因为将来需要在对应的地方imageView用动画消除掉,主要是取imageView的frame
 @param index 点击图片的index
 @param superView 当前View的父View
 */
- (void)showImageWithURLArray:(NSArray *)urls fromImageViews:(NSArray *)imageViews andSelectedIndex:(int)index andImageViewSuperView:(UIView *)superView;


#pragma mark - 自定义图片长按按钮的Block 类似TableViewCell的代理

- (instancetype)addLongPressShowTitles:(NSArray <NSString *>*)titles;

- (instancetype)addTitleClickCallbackBlock:(void(^)(UIImage *image,NSIndexPath *indexPath,NSString *title))titleClickCallBackBlock;

- (instancetype)addLongPressCustomViewBlock:(UIView *(^)(UIImage *image, NSIndexPath *indexPath))longPressBlock;

- (instancetype)addPlaceHoldImageCallBackBlock:(UIImage *(^)(NSIndexPath * indexPath))placeHoldImageCallBackBlock;

- (NSArray<NSString *> *)currentTitles;

- (void (^)(UIImage *, NSIndexPath *, NSString *))titleClickBlock;

- (UIView *(^)(UIImage *,NSIndexPath *))LongPressCustomViewBlock;

@end
