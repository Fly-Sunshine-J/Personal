//
//  boxViewController.h
//  自定义抽屉
//
//  Created by vcyber on 16/6/7.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    ModalViewControlComeFromLeft = 0,
    ModalViewControlComeFromRight,
} ModalViewControlComeFromType;

@interface boxViewController : UIViewController

@property(nonatomic, assign)CGFloat sideAnimationTime;
@property(nonatomic, assign)CGFloat sideWith;
//如果有键盘的时候，点击只取消键盘而不返回
@property (nonatomic,assign) BOOL leftEnabled;
@property(nonatomic, strong)UIView *contentView;

@property (nonatomic, assign)ModalViewControlComeFromType comeFromType;

- (void)showWithComeFromType:(ModalViewControlComeFromType)FromType;

@end
