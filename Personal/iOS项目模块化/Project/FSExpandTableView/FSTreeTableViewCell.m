//
//  TreeTableViewCell.m
//  Record
//
//  Created by vcyber on 17/1/18.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import "FSTreeTableViewCell.h"

@interface FSTreeTableViewCell ()

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) UIImageView *arrowView;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *textLabel2;

@end

@implementation FSTreeTableViewCell

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
    
    self.arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"CYWDataicon4"]];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(expand:)];
    self.arrowView.userInteractionEnabled = YES;
    [self.arrowView addGestureRecognizer:tap];
    [self.contentView addSubview:self.arrowView];
    
    self.textLabel2 = [[UILabel alloc] init];
    [self.contentView addSubview:self.textLabel2];
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height - 1, self.frame.size.width, 1)];
    self.lineView.backgroundColor = [UIColor colorWithRed:120 green:120 blue:120 alpha:1];
    [self.contentView addSubview:self.lineView];
}

- (void)configCellWithNode:(FSTreeViewNode *)node IndexPath:(NSIndexPath *)indexPath {
    self.indexPath = indexPath;
    CGFloat left = 0;
    CGFloat fontSize = 12;
    UIColor *fontColor = [UIColor colorWithRed:72 green:72 blue:72 alpha:1];
    self.arrowView.hidden = NO;
    if (node.nodeLevel == 0) {
        left = 10;
        fontSize = 15;
    }else if (node.nodeLevel == 1) {
        left = 30;
        fontSize = 14;
    }else if (node.nodeLevel == 2) {
        left = 50;
        fontSize = 14;
        fontColor = [UIColor colorWithRed:120 green:120 blue:120 alpha:1];
    } else if (node.nodeLevel == 3){
        left = 70;
        fontColor = [UIColor colorWithRed:120 green:120 blue:120 alpha:1];
        self.arrowView.hidden = YES;
    }
    self.arrowView.frame = CGRectMake(left, self.frame.size.height / 2 - 5, 20, 20);
    self.textLabel2.frame = CGRectMake(left + 25, 0, self.frame.size.width - left - 5, self.frame.size.height);
    self.textLabel2.text = node.nodeData;
    if (node.isExpanded) {
        self.arrowView.image = [UIImage imageNamed:@"CYWDataicon4"];
    }else {
        self.arrowView.image = [UIImage imageNamed:@"CYWDataicon4_right"];
    }
}


- (void)expand:(UITapGestureRecognizer *)tap {
    if (self.expandBlock) {
        self.expandBlock(self.indexPath);
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
