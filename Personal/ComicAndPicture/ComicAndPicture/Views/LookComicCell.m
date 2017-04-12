//
//  LookComicCell.m
//  ComicAndPicture
//
//  Created by MS on 16/3/12.
//  Copyright © 2016年 JFY. All rights reserved.
//

#import "LookComicCell.h"

@implementation LookComicCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.comicView = [[UIImageView alloc] initWithFrame:CGRectZero];
        
        [self.contentView addSubview:self.comicView];
        
    }
    
    return self;
}

@end
