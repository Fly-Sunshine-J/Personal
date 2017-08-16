//
//  UIButton+MyButton.m
//  IGListKitExamples
//
//  Created by vcyber on 17/8/16.
//  Copyright © 2017年 Instagram. All rights reserved.
//

#import "UIButton+MyButton.h"
#import <objc/runtime.h>

static void *blockKey = &blockKey;

@implementation UIButton (MyButton)

- (void)setTargetBlock:(void (^)(UIButton *))targetBlock {
    objc_setAssociatedObject(self, &blockKey, targetBlock, OBJC_ASSOCIATION_COPY);
}

- (void (^)(UIButton *))targetBlock {
    return objc_getAssociatedObject(self, &blockKey);
}


- (UIButton *(^)(UIColor *))FS_BackgroundColor {
    UIButton *(^block)() = ^(UIColor *color) {
        self.backgroundColor = color;
        return self;
    };
    return block;
}

- (UIButton *(^)(void(^)(UIButton *), UIControlEvents event))FS_AddTargetBlock {
    UIButton *(^block)() = ^(void(^targetBlock)(UIButton *), UIControlEvents event) {
        self.targetBlock = targetBlock;
        [self addTarget:self action:@selector(targetBlockSEL) forControlEvents:event];
        return self;
    };
    return block;
}

- (UIButton *(^)(UIView *))FS_AddInView {
    UIButton *(^block)() = ^(UIView *superView) {
        [superView addSubview:self];
        return self;
    };
    return block;
}

- (void)targetBlockSEL {
    if (self.targetBlock) {
        self.targetBlock(self);
    }
}

@end
