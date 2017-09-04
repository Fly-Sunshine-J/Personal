//
//  AboutCTLineRef.m
//  CoreText学习
//
//  Created by vcyber on 17/9/1.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import "AboutCTLineRef.h"
#import <CoreText/CoreText.h>

@implementation AboutCTLineRef


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    
    CFStringRef string = CFStringCreateWithCString(NULL, "这里测试一下CTStringAttrfibute的自字体属性用法,这个是来进行测试 \nCoreText内容", kCFStringEncodingUTF8);
    
    CFAttributedStringRef attrs = CFAttributedStringCreate(NULL, string, NULL);
    CFRelease(string);
    
    CFMutableAttributedStringRef mutableAttrs = CFAttributedStringCreateMutableCopy(NULL, 0, attrs);
    CFRelease(attrs);
    
    CFIndex length = CFAttributedStringGetLength(mutableAttrs);
    
//    float kerningNumber = 2.0;
//    CFNumberRef kerning = CFNumberCreate(NULL, kCFNumberFloatType, &kerningNumber);
//    CFAttributedStringSetAttribute(mutableAttrs, CFRangeMake(0, length), kCTKernAttributeName, kerning);
//    CFRelease(kerning);
    
    
    //    同一坐标
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    //    创建CTFrame
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, rect);
    
    CTFramesetterRef setter = CTFramesetterCreateWithAttributedString(mutableAttrs);
    CTFrameRef frame = CTFramesetterCreateFrame(setter, CFRangeMake(0, length), path, NULL);
    
    CFArrayRef rows = CTFrameGetLines(frame);
    CFIndex rowsCount = CFArrayGetCount(rows);
    
    CTLineRef lineRef = CFArrayGetValueAtIndex(rows, 2);
    CFArrayRef runs = CTLineGetGlyphRuns(lineRef);
    CFIndex runsCount = CFArrayGetCount(runs);
    
    
    CGFloat secondaryOffset;
    ///相对于当前行的起始位置的偏移量 字距 + 字宽 如何有字距每一行的第一个字的默认字距是1
    CGFloat offset = CTLineGetOffsetForStringIndex(lineRef, 1, &secondaryOffset);
    
    CGFloat ascent, descent, leading;
    double width = CTLineGetTypographicBounds(lineRef, &ascent, &descent, &leading);
    
    CGRect lineRect = CTLineGetImageBounds(lineRef, context);
    
    
    CGPoint origins[rowsCount];
    CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), origins);
    for (int i = 0; i < rowsCount; i++) {
        CTLineRef lineRef = CFArrayGetValueAtIndex(rows, i);
        CGRect bounds = CTLineGetBoundsWithOptions(lineRef, 1 << 2);
//        CGRect bounds = CTLineGetImageBounds(lineRef, context);
        CGContextSetRGBStrokeColor(context, 1, 0, 0, 1);
        CGContextSetLineWidth(context, 1);
        CGContextAddRect(context, CGRectMake(origins[i].x, origins[i].y - descent, bounds.size.width, bounds.size.height));
        CGContextStrokePath(context);
        
        
    }
    
    CTFrameDraw(frame, context);
    
    CFRelease(path);
    CFRelease(setter);
    CFRelease(frame);
    CFRelease(mutableAttrs);
}


@end
