//
//  ContentLabel.m
//  CoreText学习
//
//  Created by vcyber on 17/8/30.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import "ContentLabel.h"

@implementation ContentLabel


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    if (!_data) {
        return;
    }
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CTFrameDraw(_data.ctFrame, context);
    for (CoreTextImageData *imageData in _data.images) {
        UIImage *image = [UIImage imageNamed:imageData.name];
        if (image) {
            CGContextDrawImage(context, imageData.imagePosition, image.CGImage);
        }
    }
}


@end
