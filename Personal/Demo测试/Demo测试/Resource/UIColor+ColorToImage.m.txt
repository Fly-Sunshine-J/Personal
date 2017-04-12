//
//  UIColor+ColorToImage.m
//  Demo测试
//
//  Created by vcyber on 16/6/30.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "UIColor+ColorToImage.h"

@implementation UIColor (ColorToImage)

- (UIImage *)imageWithSize:(CGSize)size {
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);;
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, self.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
