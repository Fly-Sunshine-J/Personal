//
//  NSString+Valid.m
//  环信Demo
//
//  Created by vcyber on 16/5/31.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "NSString+Valid.h"

@implementation NSString (Valid)

- (BOOL)isChinese {
    
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
    
}

@end
