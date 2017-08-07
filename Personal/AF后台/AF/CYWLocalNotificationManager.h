//
//  CYWLocalNotificationManager.h
//  SDWebImageLearn
//
//  Created by dengweihao on 2017/7/20.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CYWLocalNotificationManager : NSObject

+ (instancetype)defaultManager;

- (void)fireLocalNotficationWithDelay:(NSTimeInterval)seconds;


@end
