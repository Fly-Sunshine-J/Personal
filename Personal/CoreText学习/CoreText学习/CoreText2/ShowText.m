//
//  ShowText.m
//  CoreText学习
//
//  Created by vcyber on 17/8/31.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import "ShowText.h"
#import <CoreText/CoreText.h>
#import <CoreGraphics/CoreGraphics.h>

@implementation ShowText


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {

    [self aboutFontWithRect:rect];
    
    
}

//  字体属性  CoreText ->  CTStringAttribute
//  UIKit -> NSAttributeString
- (void)aboutFontWithRect:(CGRect)rect {
    CFStringRef string = CFStringCreateWithCString(NULL, "这里测试一下CTStringAttrfibute的自字体属性用法,这个是来进行测试 \nCoreText内容", kCFStringEncodingUTF8);
    
    CFAttributedStringRef attrs = CFAttributedStringCreate(NULL, string, NULL);
    CFRelease(string);
    
    CFMutableAttributedStringRef mutableAttrs = CFAttributedStringCreateMutableCopy(NULL, 0, attrs);
    CFRelease(attrs);
    
    CFIndex length = CFAttributedStringGetLength(mutableAttrs);
    
    //kCTFontAttributeName  --> NSFontAttributeName 字体大小
    //UIFont --> CFFontRef
    CFArrayRef fontArray = CTFontManagerCopyAvailableFontFamilyNames();
    CFIndex count = CFArrayGetCount(fontArray);
    for (int i = 0; i < count; i++) {
        NSLog(@"%@", (NSString *)CFArrayGetValueAtIndex(fontArray, i));
    }
    
    CFStringRef fontName = CFStringCreateWithCString(NULL, "TimesNewRomanPSMT", kCFStringEncodingUTF8);
    CTFontRef font = CTFontCreateWithName(fontName, 17, NULL);
    CFAttributedStringSetAttribute(mutableAttrs, CFRangeMake(0, length), kCTFontAttributeName, font);
    CFRelease(fontName);
    CFRelease(font);
    
    
    //kCTKernAttributeName -->NSKernAttributeName 字距  默认间距是0.0
    float kerningNumber = 2.0;
    CFNumberRef kerning = CFNumberCreate(NULL, kCFNumberFloatType, &kerningNumber);
    CFAttributedStringSetAttribute(mutableAttrs, CFRangeMake(0, length), kCTKernAttributeName, kerning);
    CFRelease(kerning);
    
    //kCTLigatureAttributeName -->NSLigatureAttributeName
    ///设置是否使用连字属性，设置为0，表示不使用连字属性。标准的英文连字有FI,FL.默认值为1，既是使用标准连字。也就是当搜索到f时候，会把fl当成一个文字。必须是CFNumberRef 默认为1,可取0,1,2
    
    //kCTForegroundColorAttributeName -->NSForegroundColorAttributeName  字体颜色
    CGColorRef foregroundColor = [UIColor redColor].CGColor;
    CFAttributedStringSetAttribute(mutableAttrs, CFRangeMake(2, 10), kCTForegroundColorAttributeName, foregroundColor);
    CFRelease(foregroundColor);
    
    //kCTBackgroundColorAttributeName -->NSBackgroundColorAttributeName 背景色
    CGColorRef backgroundColor = [UIColor greenColor].CGColor;
    CFAttributedStringSetAttribute(mutableAttrs, CFRangeMake(0, length), kCTBackgroundColorAttributeName, backgroundColor);
    CFRelease(backgroundColor);
    
    
    //NSParagraphStyleAttributeName --> kCTParagraphStyleAttributeName  段落设置(行间距 对齐方式 文字的切断方式 书写方向 首行缩进等一系列的属性)
///    kCTParagraphStyleSpecifierAlignment = 0,                 //对齐属性
///    kCTParagraphStyleSpecifierFirstLineHeadIndent = 1,       //首行缩进
///    kCTParagraphStyleSpecifierHeadIndent = 2,                //段头缩进
///    kCTParagraphStyleSpecifierTailIndent = 3,                //段尾缩进
///    kCTParagraphStyleSpecifierTabStops = 4,                  //制表符模式
///    kCTParagraphStyleSpecifierDefaultTabInterval = 5,        //默认tab间隔
///    kCTParagraphStyleSpecifierLineBreakMode = 6,             //换行模式
///    kCTParagraphStyleSpecifierLineHeightMultiple = 7,        //多行高
///    kCTParagraphStyleSpecifierMaximumLineHeight = 8,         //最大行高
///    kCTParagraphStyleSpecifierMinimumLineHeight = 9,         //最小行高
///    kCTParagraphStyleSpecifierLineSpacing = 10,              //行距
///    kCTParagraphStyleSpecifierParagraphSpacing = 11,         //段落间距  在段的未尾（Bottom）加上间隔，这个值为负数。
///    kCTParagraphStyleSpecifierParagraphSpacingBefore = 12,   //段落前间距 在一个段落的前面加上间隔。TOP
///    kCTParagraphStyleSpecifierBaseWritingDirection = 13,     //基本书写方向
///    kCTParagraphStyleSpecifierMaximumLineSpacing = 14,       //最大行距
///    kCTParagraphStyleSpecifierMinimumLineSpacing = 15,       //最小行距
///    kCTParagraphStyleSpecifierLineSpacingAdjustment = 16,    //行距调整
///    kCTParagraphStyleSpecifierCount = 17,        //
    
    
//    CTParagraphStyleSetting alignment;
//    alignment.spec = kCTParagraphStyleSpecifierAlignment;
//    alignment.valueSize = sizeof(CTTextAlignment);
//    CTTextAlignment alignmentValue = kCTTextAlignmentCenter;
//    alignment.value = &alignmentValue;
    
    CTParagraphStyleSetting firstLineHeadIndent;
    firstLineHeadIndent.spec = kCTParagraphStyleSpecifierFirstLineHeadIndent;
    firstLineHeadIndent.valueSize = sizeof(CGFloat);
    CGFloat firstLineHeadIndentValue = 20.0;
    firstLineHeadIndent.value = &firstLineHeadIndentValue;

    CTParagraphStyleSetting headIndent;
    headIndent.spec = kCTParagraphStyleSpecifierHeadIndent;
    headIndent.valueSize = sizeof(CGFloat);
    CGFloat headIndentValue = 15.0;
    headIndent.value = &headIndentValue;

//    CTParagraphStyleSetting tailIndent;
//    tailIndent.spec = kCTParagraphStyleSpecifierTailIndent;
//    tailIndent.valueSize = sizeof(CGFloat);
//    CGFloat tailIndentValue = 150.0;
//    tailIndent.value = &tailIndentValue;

    CTParagraphStyleSetting lineBreakMode;
    lineBreakMode.spec = kCTParagraphStyleSpecifierLineBreakMode;
    lineBreakMode.valueSize = sizeof(CTLineBreakMode);
    CTLineBreakMode lineBreakModeValue = kCTLineBreakByCharWrapping;
    lineBreakMode.value = &lineBreakModeValue;

    CTParagraphStyleSetting lineHeightMultiple;
    lineHeightMultiple.spec = kCTParagraphStyleSpecifierLineHeightMultiple;
    lineHeightMultiple.valueSize = sizeof(CGFloat);
    CGFloat lineHeightMultipleValue = 1.0;
    lineHeightMultiple.value = &lineHeightMultipleValue;

    CTParagraphStyleSetting lineSpacing;
    lineSpacing.spec = kCTParagraphStyleSpecifierLineSpacingAdjustment;
    lineSpacing.valueSize = sizeof(CGFloat);
    CGFloat lineSpacingValue = 10.0;
    lineSpacing.value = &lineSpacingValue;

    CTParagraphStyleSetting paragraphSpacing;
    paragraphSpacing.spec = kCTParagraphStyleSpecifierParagraphSpacing;
    paragraphSpacing.valueSize = sizeof(CGFloat);
    CGFloat paragraphSpacingValue = 10.0;
    paragraphSpacing.value = &paragraphSpacingValue;
    
    CTParagraphStyleSetting baseWritingDirection;
    baseWritingDirection.spec = kCTParagraphStyleSpecifierBaseWritingDirection;
    baseWritingDirection.valueSize = sizeof(CTWritingDirection);
    CTWritingDirection baseWritingDirectionValue = kCTWritingDirectionRightToLeft;
    baseWritingDirection.value = &baseWritingDirectionValue;
    
    CTParagraphStyleSetting settings[] = {
//        alignment,
        firstLineHeadIndent,
        headIndent,
//        tailIndent,
        lineBreakMode,
//        lineHeightMultiple,
        lineSpacing,
        paragraphSpacing,
//        baseWritingDirection
    };

    CTParagraphStyleRef paragraphStyle = CTParagraphStyleCreate(settings, 7);
    CFAttributedStringSetAttribute(mutableAttrs, CFRangeMake(0, length), kCTParagraphStyleAttributeName, paragraphStyle);
   
    //kCTStrokeWidthAttributeName  ->  NSStrokeWidthAttributeName  镂空宽度  经常用的是3
    CGFloat width = 3;
    CFNumberRef strokeWidth = CFNumberCreate(NULL, kCFNumberCGFloatType, &width);
    CFAttributedStringSetAttribute(mutableAttrs, CFRangeMake(2, 4), kCTStrokeWidthAttributeName, strokeWidth);
    CFRelease(strokeWidth);
    
    //kCTStrokeColorAttributeName --> NSStrokeColorAttributeName
    CGColorRef strokeColor = [UIColor purpleColor].CGColor;
    CFAttributedStringSetAttribute(mutableAttrs, CFRangeMake(2, 4), kCTStrokeColorAttributeName, strokeColor);
    
    //kCTUnderlineStyleAttributeName -->NSUnderlineStyleAttributeName  下划线
    CTUnderlineStyle lineStyle = kCTUnderlineStyleSingle | kCTUnderlinePatternDot;
    CFNumberRef lineStyleRef = CFNumberCreate(NULL, kCFNumberSInt32Type, &lineStyle);
    CFAttributedStringSetAttribute(mutableAttrs, CFRangeMake(10, 10), kCTUnderlineStyleAttributeName, lineStyleRef);
    
    //kCTVerticalFormsAttributeName -> NSVerticalGlyphFormAttributeName 字体方向
    CFBooleanRef boolRef = kCFBooleanTrue;
    CFAttributedStringSetAttribute(mutableAttrs, CFRangeMake(7, 2), kCTVerticalFormsAttributeName, boolRef);

    ///不知道有什么用
    //kCTHorizontalInVerticalFormsAttributeName  0, 1, 2, 3, 4  This attribute only works when kCTVerticalFormsAttributeName is set to true.
//    int number = 3;
//    CFNumberRef horizontalInVerticalFormsAttributeName = CFNumberCreate(NULL, kCFNumberIntType, &number);
//    CFAttributedStringSetAttribute(mutableAttrs, CFRangeMake(7, 1), kCTHorizontalInVerticalFormsAttributeName, horizontalInVerticalFormsAttributeName);
    
//    同一坐标
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, rect.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
//    计算CTFrame
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, rect);
    
    CTFramesetterRef setter = CTFramesetterCreateWithAttributedString(mutableAttrs);
    CTFrameRef frame = CTFramesetterCreateFrame(setter, CFRangeMake(0, length), path, NULL);
    
    
    CTFrameDraw(frame, context);
    
    
    CFRelease(path);
    CFRelease(setter);
    CFRelease(frame);
    CFRelease(mutableAttrs);
}


@end
