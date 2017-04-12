//
//  MyAlertView.h
//  TextKit_Sample
//
//  Created by vcyber on 16/6/13.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MyAlertView;
@protocol MyAlertViewDelegate <NSObject>

/**
 *  立即预定按钮点击
 */
- (void)reservationBtnClick:(MyAlertView *)alertView;

@end


@interface MyAlertView : UIView

@property (nonatomic, weak) id<MyAlertViewDelegate>delegate;

- (instancetype)initWithFrame:(CGRect)frame Name:(NSString *)name Phone:(NSString *)phone Address:(NSString *)address;

- (void)show;

- (void)dismiss;

@end
