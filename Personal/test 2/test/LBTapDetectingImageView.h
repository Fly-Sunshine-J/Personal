//
//  LBTapDetectingImageView.h
//  test
//
//  Created by dengweihao on 2017/3/16.
//  Copyright © 2017年 dengweihao. All rights reserved.
//

#import <UIKit/UIKit.h>
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define LB_DISMISS_DISTENCE SCREEN_HEIGHT

@protocol LBTapDetectingImageViewDelegate;

@interface LBTapDetectingImageView : UIImageView

@property (nonatomic, weak) id <LBTapDetectingImageViewDelegate> tapDelegate;

@end

@protocol LBTapDetectingImageViewDelegate <NSObject>

@required
- (void)imageViewNeedSuperViewStopLayout;
- (void)imageViewNeedSuperViewBeginLayout;
- (void)imageViewNeedDismiss;
@optional
- (void)imageView:(UIImageView *)imageView singleTapDetected:(UITouch *)touch;
- (void)imageView:(UIImageView *)imageView doubleTapDetected:(UITouch *)touch;
- (void)imageView:(UIImageView *)imageView tripleTapDetected:(UITouch *)touch;
- (void)imageViewDidMoved:(UIImageView *)imageView;


@end
