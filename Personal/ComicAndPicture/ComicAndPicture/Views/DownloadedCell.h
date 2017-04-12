//
//  DownloadedCell.h
//  ComicAndPicture
//
//  Created by Wudan on 16/3/19.
//  Copyright © 2016年 JFY. All rights reserved.
//

#import "ComicCell.h"

@interface DownloadedCell : ComicCell

@property (nonatomic, strong) UIProgressView *progressView;

@property (nonatomic, strong) UILabel *progressLabel;

@end
