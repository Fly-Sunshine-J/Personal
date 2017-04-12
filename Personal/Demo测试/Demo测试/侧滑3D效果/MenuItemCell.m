//
//  MenuItemCell.m
//  Demo测试
//
//  Created by vcyber on 16/7/7.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "MenuItemCell.h"

@interface MenuItemCell ()
@property (weak, nonatomic) IBOutlet UIImageView *itemView;

@end

@implementation MenuItemCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
   
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}


- (void)configCellWithDictionary:(NSDictionary *)dic {

    self.itemView.image = [UIImage imageNamed:dic[@"image"]];
    self.itemView.backgroundColor = [UIColor colorWithRed:[dic[@"colors"][0] floatValue] / 255.0 green:[dic[@"colors"][1] floatValue] / 255.0 blue:[dic[@"colors"][2] floatValue] / 255.0 alpha:1];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
