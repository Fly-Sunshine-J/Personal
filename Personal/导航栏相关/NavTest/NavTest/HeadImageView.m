//
//  HeadImageView.m
//  NavTest
//
//  Created by vcyber on 16/6/8.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "HeadImageView.h"

#define MSWidth [UIScreen mainScreen].bounds.size.width

@implementation HeadImageView

- (instancetype)initWithFrame:(CGRect)frame Image:(UIImage *)image {
    self = [super initWithFrame:frame];
    if (self) {
        
        
        float w = MSWidth;
        float h = MSWidth * (float)(image.size.height / image.size.width);
        float x = 0;
        float y = 0;
        
        self.frame = CGRectMake(frame.origin.x, frame.origin.x, w, h);
        
        CGRect r = CGRectMake(x, y, w, h);
        self.imageView.frame = r;
        self.imageView.image = image;
        [self addSubview:self.imageView];
    }
    return self;
}

- (void)setScale:(CGFloat)scale {
    
    _scale = scale;
    [UIView animateWithDuration:0.1 animations:^{
        self.imageView.transform = CGAffineTransformMakeScale(_scale + 1.5,_scale + 1.5);
    }];

    
}

- (UIImageView *)imageView {
    
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
    }
    return _imageView;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
}

@end
