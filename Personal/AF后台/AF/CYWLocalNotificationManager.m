//
//  CYWLocalNotificationManager.m
//  SDWebImageLearn
//
//  Created by dengweihao on 2017/7/20.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import "CYWLocalNotificationManager.h"
#import <UIKit/UIKit.h>
static CYWLocalNotificationManager *mgr = nil;
@implementation CYWLocalNotificationManager

+ (instancetype)defaultManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        mgr = [[CYWLocalNotificationManager alloc]init];
    });
    return mgr;

}

- (void)fireLocalNotficationWithDelay:(NSTimeInterval)seconds {
    UILocalNotification *notification=[[UILocalNotification alloc]init];
    //设置调用时间
    notification.fireDate=[NSDate dateWithTimeIntervalSinceNow:seconds];//立即触发
    //设置通知属性
    notification.alertBody=@"上传完成"; //通知主体
    
    notification.applicationIconBadgeNumber=1;//应用程序图标右上角显示的消息数
    
    notification.alertAction =@"查看"; //待机界面的滑动动作提示
    
    notification.soundName = UILocalNotificationDefaultSoundName;//收到通知时播放的声音，默认消息声音
    
    //调用通知
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
}

@end
