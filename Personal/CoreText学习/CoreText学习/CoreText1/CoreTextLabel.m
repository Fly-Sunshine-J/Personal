//
//  CoreTextLabel.m
//  CoreText学习
//
//  Created by vcyber on 17/8/30.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import "CoreTextLabel.h"
#import <CoreText/CoreText.h>

@implementation CoreTextLabel


/************
 CoreText坐标：
 ^
 |
 |
 |
 |
 |
 |
 |
 |
 ————————————————————————>
 
 UIKit坐标
 ————————————————————————>
 |
 |
 |
 |
 |
 |
 |
 |
 ∨
 **************/

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();

    //1.重置文本矩阵
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    //2.平移到矩形的开始位置  由于CoreText的坐标在左下  而我们正常的UIKit文字排列从左上开始
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    //3.平移之后再翻转y轴  这样就和UIKit里面的坐标保持一致
    CGContextScaleCTM(context, 1.0, -1.0);
    //4.创建绘制路径 绘图区域
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathAddRect(pathRef, NULL, self.bounds);
//    CGPathAddEllipseInRect(pathRef, NULL, self.bounds);
    //5.创建CTFrame
    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"Hello World"" 创建绘制的区域，CoreText 本身支持各种文字排版的区域，"
                                      " 我们这里简单地将 UIView 的整个界面作为排版的区域。"
                                      " 为了加深理解，建议读者将该步骤的代码替换成如下代码，"
                                      " 测试设置不同的绘制区域带来的界面变化。"];
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attrString);
    CTFrameRef frameRef = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, attrString.length), pathRef, NULL);
    //6.Draw
    CTFrameDraw(frameRef, context);
    
}


@end
