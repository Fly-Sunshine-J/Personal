//
//  UILabel+changeTextFont.m
//  运行时改变字体大小
//
//  Created by vcyber on 16/8/19.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "UILabel+changeTextFont.h"
#import  <objc/runtime.h>
#import "CustomLabel.h"

@implementation UILabel (changeTextFont)

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method method0 = class_getInstanceMethod(self.class, @selector(setText:));
        Method method1 = class_getInstanceMethod(self.class, @selector(customTitle:));
        method_exchangeImplementations(method0, method1);
    });
}


- (void) customTitle:(NSString *)text {
    
    if ([self isKindOfClass:[CustomLabel class]]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeTextSize:) name:@"changeTextSize" object:nil];
    }
    [self customTitle:text];
}

- (void)changeTextSize:(NSNotification *)noti {
    //11是我默认设置的文字大小,你根据需求该这个数就行
    self.font = [UIFont systemFontOfSize:(11 * [[[NSUserDefaults standardUserDefaults] valueForKey:@"fontsize"] floatValue])];
}

@end
