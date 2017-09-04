//
//  UIImage+Decoder.h
//  test
//
//  Created by dengweihao on 2017/8/23.
//  Copyright © 2017年 dengweihao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Decoder)
+ (UIImage *)sdOverdue_animatedGIFWithData:(NSData *)data;

- (NSArray<UIImage *> *)lb_animatedGIFDuration:(NSTimeInterval **)frameDurations andTotalDuration:(NSTimeInterval *)totalDuration fromData:(NSData *)data;
@end
