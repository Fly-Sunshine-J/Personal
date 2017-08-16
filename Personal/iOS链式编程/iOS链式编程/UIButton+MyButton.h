//
//  UIButton+MyButton.h
//  IGListKitExamples
//
//  Created by vcyber on 17/8/16.
//  Copyright © 2017年 Instagram. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (MyButton)

@property (nonatomic, copy) void(^targetBlock)(UIButton *);

- (UIButton *(^)(UIColor *))FS_BackgroundColor;
- (UIButton *(^)(void(^)(UIButton *), UIControlEvents))FS_AddTargetBlock;
- (UIButton *(^)(UIView *))FS_AddInView;

@end
