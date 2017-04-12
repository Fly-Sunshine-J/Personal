//
//  FKPicCell.m
//  ComicAndPicture
//
//  Created by MS on 16/3/12.
//  Copyright © 2016年 JFY. All rights reserved.
//

#import "FKPicCell.h"

@implementation FKPicCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.picView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH / 3 - 1, WIDTH / 3 - 1)];
        
        [self.contentView addSubview:self.picView];
        
    }
    return self;
}

@end
