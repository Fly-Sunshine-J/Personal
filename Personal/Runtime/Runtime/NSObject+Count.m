//
//  NSObject+Count.m
//  Runtime
//
//  Created by vcyber on 17/8/23.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import "NSObject+Count.h"
#import <objc/runtime.h>

static const void *countKey = &countKey;

@implementation NSObject (Count)

- (void)setCount:(NSInteger)count {
    objc_setAssociatedObject(self, countKey, @(count), OBJC_ASSOCIATION_ASSIGN);
}

- (NSInteger)count {
    return [objc_getAssociatedObject(self, countKey) integerValue];
}

@end
