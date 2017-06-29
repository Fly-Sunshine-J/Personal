//
//  CYWCalendarCollectionViewFlowLayout.m
//  Calendar
//
//  Created by vcyber on 17/5/16.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import "CYWCalendarCollectionViewFlowLayout.h"

@interface CYWCalendarCollectionViewFlowLayout ()

@property (nonatomic, strong) NSMutableArray *atts;
@property (nonatomic, assign) NSInteger count;

@end

@implementation CYWCalendarCollectionViewFlowLayout

- (instancetype)init {
    self = [super init];
    if (self) {
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _column = 7;
    }
    return self;
}

- (void)prepareLayout {
    [super prepareLayout];
    _atts = [NSMutableArray array];
    for (int i = 0; i < self.collectionView.numberOfSections; i++) {
        NSUInteger count = [self.collectionView numberOfItemsInSection:i];
        for (int j = 0; j < count; j++) {
            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:j inSection:i];
            UICollectionViewLayoutAttributes *att = [self layoutAttributesForItemAtIndexPath:indexPath];
            [_atts addObject:att];
        }
    }
}


- (CGSize)collectionViewContentSize {
    return CGSizeMake(self.collectionView.numberOfSections * self.collectionView.frame.size.width, self.collectionView.frame.size.height);
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewLayoutAttributes *atts = [super layoutAttributesForItemAtIndexPath:indexPath];
    UICollectionViewLayoutAttributes *att = [atts copy];
    [self applyLayoutAttributes:att];
    return att;
}


- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)attributes {

    CGFloat stride = self.collectionView.frame.size.width;
    CGFloat offset = (attributes.indexPath.section) * stride;
    CGFloat xCellOffset = (attributes.indexPath.item % _column) * self.itemSize.width;
    CGFloat yCellOffset = (attributes.indexPath.item / _column) * self.itemSize.height;
    xCellOffset += offset;
    attributes.frame = CGRectMake(xCellOffset, yCellOffset, self.itemSize.width, self.itemSize.height);
    _count++;
}


- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSLog(@"------------%@", @(_count));
    return _atts;
}

@end
