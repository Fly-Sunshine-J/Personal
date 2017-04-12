//
//  ChartBarView.h
//  Record
//
//  Created by vcyber on 16/12/29.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ChartsModel.h"
#import "ColorfulLabel.h"

@interface ChartBarView : UIView

@property (nonatomic, strong) NSArray *itemArray;

@property (nonatomic, strong) UILabel *dateLabel;

@property (nonatomic, copy) void(^getMore)();

- (void)endRefresh;

@end

@interface CustomCollectionCell : UICollectionViewCell

- (void)configCellWithLastModel:(ChartsModel *)lastModel Model:(ChartsModel *)model NextModel:(ChartsModel *)nextModel;

@end
