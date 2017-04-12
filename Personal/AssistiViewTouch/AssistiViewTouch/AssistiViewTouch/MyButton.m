//
//  MyButton.m
//  AssistiViewTouch
//
//  Created by vcyber on 16/5/26.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "MyButton.h"

@implementation MyButton

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    
    CGRect bounds = self.bounds;
    CGFloat widthExtra = MAX(self.eventSize.width - bounds.size.width, 0);
    CGFloat heightExtra = MAX(self.eventSize.height -bounds.size.height, 0);
    bounds = CGRectInset(bounds, -0.5 * widthExtra, -0.5 * heightExtra);
    return CGRectContainsPoint(bounds, point);
}

@end
