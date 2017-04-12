//
//  UIColor+ColorToImage.m
//  自定义抽屉
//
//  Created by vcyber on 16/6/7.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "UIColor+ColorToImage.h"

@implementation UIColor (ColorToImage)

- (UIImage *)transformToImage
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [self CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
