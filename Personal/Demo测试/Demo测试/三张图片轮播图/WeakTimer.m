//
//  WeakTimer.m
//  Cadillac
//
//  Created by vcyber on 17/2/6.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import "WeakTimer.h"

@interface WeakTimerTarget : NSObject

@property (nonatomic, weak) id target;
@property (nonatomic, assign) SEL selector;
@property (nonatomic, weak) NSTimer* timer;

@end


@implementation WeakTimerTarget

- (void) fire:(NSTimer *)timer {
    if(self.target) {
        
        [self.target performSelector:self.selector withObject:timer.userInfo afterDelay:0.0f];
        
    } else {
        [self.timer invalidate];
    }
}

@end

@implementation WeakTimer



+ (NSTimer *) scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                      target:(id)aTarget
                                    selector:(SEL)aSelector
                                    userInfo:(id)userInfo
                                     repeats:(BOOL)repeats {
    WeakTimerTarget *timerTarget = [[WeakTimerTarget alloc] init];
    timerTarget.target = aTarget;
    timerTarget.selector = aSelector;
    timerTarget.timer = [NSTimer scheduledTimerWithTimeInterval:interval
                                                         target:timerTarget
                                                       selector:@selector(fire:)
                                                       userInfo:userInfo
                                                        repeats:repeats];
    
    return timerTarget.timer;
}




@end
