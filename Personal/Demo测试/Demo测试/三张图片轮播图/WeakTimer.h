//
//  WeakTimer.h
//  Cadillac
//
//  Created by vcyber on 17/2/6.
//  Copyright © 2017年 vcyber. All rights reserved.
//
//

#import <Foundation/Foundation.h>

@interface WeakTimer : NSObject

+ (NSTimer *) scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                      target:(id)aTarget
                                    selector:(SEL)aSelector
                                    userInfo:(id)userInfo
                                     repeats:(BOOL)repeats;

@end
