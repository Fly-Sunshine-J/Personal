//
//  RollScrollView.h
//  三张图片无线轮播图
//
//  Created by vcyber on 16/6/14.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, PageControlPosition) {
    PageControlPosition_None, //默认底部
    PageControlPosition_Hidden, //隐藏
    PageControlPosition_BottomCenter,
};

@class RollScrollView;

@protocol RollScrollViewDelegate <NSObject>

- (void)clickRollScrollView:(RollScrollView *)rollScrollView didSelectScrollViewIndex:(NSInteger)index;

@end

@interface RollScrollView : UIView

@property (nonatomic, weak) id<RollScrollViewDelegate>delegate;
/**
 *  占位图
 */
@property (nonatomic, strong) UIImage *placeholder;
/**
 *  图片数组 可以UIImage类型  本地图片路径(NSString类型)  网络图片(NSURL类型)
 */
@property (nonatomic, strong) NSArray *imageArray;
/**
 *  是否上下滚动, 默认NO
 */
@property (nonatomic, assign, getter=isPortrait) BOOL portrait;
/**
 *  pageControl位置
 */
@property (nonatomic, assign) PageControlPosition pageControlPosition;

/**
 *  自定义设置分页指示器的图片
 *
 *  @param currentImage 选择图片
 *  @param otherImage   其他图片
 */
- (void)setPageControlCurrentImage:(UIImage *)currentImage OtherImage:(UIImage *)otherImage;

/**
 *  自定义设置分页指示器的颜色
 *
 *  @param currentColor 选中得颜色
 *  @param otherColor   其他颜色
 */
- (void)setpageControlCurrentColor:(UIColor *)currentColor OtherColor:(UIColor *)otherColor;

@end
