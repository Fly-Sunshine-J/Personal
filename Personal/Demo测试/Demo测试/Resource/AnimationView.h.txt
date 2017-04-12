//
//  AnimationView.h
//  BezierPath
//
//  Created by vcyber on 16/6/22.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AnimationViewDelegate <NSObject>

- (void)completeAnimation;

@end

@interface AnimationView : UIView

@property (nonatomic, weak) id<AnimationViewDelegate>delegate;

@end
