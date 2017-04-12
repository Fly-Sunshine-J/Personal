//
//  WaterflowLayout.h
//  Demo测试
//
//  Created by vcyber on 16/6/29.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WaterFlowLayout;

@protocol WaterFlowLayoutDelegate <NSObject>
@required
- (CGFloat)WaterFlowLayout:(WaterFlowLayout *)layout heightForItemAtIndexPath:(NSIndexPath *)indexPath ItemWidth:(CGFloat)itemWidth;

@optional
- (CGFloat)numberColumnOfWaterFlowLayout:(WaterFlowLayout *)layout;
- (CGFloat)columnMarginOfWaterFlowLayout:(WaterFlowLayout *)layout;
- (CGFloat)rowMarginOfWaterFlowLayout:(WaterFlowLayout *)layout;
- (UIEdgeInsets)edgeInsetsOfColumnWaterFlowLayout:(WaterFlowLayout *)layout;
@end

@interface WaterFlowLayout : UICollectionViewLayout

@property (nonatomic, weak)id<WaterFlowLayoutDelegate>delegate;

@end
