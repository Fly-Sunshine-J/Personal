//
//  WaterFlowCell.m
//  Demo测试
//
//  Created by vcyber on 16/6/29.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "WaterFlowCell.h"
#import "UIImageView+WebCache.h"
#import "GoodsModel.h"

@interface WaterFlowCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;

@end

@implementation WaterFlowCell


- (void)setModel:(GoodsModel *)model {
    _model = model;
    [self.imageView sd_setImageWithURL:[NSURL URLWithString:model.img] placeholderImage:nil];
    self.priceLabel.text = model.price;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

@end
