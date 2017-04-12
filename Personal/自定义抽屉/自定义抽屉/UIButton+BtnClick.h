//
//  UIButton+BtnClick.h
//  自定义抽屉
//
//  Created by vcyber on 16/6/20.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^clickBlock)(void);

@interface UIButton (BtnClick)
@property (nonatomic, copy)clickBlock block;

- (void)BtnClickWithAction:(clickBlock)actionBlock event:(UIControlEvents)event;
@end
