//
//  ComicCell.h
//  ComicAndPicture
//
//  Created by MS on 16/3/4.
//  Copyright © 2016年 JFY. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ComicModel;

@interface ComicCell : UITableViewCell

@property (nonatomic, strong) UIImageView *coverView;

@property (nonatomic, strong) UILabel  *titleLabel;

@property (nonatomic, strong) UILabel  *authouLabel;

@property (nonatomic, strong) UILabel  *descLabel;

@property (nonatomic, strong) UILabel  *updateLabel;


- (void)configCellWithModel:(ComicModel *)model;

- (void)configSearchCellWithModel:(ComicModel *)model;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

- (void)createCellUI;

@end
