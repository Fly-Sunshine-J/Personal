//
//  AppDelegate.h
//  SDWebImageLearn
//
//  Created by dengweihao on 2017/6/23.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^AppBackgroundUpLoadSessionCompletionHandler)(void);
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic , copy)AppBackgroundUpLoadSessionCompletionHandler backgroundSessionCompletionHandler;


@end

