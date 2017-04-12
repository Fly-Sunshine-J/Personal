//
//  PictureCell.m
//  ComicAndPicture
//
//  Created by MS on 16/3/8.
//  Copyright © 2016年 JFY. All rights reserved.
//

#import "PictureCell.h"

@implementation PictureCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.picView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH / 2 - 0.5, WIDTH / 2 - 0.5)];
        
        [self.contentView addSubview:self.picView];
        
        self.countLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.picView.frame) - 20, self.picView.frame.size.width, 20)];
        
        self.countLabel.backgroundColor = [UIColor colorWithWhite:0.7 alpha:0.8];
        
        self.countLabel.textAlignment = NSTextAlignmentCenter;
        
        self.countLabel.font = [UIFont systemFontOfSize:13];
        
        [self.contentView addSubview:self.countLabel];
        
        UIImageView *album = [[UIImageView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.picView.frame) / 2 - 30, CGRectGetMaxY(self.picView.frame) - 20, 20, 20)];
        
        album.image = [UIImage imageNamed:@"album"];
        
        [self.contentView addSubview:album];
        
    }
    return self;
}

@end
