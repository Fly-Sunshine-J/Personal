//
//  AppDelegate.m
//  JPushTest
//
//  Created by vcyber on 16/5/25.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "AppDelegate.h"
#import "JPUSHService.h"
#import "ViewController.h"
#import "TestViewController.h"
@interface AppDelegate ()
@property (nonatomic, strong) UINavigationController *nav;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    ViewController *viewController = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"ViewController"];
    
    UINavigationController *nav =[[UINavigationController alloc] initWithRootViewController:viewController];
    self.window.rootViewController = nav;
    self.nav = nav;
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) {
        
        [JPUSHService registerForRemoteNotificationTypes:(UIUserNotificationTypeBadge |
                                                          UIUserNotificationTypeSound |
                                                          UIUserNotificationTypeAlert) categories:nil];
    }else {
        
        [JPUSHService registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                         UIRemoteNotificationTypeSound |
                                                          UIRemoteNotificationTypeAlert) categories:nil];
    }
    
    [JPUSHService setupWithOption:launchOptions appKey:@"ae42b5d9475913586e13daf4" channel:@"1" apsForProduction:NO];
    
    //如果 App 状态为未运行，此函数将被调用，如果launchOptions包含UIApplicationLaunchOptionsRemoteNotificationKey表示用户点击apn 通知导致app被启动运行；如果不含有对应键值则表示 App 不是因点击apn而被启动，可能为直接点击icon被启动或其他
    NSDictionary *remoteNotification = [launchOptions objectForKey:UIApplicationLaunchOptionsRemoteNotificationKey];
    NSLog(@"remoteNotification = %@", remoteNotification);
    
    /**
     *  自定义消息内容获取   只有在前端运行的时候才能收到自定义消息的推送
     */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(netWorkDidReceiveMessage:) name:kJPFNetworkDidReceiveMessageNotification object:nil];
    
    /**
     *  本地通知内容获取：如果 App 状态为未运行
     */
    
    NSDictionary *localNotification = [launchOptions objectForKey: UIApplicationLaunchOptionsLocalNotificationKey];
    NSLog(@"localNotification = %@", localNotification);
    
    return YES;
}


- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    
    [JPUSHService showLocalNotificationAtFront:notification identifierKey:@"identifierKey"];
    
}

- (void)netWorkDidReceiveMessage:(NSNotification *)noti {
    
    NSDictionary *userInfo = noti.userInfo;
    NSLog(@"kJPFNetworkDidReceiveMessageNotification %@", userInfo);
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    
    [JPUSHService registerDeviceToken:deviceToken];
    NSLog(@"deviceToken = %@", deviceToken);
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
//    基于iOS 6 及以下的系统版本，如果 App状态为正在前台或者点击通知栏的通知消息，那么此函数将被调用，并且可通过AppDelegate的applicationState是否为UIApplicationStateActive判断程序是否在前台运行
    [JPUSHService handleRemoteNotification:userInfo];
    NSLog(@"didReceiveRemoteNotification userInfo = %@", userInfo);
    
}


- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    //    基于iOS 7 及以下的系统版本，如果 App状态为正在前台或者点击通知栏的通知消息，那么此函数将被调用，并且可通过AppDelegate的applicationState是否为UIApplicationStateActive判断程序是否在前台运行
    [JPUSHService handleRemoteNotification:userInfo];
    completionHandler(UIBackgroundFetchResultNewData);
    NSLog(@"fetchCompletionHandler userInfo = %@", userInfo);
    [JPUSHService resetBadge];
    [application setApplicationIconBadgeNumber:0];
    [self.nav pushViewController:[[TestViewController alloc] init] animated:YES];
}

@end
