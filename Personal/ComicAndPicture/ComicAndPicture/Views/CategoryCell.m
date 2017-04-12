//
//  CategoryCell.m
//  ComicAndPicture
//
//  Created by MS on 16/3/12.
//  Copyright © 2016年 JFY. All rights reserved.
//

#import "CategoryCell.h"

@implementation CategoryCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.coverView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, (WIDTH - 60) / 3 , (WIDTH - 60) / 3)];
        
        self.coverView.layer.cornerRadius = 10;
        
        self.coverView.clipsToBounds = YES;
        
        [self.contentView addSubview:self.coverView];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.coverView.frame), (WIDTH - 60) / 3, 20)];
        
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.contentView addSubview:self.nameLabel];
        
        
    }
    return self;
}

@end
