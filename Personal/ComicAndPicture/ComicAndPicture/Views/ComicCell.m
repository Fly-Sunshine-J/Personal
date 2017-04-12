//
//  ComicCell.m
//  ComicAndPicture
//
//  Created by MS on 16/3/4.
//  Copyright © 2016年 JFY. All rights reserved.
//

#import "ComicCell.h"
#import <UIImageView+WebCache.h>
#import "ComicModel.h"
#import <SDImageCache.h>

#define WIDTH [UIScreen mainScreen].bounds.size.width

#define HEIGHT [UIScreen mainScreen].bounds.size.height

@implementation ComicCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createCellUI];
        
    }
    
    return self;
}


+ (instancetype)cellWithTableView:(UITableView *)tableView {
    
    ComicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    
    if (!cell) {
        
        
        cell = [[ComicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
        
    }
    
    return cell;
    
}

- (void)createCellUI {
    
    self.coverView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 105, 138)];
    
    self.coverView.layer.cornerRadius = 5;
    
    self.coverView.layer.masksToBounds = YES;
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.coverView.frame) + 10, 10, WIDTH - 135, 20)];
    
    self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
    
    self.authouLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.coverView.frame) + 10, CGRectGetMaxY(self.titleLabel.frame) + 10, WIDTH - 135, 14)];
    
    self.authouLabel.font = [UIFont systemFontOfSize:16];
    
    self.descLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.coverView.frame) + 10, CGRectGetMaxY(self.authouLabel.frame) + 10, WIDTH - 135, 50)];
    
    self.descLabel.numberOfLines = 0;
    
    self.descLabel.font = [UIFont systemFontOfSize:12];
    
    self.updateLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.coverView.frame) + 10, CGRectGetMaxY(self.descLabel.frame) + 10, WIDTH - 135, 20)];
    
    self.updateLabel.font = [UIFont systemFontOfSize:13];
    
    [self.contentView addSubview:self.coverView];
    
    [self.contentView addSubview:self.titleLabel];
    
    [self.contentView addSubview:self.authouLabel];
    
    [self.contentView addSubview:self.descLabel];
    
    [self.contentView addSubview:self.updateLabel];
    
    
}


- (void)configCellWithModel:(ComicModel *)model {
    
    [self.coverView sd_setImageWithURL:[NSURL URLWithString:model.images] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
       
        [[SDImageCache sharedImageCache] storeImage:image forKey:model.comicId];
    }];
    
    self.titleLabel.text = model.name;
    
    self.authouLabel.text = [NSString stringWithFormat:@"作者:%@", model.author];
    
    self.descLabel.text = [NSString stringWithFormat:@"简介:%@", model.introduction];
    
    self.updateLabel.textColor = [UIColor redColor];
    
    if ([model.updateType isEqualToString:@"1"]) {
        
        self.updateLabel.text = [NSString stringWithFormat:@"%@  每周%@更新", model.updateInfo, model.updateValue];
        
    }else if ([model.updateType isEqualToString:@"2"]) {
        
        self.updateLabel.text = [NSString stringWithFormat:@"%@  每月%@日更新", model.updateInfo, model.updateValue];
        
    }else if ([model.updateType isEqualToString:@"3"]) {
        
        self.updateLabel.text = [NSString stringWithFormat:@"%@  每周%@更新", model.updateInfo, model.updateValue];
        
    }else if ([model.updateType isEqualToString:@"4"]) {
        
        self.updateLabel.text = [NSString stringWithFormat:@"%@  更新%@", model.updateInfo, model.updateValue];
        
    }else if ([model.updateType isEqualToString:@"5"]) {
        
        self.updateLabel.text = [NSString stringWithFormat:@"%@  %@更新", model.updateInfo, model.updateValue];
        
    }else if ([model.updateType isEqualToString:@"6"]){
        
        self.updateLabel.text = model.updateInfo;
        
    }
    
    
    
}


- (void)configSearchCellWithModel:(ComicModel *)model {
    
    [self.coverView sd_setImageWithURL:[NSURL URLWithString:model.images]];
    
    [[SDImageCache sharedImageCache] storeImage:self.coverView.image forKey:model.comicId];
    
    self.titleLabel.text = model.name;
    
    self.authouLabel.text = [NSString stringWithFormat:@"作者:%@", model.author];
    
    self.descLabel.text = [NSString stringWithFormat:@"简介:%@", model.introduction];
    
    self.updateLabel.textColor = [UIColor redColor];
    
    if ([model.updateType isEqualToString:@"1"]) {
        
        self.updateLabel.text = [NSString stringWithFormat:@"每周%@更新", model.updateValue];
        
    }else if ([model.updateType isEqualToString:@"2"]) {
        
        self.updateLabel.text = [NSString stringWithFormat:@"每月%@日更新", model.updateValue];
        
    }else if ([model.updateType isEqualToString:@"3"]) {
        
        self.updateLabel.text = [NSString stringWithFormat:@"每周%@更新", model.updateValue];
        
    }else if ([model.updateType isEqualToString:@"4"]) {
        
        self.updateLabel.text = [NSString stringWithFormat:@"更新%@", model.updateValue];
        
    }else if ([model.updateType isEqualToString:@"5"]) {
        
        self.updateLabel.text = [NSString stringWithFormat:@"%@新", model.updateValue];
        
    }
    
    
    
}


@end
