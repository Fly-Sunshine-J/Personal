//
//  FKCell.m
//  ComicAndPicture
//
//  Created by MS on 16/3/10.
//  Copyright © 2016年 JFY. All rights reserved.
//

#import "FKCell.h"

@implementation FKCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.picView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH / 2 - 0.5, WIDTH / 2 - 0.5)];
        
        [self.contentView addSubview:self.picView];
        
        self.picView.image = [UIImage imageNamed:@"default_image"];
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.picView.frame) - 20, WIDTH / 2 - 0.5, 20)];
        
        self.nameLabel.textAlignment = NSTextAlignmentCenter;
        
        self.nameLabel.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.2];
        
        self.nameLabel.textColor = [UIColor colorWithRed:1 green:0 blue:177 / 255.0 alpha:1];
        
        [self.contentView addSubview:self.nameLabel];
        
    }
    return self;
}

@end
