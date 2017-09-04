//
//  UIImage+Decoder.m
//  test
//
//  Created by dengweihao on 2017/8/23.
//  Copyright © 2017年 dengweihao. All rights reserved.
//

#import "UIImage+Decoder.h"
#import <ImageIO/ImageIO.h>

@implementation UIImage (Decoder)
#pragma mark - 这里是老版的SDWebImage提供的加载Gif的动画的方法 新版取消了 只默认取gif的第一帧
// 高内存 低cpu --> 对较大的gif图片来说  内存会很大
+ (UIImage *)sdOverdue_animatedGIFWithData:(NSData *)data {
    if (!data) {
        return nil;
    }
    
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    
    size_t count = CGImageSourceGetCount(source);
    
    UIImage *animatedImage;
    
    if (count <= 1) {
        animatedImage = [[UIImage alloc] initWithData:data];
    }
    else {
        NSMutableArray *images = [NSMutableArray array];
        
        NSTimeInterval duration = 0.0f;
        
        for (size_t i = 0; i < count; i++) {
            CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
            
            duration += [self sdOverdue_frameDurationAtIndex:i source:source];
            
            [images addObject:[UIImage imageWithCGImage:image scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp]];
            
            CGImageRelease(image);
        }
        
        if (!duration) {
            duration = (1.0f / 10.0f) * count;
        }
        
        animatedImage = [UIImage animatedImageWithImages:images duration:duration];
    }
    
    CFRelease(source);
    
    return animatedImage;
}
+ (float)sdOverdue_frameDurationAtIndex:(NSUInteger)index source:(CGImageSourceRef)source {
    float frameDuration = 0.1f;
    CFDictionaryRef cfFrameProperties = CGImageSourceCopyPropertiesAtIndex(source, index, nil);
    NSDictionary *frameProperties = (__bridge NSDictionary *)cfFrameProperties;
    NSDictionary *gifProperties = frameProperties[(NSString *)kCGImagePropertyGIFDictionary];
    
    NSNumber *delayTimeUnclampedProp = gifProperties[(NSString *)kCGImagePropertyGIFUnclampedDelayTime];
    if (delayTimeUnclampedProp) {
        frameDuration = [delayTimeUnclampedProp floatValue];
    }
    else {
        
        NSNumber *delayTimeProp = gifProperties[(NSString *)kCGImagePropertyGIFDelayTime];
        if (delayTimeProp) {
            frameDuration = [delayTimeProp floatValue];
        }
    }
    
    if (frameDuration < 0.011f) {
        frameDuration = 0.100f;
    }
    CFRelease(cfFrameProperties);
    
    return frameDuration;
}

- (NSArray<UIImage *> *)lb_animatedGIFDuration:(NSTimeInterval **)frameDurations andTotalDuration:(NSTimeInterval *)totalDuration fromData:(NSData *)data {
    if (!data) {
        return nil;
    }
    NSMutableArray *images = [NSMutableArray array];
    CGImageSourceRef source = CGImageSourceCreateWithData((__bridge CFDataRef)data, NULL);
    
    size_t count = CGImageSourceGetCount(source);

    *frameDurations = (NSTimeInterval *)malloc(count  * sizeof(NSTimeInterval));
    
    
    for (NSUInteger i = 0; i < count; i++) {
        
            NSTimeInterval frameDuration = [self.class sdOverdue_frameDurationAtIndex:i source:source];
            (*frameDurations)[i] = frameDuration;
            *totalDuration += frameDuration;
            CGImageRef image = CGImageSourceCreateImageAtIndex(source, i, NULL);
            [images addObject:[UIImage imageWithCGImage:image scale:[UIScreen mainScreen].scale orientation:UIImageOrientationUp]];
            CGImageRelease(image);
    }
    CFRelease(source);
    return images;
}

@end
