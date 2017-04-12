//
//  TreeTableViewCell.m
//  Record
//
//  Created by vcyber on 17/1/18.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import "TreeTableViewCell.h"
#import "Masonry.h"
#import "View+MASShorthandAdditions.h"
@interface TreeTableViewCell ()


@end

@implementation TreeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self createUI];
    }
    return self;
}


- (void)createUI {
    self.nameLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.nameLabel];
    self.arrowView = [[UIImageView alloc] init];
    self.arrowView.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:self.arrowView];
    [self.arrowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
        make.centerY.mas_equalTo(0);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.arrowView.mas_right);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
}

- (void)configCellWithNode:(TreeViewNode *)node {
    CGFloat left = 0;
    CGFloat fontSize = 12;
    if (node.nodeLevel == 0) {
        left = 10;
        fontSize = 18;
    }else if (node.nodeLevel == 1) {
        left = 30;
        fontSize = 16;
    }else if (node.nodeLevel == 2) {
        left = 50;
        fontSize = 14;
    } else if (node.nodeLevel == 3){
        left = 70;
    }

    [self.arrowView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(left);
        make.width.mas_equalTo(20);
        make.height.mas_equalTo(20);
        make.centerY.mas_equalTo(0);
    }];
    [self.nameLabel mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.arrowView.mas_right).offset(5);
        make.right.mas_equalTo(0);
        make.top.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
    }];
    self.nameLabel.font = [UIFont systemFontOfSize:fontSize];
    self.nameLabel.text = node.nodeData;
    if (node.isExpanded) {
        self.arrowView.image = [UIImage imageNamed:@"accident2"];
    }else {
        self.arrowView.image = [UIImage imageNamed:@"accident"];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
