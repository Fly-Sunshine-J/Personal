//
//  UIViewController+HUD.h
//  环信Demo
//
//  Created by vcyber on 16/5/31.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (HUD)

- (void)showHUDInView:(UIView *)view WithMesssage:(NSString *)message;

- (void)showHUDWithMessage:(NSString *)message;

- (void)hideHUD;

- (void)showAlertViewWithTitle:(nullable NSString *)title AndMessage:(nullable NSString *)message prefrredStyle:(UIAlertControllerStyle)style ActionArray:(nullable NSMutableArray<UIAlertAction *> *)actionArray completion:(void (^ __nullable)(void))completion;

@end
