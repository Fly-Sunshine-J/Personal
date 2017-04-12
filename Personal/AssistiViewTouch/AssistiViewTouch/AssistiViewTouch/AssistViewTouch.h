//
//  AssistViewTouch.h
//  AssistiViewTouch
//
//  Created by vcyber on 16/5/26.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SCREEN_SIZE [UIScreen mainScreen].bounds.size
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define WINDOW [[[UIApplication sharedApplication] delegate] window]

@class AssistViewTouch;

@protocol AssistViewTouchDelegate <NSObject>
@optional
/**
 *  默认的限制大小是父视图  可以通过代理修改限制大小
 *
 */
- (CGRect)limitRectOfAssistView:(AssistViewTouch *)assistV;

- (void)touchAssistView:(AssistViewTouch *)assistV;

@end

@interface AssistViewTouch : UIView

- (instancetype)initWithFrame:(CGRect)frame;

@property (nonatomic, weak) id<AssistViewTouchDelegate>delegate;

/**
 *  添加到父视图
 *
 *  @param superView
 */
- (void)addAssistViewInSuperView:(UIView *)superView;

@end
