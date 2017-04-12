//
//  UINavigationController+YYShouldPopCategory.m
//  截获导航栏系统返回按钮事件和右划pop事件
//
//  Created by vcyber on 16/7/27.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "UINavigationController+YYShouldPopCategory.h"
#import <objc/runtime.h>

static NSString *delegateKey = @"delegateKey";

@implementation UINavigationController (YYShouldPopCategory)

+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSEL = @selector(navigationBar:shouldPopItem:);
        SEL swizzledSEL = @selector(yy_navigationBar:shouldPopItem:);
        
        Method orginalMethod = class_getInstanceMethod(class, originalSEL);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSEL);
        
        BOOL didAddMethod = class_addMethod(class, originalSEL, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (didAddMethod) {
            class_replaceMethod(class, originalSEL, method_getImplementation(orginalMethod), method_getTypeEncoding(orginalMethod));
        }else {
            method_exchangeImplementations(orginalMethod, swizzledMethod);
        }
    
    });
}



- (BOOL)yy_navigationBar:(UINavigationBar *)navigationBar shouldPopItem:(UINavigationItem *)item {
    
    UIViewController *vc = self.topViewController;
    if (item != vc.navigationItem) {
        return YES;
    }
    
    if ([vc conformsToProtocol:@protocol(YYNavigationControllerShouldPopDelegate)]) {
        if ([(id<YYNavigationControllerShouldPopDelegate>)vc navigationControllerShouldPop:self]) {
            return [self yy_navigationBar:navigationBar shouldPopItem:item];
        }else {
            return NO;
        }
    }else {
        return [self yy_navigationBar:navigationBar shouldPopItem:item];
    }
    
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    objc_setAssociatedObject(self, &delegateKey, self.interactivePopGestureRecognizer.delegate, OBJC_ASSOCIATION_ASSIGN);
    
    self.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
}


- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        UIViewController *vc = [self topViewController];
        if ([vc conformsToProtocol:@protocol(YYNavigationControllerShouldPopDelegate)]) {
            if ([(id<YYNavigationControllerShouldPopDelegate>)vc respondsToSelector:@selector(navigationControllerStartInteractivepopGestureRecoginizer:)]) {
                return [(id<YYNavigationControllerShouldPopDelegate>)vc navigationControllerStartInteractivepopGestureRecoginizer:self];
            }
    
        }
        id<UIGestureRecognizerDelegate> originDelegate = objc_getAssociatedObject(self, &delegateKey);
        return [originDelegate gestureRecognizerShouldBegin:gestureRecognizer];
    }
    return YES;
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        id<UIGestureRecognizerDelegate>orginDelegate = objc_getAssociatedObject(self, &delegateKey);
        return [orginDelegate gestureRecognizer:gestureRecognizer shouldReceiveTouch:touch];
    }
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    
    
    if (gestureRecognizer == self.interactivePopGestureRecognizer) {
        id<UIGestureRecognizerDelegate> originDelegate = objc_getAssociatedObject(self, &delegateKey);
        return [originDelegate gestureRecognizer:gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:otherGestureRecognizer];
    }
    return YES;
}

@end
