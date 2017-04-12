//
//  WaterflowLayout.m
//  Demo测试
//
//  Created by vcyber on 16/6/29.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "WaterFlowLayout.h"


/**默认的列数*/
static const NSInteger defaultColumnCount = 3;
/**每一列之间的间距*/
static const CGFloat defaultColMargin = 10;
/**每一行之间的间距*/
static const CGFloat defaultRowMargin = 10;
/**边缘的间距*/
static const UIEdgeInsets defaultedgeInsets = {10, 10, 10, 10};

@interface WaterFlowLayout ()
/**布局属性数组*/
@property (nonatomic, strong) NSMutableArray *attrsArray;
/**存放列的当前高度值*/
@property (nonatomic, strong) NSMutableArray *columnHeights;

@property (nonatomic, assign) CGFloat contentHeight;

- (CGFloat)rowMargin;
- (CGFloat)columnMargin;
- (NSInteger)columnCount;
- (UIEdgeInsets)edgeInsets;

@end

@implementation WaterFlowLayout
#pragma mark --代理
- (CGFloat)rowMargin {
    if ([self.delegate respondsToSelector:@selector(rowMarginOfWaterFlowLayout:)]) {
        return [self.delegate rowMarginOfWaterFlowLayout:self];
    }else {
        return defaultRowMargin;
    }
}

- (CGFloat)columnMargin {
    if ([self.delegate respondsToSelector:@selector(columnMarginOfWaterFlowLayout:)]) {
        return [self.delegate columnMarginOfWaterFlowLayout:self];
    }else {
        return defaultColMargin;
    }
}

- (NSInteger)columnCount {
    if ([self.delegate respondsToSelector:@selector(numberColumnOfWaterFlowLayout:)]) {
        return [self.delegate numberColumnOfWaterFlowLayout:self];
    }else {
        return defaultColumnCount;
    }
}

- (UIEdgeInsets)edgeInsets {
    if ([self.delegate respondsToSelector:@selector(edgeInsetsOfColumnWaterFlowLayout:)]) {
        return [self.delegate edgeInsetsOfColumnWaterFlowLayout:self];
    }else {
        return defaultedgeInsets;
    }
}


#pragma mark -懒加载
- (NSMutableArray *)columnHeights {
    if (!_columnHeights) {
        _columnHeights = [NSMutableArray array];
    }
    return _columnHeights;
}

- (NSMutableArray *)attrsArray {
    
    if (!_attrsArray) {
        _attrsArray = [NSMutableArray array];
    }
    return _attrsArray;
}

#pragma mark -继承后必须实现的方法
/**
 *  初始化
 */
- (void)prepareLayout {
    [super prepareLayout];
    
    //清除以前的高度
    self.contentHeight = 0;
    [self.columnHeights removeAllObjects];
    for (NSInteger i = 0; i < self.columnCount; i++) {
        [self.columnHeights addObject:@(self.edgeInsets.top)];
    }
    //清除之前的布局属性
    [self.attrsArray removeAllObjects];
    
    //开始创建每一个cell对应的布局属性
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSInteger i = 0; i < count; i++) {
        //创建位置
        NSIndexPath *indexpath = [NSIndexPath indexPathForItem:i inSection:0];
        //获取indexPath位置cell的布局属性
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexpath];
        [self.attrsArray addObject:attrs];
    }
}

/**
 *  决定cell布局
 *
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    
    
    return self.attrsArray;
}

/**
 *  返回indexPath文职cell对应的布局属性
 *
 */
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //创建布局属性
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    //collectionView的宽度
    CGFloat collectionViewW = self.collectionView.frame.size.width;
    
    //设置布局属性的frame属性
    CGFloat w = (collectionViewW - self.edgeInsets.left - self.edgeInsets.right - (self.columnCount - 1) * self.columnMargin) / self.columnCount;
    CGFloat h = [self.delegate WaterFlowLayout:self heightForItemAtIndexPath:indexPath ItemWidth:w];
    
    //找到高度最短的那一列
//    __block NSInteger destColumn = 0;
//    __block CGFloat minColumnHeight  = MAXFLOAT;
//    [self.columnHeoghts enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        CGFloat columnHeight = [obj doubleValue];
//        if (columnHeight < minColumnHeight) {
//            minColumnHeight = columnHeight;
//            destColumn = idx;
//        }
//    }];

    //找到高度最短的那一列(列号和最短的高度)
    NSInteger destColumn = 0;
    CGFloat minColumnHeight  = [self.columnHeights[0] doubleValue];
    for (NSInteger i = 1; i < self.columnCount; i++) {
        CGFloat columnHeight = [self.columnHeights[i] doubleValue];
        if (minColumnHeight > columnHeight) {
            minColumnHeight = columnHeight;
            destColumn = i;
        }
    }
    
    
    CGFloat x = self.edgeInsets.left + destColumn * (w + self.columnMargin);
    CGFloat y = minColumnHeight;
    if (y != self.edgeInsets.top) {
        y += self.rowMargin;
    }
    attrs.frame = CGRectMake(x, y, w, h);
    
    //更新最短的高度
    [self.columnHeights replaceObjectAtIndex:destColumn withObject:@(CGRectGetMaxY(attrs.frame))];
    
    CGFloat columnHeight = [self.columnHeights[destColumn] doubleValue];
    if (columnHeight > self.contentHeight) {
        self.contentHeight = columnHeight;
    }
    
    return attrs;
}


- (CGSize)collectionViewContentSize {

    return CGSizeMake(0, self.contentHeight + self.edgeInsets.bottom);
}

@end
