//
//  LocalNotificationHelper.m
//  iOSNotifcation
//
//  Created by vcyber on 16/11/3.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "LocalNotificationHelper.h"
#import <UserNotifications/UserNotifications.h>

@implementation LocalNotificationHelper

+ (void)createLocalUserNotification {
    UNTimeIntervalNotificationTrigger *timeTrigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:2 repeats:NO];
    UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
    content.title = @"推送标题 -title";
    content.subtitle = @"推送的副标题 -subtitle";
    content.body = @"推送的主体，主体的内容可以很长，但是超过两行会进行折叠 -body";
    content.badge = @666;
    content.sound = [UNNotificationSound defaultSound];
    content.userInfo = @{@"key1":@"value1", @"key2":@"value2"};
    
    content.categoryIdentifier = @"localCategory";
    
    
    //创建通知的标示，可以根据标示消息操作
    NSString *identifier = @"identifier1";
    
    //创建通知请求
    UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:identifier content:content trigger:timeTrigger];
    
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    
    //将UNNotificationRequest添加到UNUserNotificationCenter
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {
        
        if (!error) {
            NSLog(@"本地推送添加成功");
        }
    }];
}


@end
