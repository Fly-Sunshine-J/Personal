//
//  JFYSoundEffect.m
//  StreamMedia(Study)
//
//  Created by vcyber on 16/5/4.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "JFYSoundEffect.h"
#import <AudioToolbox/AudioToolbox.h>

@implementation JFYSoundEffect

static JFYSoundEffect *soundeEffect = nil;

+(instancetype)shareSoundEffect {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        soundeEffect = [[JFYSoundEffect alloc] init];
        
    });
    
    return soundeEffect;
}

- (void)playSoundEffect:(NSString *)soundName {
    
    NSString *soundPath = [[NSBundle mainBundle] pathForResource:soundName ofType:nil];
    
    NSURL *fileUrl = [NSURL fileURLWithPath:soundPath];
    
    //获取系统声音ID
    SystemSoundID soundID = 0;
    /**
     *
     *
     *  @param CFURLRef 音频文件Url
     *
     *  @param OutSystemSoundID:(声音id)
     *
     */
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(fileUrl), &soundID);
    
    //如过在播放完成之后需要执行某些操作,可以调用下面的方法注册一个播放完成的回调
    AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, soundCompleteCallBack, NULL);
    
    //播放音频
    AudioServicesPlaySystemSound(soundID);
}


//播放完成回调方法
void soundCompleteCallBack (SystemSoundID soundID, void *clientData) {
    
    NSLog(@"播放完成");
}

@end
