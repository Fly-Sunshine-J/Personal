//
//  FSLabel.m
//  CoreText学习2
//
//  Created by vcyber on 17/8/31.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import "FSLabel.h"

@implementation FSLabel


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [self aboutFontWithRect:rect];
}

//  字体属性  CoreText ->  CTStringAttribute
//  UIKit -> NSAttributeString
- (void)aboutFontWithRect:(CGRect)rect {
    NSMutableAttributedString *attrs = [[NSMutableAttributedString alloc] initWithString:@"这里测试一下CTStringAttribute的自字体属性用法"];
    //NSFontAttributeName  --> kCTFontAttributeName   字体大小
    [attrs addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:18] range:NSMakeRange(0, attrs.length)];
    
    //NSParagraphStyleAttributeName --> kCTParagraphStyleAttributeName  段落设置
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    [paraStyle setParagraphStyle:[NSParagraphStyle defaultParagraphStyle]];
    paraStyle
    [attrs addAttribute:NSParagraphStyleAttributeName value:<#(nonnull id)#> range:<#(NSRange)#>]
    [attrs drawInRect:rect];
}


@end
