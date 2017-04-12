//
//  VMNetworkingManager.h
//  VcyberNaturalLanguageMedia
//
//  Created by vcyber on 16/4/21.
//  Copyright © 2016年 dengweihao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Reachability.h"

@protocol VMNetworkingManagerDelegate <NSObject>

//弹出提示框
- (void)presentAlertView:(UIAlertController *)alert;

//Dismiss提示框
- (void)dismissAlertView:(UIAlertController *)alert;

@end

@interface VMNetworkingManager : NSObject

@property (strong, nonatomic) Reachability *hostReach;

@property (assign, nonatomic) BOOL isReachable;

@property (nonatomic, weak) id<VMNetworkingManagerDelegate>delegate;

+ (instancetype)shareManage;

//开启网络监测
- (void)startNetworkingObserver;

@end
