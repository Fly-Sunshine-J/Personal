//
//  CTFrameParse.m
//  CoreText学习
//
//  Created by vcyber on 17/8/30.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import "CTFrameParse.h"
///根据Config生成CTFrameRef
@implementation CTFrameParse


static CGFloat ascentCallback(void *ref){
    return [(NSNumber*)[(__bridge NSDictionary*)ref objectForKey:@"height"] floatValue];
}

static CGFloat descentCallback(void *ref){
    return 0;
}

static CGFloat widthCallback(void* ref){
    return [(NSNumber*)[(__bridge NSDictionary*)ref objectForKey:@"width"] floatValue];
}

+ (CoreTextData *)parseTemplateFile:(NSString *)path config:(CTFrameConfig *)config {
    NSMutableArray *images = [NSMutableArray array];
    NSMutableArray *links = [NSMutableArray array];
    
    NSAttributedString *attrString = [self loadTemplateFile:path config:config images:images links:links];
    CoreTextData *data = [self parseContent:attrString config:config];
    data.images = images;
    data.links = links;
    return data;
}


+ (NSAttributedString *)loadTemplateFile:(NSString *)path
                                  config:(CTFrameConfig *)config
                                  images:(NSMutableArray *)images
                                   links:(NSMutableArray *)links {
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc] init];
    if (data) {
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        if ([array isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dict in array) {
                NSString *type = dict[@"type"];
                if ([type isEqualToString:@"txt"]) {
                    NSAttributedString *txt = [self parseAttributedContentFromDict:dict config:config];
                    [result appendAttributedString:txt];
                }else if ([type isEqualToString:@"link"]) {
                    NSUInteger linkBegin = result.length;
                    NSAttributedString *link = [self parseAttributedContentFromDict:dict config:config];
                    [result appendAttributedString:link];
                    NSUInteger length = link.length;
                    CoreTextLinkData *linkData = [[CoreTextLinkData alloc] init];
                    linkData.tilte = dict[@"content"];
                    linkData.url = dict[@"url"];
                    linkData.range = NSMakeRange(linkBegin, length);
                    [links addObject:linkData];
                }else if ([type isEqualToString:@"img"]) {
                    CoreTextImageData *data = [[CoreTextImageData alloc] init];
                    data.name = dict[@"name"];
                    data.position = result.length;
                    [images addObject:data];
                    
                    NSAttributedString *img = [self parseImageDataFromDict:dict config:config];
                    [result appendAttributedString:img];
                    
                }
            }
        }
    }
    return result;
}

//将字典内为图片的转化为富文本  空白富文本  预留位置
+ (NSAttributedString *)parseImageDataFromDict:(NSDictionary *)dict
                                        config:(CTFrameConfig *)config {
    CTRunDelegateCallbacks callbacks;
    memset(&callbacks, 0, sizeof(CTRunDelegateCallbacks));
    callbacks.version = kCTRunDelegateVersion1;
    callbacks.getAscent = ascentCallback;
    callbacks.getWidth = widthCallback;
    callbacks.getDescent = descentCallback;
    CTRunDelegateRef delegate = CTRunDelegateCreate(&callbacks, (__bridge void * _Nullable)(dict));
    
//    使用0xFFFC作为空白的占位符
    unichar blankChar = 0xFFFC;
    NSString *blankString = [NSString stringWithCharacters:&blankChar length:1];
    NSDictionary *attrs = [self attributesWithConfig:config];
    NSMutableAttributedString *attrSting = [[NSMutableAttributedString alloc] initWithString:blankString attributes:attrs];
    CFAttributedStringSetAttribute((CFMutableAttributedStringRef)attrSting, CFRangeMake(0, 1), kCTRunDelegateAttributeName, delegate);
    CFRelease(delegate);
    return attrSting;
}



//根据字典里面的颜色返回真正的颜色
+ (UIColor *)colorFromTemplate:(NSString *)name {
    if ([name isEqualToString:@"blue"]) {
        return [UIColor blueColor];
    }else if ([name isEqualToString:@"red"]) {
        return [UIColor redColor];
    }else if ([name isEqualToString:@"black"]) {
        return [UIColor blackColor];
    }else {
        return nil;
    }
}

//根据字典里面的内容和配置  转化为富文本
+ (NSAttributedString *)parseAttributedContentFromDict:(NSDictionary *)dict config:(CTFrameConfig *)config {
    NSMutableDictionary *attrs = [self attributesWithConfig:config];
    UIColor *color = [self colorFromTemplate:dict[@"color"]];
    if (color) {
        attrs[(NSString *)kCTForegroundColorAttributeName] = (__bridge id _Nullable)(color.CGColor);
    }
    CGFloat fontSize = [dict[@"size"] floatValue];
    if (fontSize > 0) {
        CTFontRef fontRef = CTFontCreateWithName((CFStringRef)@"ArialMT", fontSize, NULL);
        attrs[(NSString *)kCTFontAttributeName] = (__bridge id _Nullable)(fontRef);
        CFRelease(fontRef);
    }
    NSString *content = dict[@"content"];
    return [[NSAttributedString alloc] initWithString:content attributes:attrs];
}


//  将NSAttributedString 配合CTFrameConfig  转化为CoreTextData
+ (CoreTextData *)parseContent:(NSAttributedString *)content
                        config:(CTFrameConfig *)config {
    
    CTFramesetterRef setterRef = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)content);
    
    //获取绘制区域
    CGSize rectSize = CGSizeMake(config.width, CGFLOAT_MAX);
    CGSize textSize = CTFramesetterSuggestFrameSizeWithConstraints(setterRef, CFRangeMake(0, 0), NULL, rectSize, NULL);
    CGFloat textHeight = textSize.height;
    CTFrameRef frameRef= [self createFrameWithFramesetterRef:setterRef config:config height:textHeight];
    CoreTextData *textData = [[CoreTextData alloc] init];
    textData.ctFrame = frameRef;
    textData.height = textHeight;
    
    CFRelease(frameRef);
    CFRelease(setterRef);
    return textData;
    
}

//创建CTFrame
+ (CTFrameRef)createFrameWithFramesetterRef:(CTFramesetterRef)framesetter
                                     config:(CTFrameConfig *)config
                                     height:(CGFloat)height {
    CGMutablePathRef pathRef = CGPathCreateMutable();
    CGPathAddRect(pathRef, NULL, CGRectMake(0, 0, config.width, height));
    CTFrameRef frameRef = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), pathRef, NULL);
    CFRelease(pathRef);
    return frameRef;
}


//将CTFrameConfig  转化为配置的字典
+ (NSMutableDictionary *)attributesWithConfig:(CTFrameConfig *)config {
    CGFloat fontSize = config.fontSize;
    CTFontRef fontRef = CTFontCreateWithName((CFStringRef)@"ArialMT", fontSize, NULL);
    CGFloat lineSpacing = config.lineSpace;
    const CFIndex kNumberOfSettings = 3;
    CTParagraphStyleSetting settings[kNumberOfSettings] = {
        {kCTParagraphStyleSpecifierLineSpacingAdjustment, sizeof(CGFloat), &lineSpacing},
        {kCTParagraphStyleSpecifierMaximumLineSpacing, sizeof(CGFloat), &lineSpacing},
        {kCTParagraphStyleSpecifierMaximumLineHeight, sizeof(CGFloat), &lineSpacing}
    };
    
    CTParagraphStyleRef paragraphStyleRef = CTParagraphStyleCreate(settings, kNumberOfSettings);
    
    UIColor *textColor = config.textColor;
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[(NSString *)kCTForegroundColorAttributeName] = (__bridge id _Nullable)(textColor.CGColor);
    dict[(NSString *)kCTFontAttributeName] = (__bridge id _Nullable)(fontRef);
    dict[(NSString *)kCTParagraphStyleAttributeName] = (__bridge id _Nullable)paragraphStyleRef;
    
    CFRelease(fontRef);
    CFRelease(paragraphStyleRef);

    return dict;
}

@end
