//
//  UIView+Border.m
//  Runtime
//
//  Created by vcyber on 17/6/27.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import "UIView+Border.h"
#import <objc/runtime.h>

static IMP _setColor;

static const void *pageKey = &pageKey;
static const void *nameKey = &nameKey;

@implementation UIView (Border)

+ (void)load {
/***********************************交换方法************************/
    //方法1
//    Method method = class_getInstanceMethod(self, @selector(setBackgroundColor:));
//    _setColor = method_setImplementation(method, (IMP)colorOfBackground);
    //方法2
    _setColor = class_replaceMethod(self, @selector(setBackgroundColor:), (IMP)colorOfBackground, "v@:@");
    //方法3
//    Method method1 = class_getInstanceMethod(self, @selector(setBackgroundColor:));
//    Method method2 = class_getInstanceMethod(self, @selector(colorForBackgroundColor:));
//    method_exchangeImplementations(method1, method2);
/***********************************交换方法************************/
}

- (void)colorForBackgroundColor:(UIColor *)color {
    [self colorForBackgroundColor:color];
    NSLog(@"设置颜色成功， 并替换了方法 ---colorForBackgroundColor");
}

void colorOfBackground(UIView *view, SEL sel, UIColor *color) {
    ((void (*)(UIView *, SEL, UIColor *))_setColor)(view, sel, color);
    NSLog(@"设置颜色成功， 并替换了方法 ---colorOfBackground");
}

- (void)setPage:(int)page {
    objc_setAssociatedObject(self, pageKey, @(page), OBJC_ASSOCIATION_ASSIGN);
}

- (int)page {
    return [objc_getAssociatedObject(self, pageKey) intValue];
}


- (void)setName:(NSString *)name {
    objc_setAssociatedObject(self, nameKey, name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)name {
    return objc_getAssociatedObject(self, nameKey);
}

@end
