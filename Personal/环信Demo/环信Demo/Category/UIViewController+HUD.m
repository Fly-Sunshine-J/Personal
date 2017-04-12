//
//  UIViewController+HUD.m
//  环信Demo
//
//  Created by vcyber on 16/5/31.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "UIViewController+HUD.h"
#import <MBProgressHUD.h>
#import <objc/runtime.h>

static const void *HUD = &HUD;

@implementation UIViewController (HUD)

- (MBProgressHUD *)HUD {
    
    return objc_getAssociatedObject(self, HUD);
}

- (void)setHUD:(MBProgressHUD *)hud {
    
    objc_setAssociatedObject(self, HUD, hud, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)showHUDInView:(UIView *)view WithMesssage:(NSString *)message {
    
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:view];
    hud.labelText = message;
    [view addSubview:hud];
    [hud show:YES];
    [self setHUD:hud];
}

- (void)showHUDWithMessage:(NSString *)message {
    
    UIView *view = [[UIApplication sharedApplication].delegate window];
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.userInteractionEnabled = NO;
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    hud.margin = 10.f;
    hud.yOffset = 180;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:2];
}

- (void)hideHUD {
    
    [[self HUD] hide:YES];
}

- (void)showAlertViewWithTitle:(nullable NSString *)title AndMessage:(nullable NSString *)message prefrredStyle:(UIAlertControllerStyle)style ActionArray:(nullable NSMutableArray<UIAlertAction *> *)actionArray completion:(void (^ __nullable)(void))completion{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:style];
    for (UIAlertAction *action in actionArray) {
        [alertController addAction:action];
    }
    
    [self presentViewController:alertController animated:YES completion:^{
        
        if (completion != nil) {
            completion();
        }
    }];
}

@end
