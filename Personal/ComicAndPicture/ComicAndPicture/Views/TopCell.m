//
//  TopCell.m
//  ComicAndPicture
//
//  Created by MS on 16/3/10.
//  Copyright © 2016年 JFY. All rights reserved.
//

#import "TopCell.h"

@implementation TopCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        self.imagesView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 666 * WIDTH / 1600)];
        
        [self.contentView addSubview:self.imagesView];
        
    }
    
    return self;
}

@end
