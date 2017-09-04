//
//  CoreTextData.m
//  CoreText学习
//
//  Created by vcyber on 17/8/30.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import "CoreTextData.h"

@implementation CoreTextData

- (void)setCtFrame:(CTFrameRef)ctFrame {
    if (_ctFrame != ctFrame) {
        if (_ctFrame != nil) {
            CFRelease(_ctFrame);
        }
    }
    CFRetain(ctFrame);
    _ctFrame = ctFrame;
}

- (void)dealloc {
    if (!_ctFrame) {
        CFRelease(_ctFrame);
        _ctFrame = NULL;
    }
}

- (void)setImages:(NSArray<CoreTextImageData *> *)images {
    _images = images;
    [self fillImagePosition];
}

- (void)fillImagePosition {
    if (_images.count == 0) {
        return;
    }
    
    CFArrayRef lines = CTFrameGetLines(_ctFrame);
    NSUInteger linesCount = CFArrayGetCount(lines);
    CGPoint lineOrigins[linesCount];
    CTFrameGetLineOrigins(_ctFrame, CFRangeMake(0, 0), lineOrigins);
    
    int imgIndex = 0;
    CoreTextImageData *imageData = _images[imgIndex];
    
    for (int i = 0; i < linesCount; i++) {
        if (imageData == nil) {
            return;
        }
        
        CTLineRef line = CFArrayGetValueAtIndex(lines, i);
        NSArray *runs = (__bridge NSArray *)CTLineGetGlyphRuns(line);
        for (id run in runs) {
            CTRunRef runRef = (__bridge CTRunRef)(run);
            CFDictionaryRef dict = CTRunGetAttributes(runRef);
            CTRunDelegateRef delegate = CFDictionaryGetValue(dict, kCTRunDelegateAttributeName);
            if (delegate == nil) {
                continue;
            }

            NSDictionary *metaDic = CTRunDelegateGetRefCon(delegate);
            if (![metaDic isKindOfClass:[NSDictionary class]]) {
                continue;
            }
            
            CGRect runBounds;
            CGFloat ascent;
            CGFloat descent;
            runBounds.size.width = CTRunGetTypographicBounds(runRef, CFRangeMake(0, 0), &ascent, &descent, NULL);
            runBounds.size.height = ascent + descent;
            
            CGFloat xOffset = CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(runRef).location, NULL);
            runBounds.origin.x = lineOrigins[i].x + xOffset;
            runBounds.origin.y = lineOrigins[i].y;
            runBounds.origin.y -= descent;
            
            CGPathRef path = CTFrameGetPath(_ctFrame);
            CGRect colRect = CGPathGetBoundingBox(path);
            CGRect delegateBounds = CGRectOffset(runBounds, colRect.origin.x, colRect.origin.y);
            
            imageData.imagePosition = delegateBounds;
            imgIndex ++;
            if (imgIndex == _images.count) {
                imageData = nil;
                break;
            }else {
                imageData = _images[imgIndex];
            }
        }
        
    }
}

@end
