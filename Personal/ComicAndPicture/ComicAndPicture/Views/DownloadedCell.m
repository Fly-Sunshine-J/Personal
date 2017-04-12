//
//  DownloadedCell.m
//  ComicAndPicture
//
//  Created by Wudan on 16/3/19.
//  Copyright © 2016年 JFY. All rights reserved.
//

#import "DownloadedCell.h"

@implementation DownloadedCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createCellUI];
        
        [self addViews];
        
    }
    
    return self;
    
}

- (void)addViews {
    
    self.progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.coverView.frame) + 10, WIDTH - 90, 10)];
    
    [self.contentView addSubview:self.progressView];
    
    self.progressLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.progressView.frame) + 5, CGRectGetMaxY(self.coverView.frame) + 5, 60, 20)];
    
    self.progressLabel.textAlignment = NSTextAlignmentCenter;
    
    self.progressLabel.font = [UIFont systemFontOfSize:14];
    
    [self.contentView addSubview:self.progressLabel];
    
}

@end
