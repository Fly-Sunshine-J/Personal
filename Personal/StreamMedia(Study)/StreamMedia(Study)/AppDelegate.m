//
//  AppDelegate.m
//  StreamMedia(Study)
//
//  Created by vcyber on 16/5/4.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "AppDelegate.h"
#import <AVFoundation/AVFoundation.h>
#import "VMAudioPlayer.h"

@interface AppDelegate ()

@property (nonatomic, assign) UIBackgroundTaskIdentifier bgTask;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    return YES;
}

- (void)remoteControlReceivedWithEvent:(UIEvent *)event {
    if (event.type == UIEventTypeRemoteControl) {
        switch (event.subtype) {
                
            case UIEventSubtypeRemoteControlPreviousTrack:{
                
                NSLog(@"上一首");
                
                [[VMAudioPlayer shareVMAVPlayer] last];
            }
                
                break;
                
            case UIEventSubtypeRemoteControlNextTrack:{
                
                NSLog(@"下一首");
                [[VMAudioPlayer shareVMAVPlayer] next];
            }
                
                break;
                
            case UIEventSubtypeRemoteControlPlay: {
                
                [[VMAudioPlayer shareVMAVPlayer] play];
                
                NSLog(@"播放");
            }
                
                break;
                
            case UIEventSubtypeRemoteControlPause:{
                
                [[VMAudioPlayer shareVMAVPlayer] pause];
                
                NSLog(@"暂停");
            }
                
                break;
                
            default:
                break;
        }
    }
}

- (BOOL)canBecomeFirstResponder {
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    _bgTask = [application beginBackgroundTaskWithExpirationHandler:^{

            
            [application endBackgroundTask:_bgTask];
        
    }];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [application endBackgroundTask:_bgTask];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
