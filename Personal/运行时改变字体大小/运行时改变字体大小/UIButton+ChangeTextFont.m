//
//  UIButton+ChangeTextFont.m
//  运行时改变字体大小
//
//  Created by vcyber on 16/8/19.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "UIButton+ChangeTextFont.h"
#import <objc/runtime.h>
#import "CustomBtn.h"
@implementation UIButton (ChangeTextFont)

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method method0 = class_getInstanceMethod(self.class, @selector(setTitle:forState:));
        Method method1 = class_getInstanceMethod(self.class, @selector(customTitle:forState:));
        method_exchangeImplementations(method0, method1);
    });
}


- (void) customTitle:(NSString *)text forState:(UIControlState)state {
    
    if ([self isKindOfClass:[CustomBtn class]]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeTextSize:) name:@"changeTextSize" object:nil];
    }
    [self customTitle:text forState:state];
}

- (void)changeTextSize:(NSNotification *)noti {
    
    self.titleLabel.font = [UIFont systemFontOfSize:(11 * [[[NSUserDefaults standardUserDefaults] valueForKey:@"fontsize"] floatValue])];
}

@end
