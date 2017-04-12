//
//  VMNetworkingManager.m
//  VcyberNaturalLanguageMedia
//
//  Created by vcyber on 16/4/21.
//  Copyright © 2016年 dengweihao. All rights reserved.
//

#import "VMNetworkingManager.h"
#import "VMAlertView.h"

@interface VMNetworkingManager() {

    UIAlertController *_alert;
}

@end

@implementation VMNetworkingManager

+(instancetype)shareManage {
    
    static VMNetworkingManager *manage;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manage  = [[VMNetworkingManager alloc] init];
        
    });
    
    return manage;
}


- (void)startNetworkingObserver {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChange:) name:kReachabilityChangedNotification object:nil];
    
    self.hostReach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    
    [self.hostReach startNotifier];
    
}

- (void)reachabilityChange:(NSNotification *)noti {
    
    Reachability *reach = [noti object];
    
    NetworkStatus status = [reach currentReachabilityStatus];
    
    self.isReachable = YES;
    
    if (status == NotReachable) {
        
        NSLog(@"Networking is not reachable");
        
        [self showAlertViewWithTitle:@"" Message:@"网络错误,请检查网络错误" ActionTitle1:nil ActionTitle:nil];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self disMissAlertView];
            
        });
        
        self.isReachable = NO;
        
    }else {
        
        self.isReachable = YES;
        
        NSLog(@"networking is reachable");
        
        if (status == ReachableViaWiFi) {
            
            NSLog(@"networking is WIFI");
            
//            [self showAlertViewWithTitle:@"" Message:@"aaaaaaa" ActionTitle1:@"停止播放" ActionTitle:@"继续播放"];
            
            UIWindow *window = [[[UIApplication sharedApplication] delegate] window];
            
            VMAlertView *alertView = [[VMAlertView alloc] initWithFrame:CGRectZero];
            
            [window addSubview:alertView];
            
        }else if (status == ReachableViaWWAN) {
            
            NSLog(@"networking is 3G");
            
            [self showAlertViewWithTitle:@"" Message:@"" ActionTitle1:@"停止播放" ActionTitle:@"继续播放"];
            
        }
        
    }
    
}


- (void)showAlertViewWithTitle:(NSString *)title Message:(NSString *)message ActionTitle1:(NSString *)actionTitle1 ActionTitle:(NSString *)actionTitle2{
    
    _alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    if (actionTitle1 && actionTitle1) {
        
        UIAlertAction *action1 = [UIAlertAction actionWithTitle:actionTitle1 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
        }];
        
        UIAlertAction *action2 = [UIAlertAction actionWithTitle:actionTitle2 style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            
        }];
        
        [_alert addAction:action1];
        
        [_alert addAction:action2];
        
    }
    
    [self.delegate presentAlertView:_alert];
    
}

- (void)disMissAlertView {
    
    [self.delegate dismissAlertView:_alert];
    
}

@end
