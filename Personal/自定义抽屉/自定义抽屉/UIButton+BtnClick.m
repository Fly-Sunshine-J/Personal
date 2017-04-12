//
//  UIButton+BtnClick.m
//  自定义抽屉
//
//  Created by vcyber on 16/6/20.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "UIButton+BtnClick.h"
#import <objc/runtime.h>

static char *key;

@implementation UIButton (BtnClick)

@dynamic block;

- (void)BtnClickWithAction:(clickBlock)actionBlock event:(UIControlEvents)event {
    
    objc_setAssociatedObject(self, key, actionBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(click:) forControlEvents:event];
}

- (void)click:(UIButton *)btn {
    
    clickBlock block = objc_getAssociatedObject(self, key);
    if (block) {
        block();
    }
}

@end
