//
//  ViewController.h
//  CAAnimation-转场动画
//
//  Created by vcyber on 16/5/24.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ViewControllerDelegate <NSObject>

- (void)modalViewControllerDidClickedDismissBtn:(UIViewController *)viewController;

@end

@interface ViewController : UIViewController

@property (nonatomic, weak) id<ViewControllerDelegate>delegate;

@end

