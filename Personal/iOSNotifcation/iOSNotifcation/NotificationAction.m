//
//  NotificationAction.m
//  iOSNotifcation
//
//  Created by vcyber on 16/11/3.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "NotificationAction.h"
#import <UserNotifications/UserNotifications.h>

@implementation NotificationAction

+ (void)addNotification {
    UNNotificationAction *lookAction = [UNNotificationAction actionWithIdentifier:@"look" title:@"查看邀请" options:UNNotificationActionOptionForeground];
    UNNotificationAction *joinAction = [UNNotificationAction actionWithIdentifier:@"join" title:@"加入邀请" options:UNNotificationActionOptionAuthenticationRequired];
    UNNotificationAction *cancelAction = [UNNotificationAction actionWithIdentifier:@"cancel" title:@"取消" options:UNNotificationActionOptionDestructive];
    UNTextInputNotificationAction *inputAction = [UNTextInputNotificationAction actionWithIdentifier:@"input" title:@"输入" options:UNNotificationActionOptionAuthenticationRequired textInputButtonTitle:@"发送" textInputPlaceholder:@"textPlacehold"];
    
    UNNotificationCategory *category = [UNNotificationCategory categoryWithIdentifier:@"localCategory" actions:@[lookAction, joinAction, inputAction, cancelAction] intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];
    [[UNUserNotificationCenter currentNotificationCenter] setNotificationCategories:[NSSet setWithObject:category]];
}

@end
