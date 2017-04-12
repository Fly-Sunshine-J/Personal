//
//  AppDelegate.m
//  iOSNotifcation
//
//  Created by vcyber on 16/11/2.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "AppDelegate.h"
#ifdef NSFoundationVersionNumber_iOS_9_x_Max
#import <UserNotifications/UserNotifications.h>
#endif
#import "NotificationAction.h"

#define IOS10_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0)
#define IOS9_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
#define IOS8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IOS7_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)

@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self replyPushNotificationAuthorization:application];
    
    return YES;
}

- (void)replyPushNotificationAuthorization:(UIApplication *)application {
    if (IOS10_OR_LATER) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (!error && granted) {
                NSLog(@"点击了允许");
            }else {
                NSLog(@"点击了不允许");
            }
        }];
    }else if (IOS8_OR_LATER) {
        UIUserNotificationSettings *setting = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:nil];
        [application registerUserNotificationSettings:setting];
    }else {
        [application registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert];
    }
    [NotificationAction addNotification];
    [application registerForRemoteNotifications];
}


#pragma mark 获取token
//成功获取
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *deviceString = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    deviceString = [deviceString stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"deviceToken-----%@",deviceString);
}
//失败获取
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
    NSLog(@"%@", error.description);
}

#pragma mark UNUserNotificationCenterDelegate(iOS10接收通知时的代理)
//App前台收到推送
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    //收到推送的请求
    UNNotificationRequest *request = notification.request;
    
    //收到的内容
    UNNotificationContent *content = request.content;
    
    //收到用户的信息
    NSDictionary *userInfo = content.userInfo;
    
    //收到推送消息的角标
    NSNumber *badge = content.badge;
    
    //收到消息的body
    NSString *body = content.body;
    
    //收到消息的声音
    UNNotificationSound *sound = content.sound;
    
    //收到消息的副标题
    NSString *subTitle = content.subtitle;
    
    //收到消息的标题
    NSString *title = content.title;
    
    if ([request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        NSLog(@"接收到远程通知%@", userInfo);
    }else {
        NSLog(@"收到本地通知");
    }
    
    completionHandler(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert);
}

//App推送的点击事件
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    
    //action的唯一标识
    NSString *actionidentifierStr = response.actionIdentifier;
    
    if ([actionidentifierStr isEqualToString:@"look"]) {
        NSLog(@"点击了查看");
    }else if ([actionidentifierStr isEqualToString:@"join"]){
        NSLog(@"点击了加入");
    }else if ([actionidentifierStr isEqualToString:@"cancel"]){
        NSLog(@"点击了取消");
    }else if ([actionidentifierStr isEqualToString:@"input"]){
        NSLog(@"点击了输入");
        NSString *userInput = [(UNTextInputNotificationResponse *)response userText];
        NSLog(@"%@", userInput);
    }
    
    
    
    
    //收到推送的请求
    UNNotificationRequest *request = response.notification.request;
    
    //收到的内容
    UNNotificationContent *content = request.content;
    
    //收到用户的信息
    NSDictionary *userInfo = content.userInfo;
    
    //收到推送消息的角标
    NSNumber *badge = content.badge;
    
    //收到消息的body
    NSString *body = content.body;
    
    //收到消息的声音
    UNNotificationSound *sound = content.sound;
    
    //收到消息的副标题
    NSString *subTitle = content.subtitle;
    
    //收到消息的标题
    NSString *title = content.title;
    
    if ([request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        NSLog(@"点击远程通知%@", userInfo);
    }else {
        NSLog(@"点击本地通知");
    }
    
    completionHandler();
}

#pragma mark iOS7之后
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
    NSLog(@"收到推送%@", userInfo);
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
