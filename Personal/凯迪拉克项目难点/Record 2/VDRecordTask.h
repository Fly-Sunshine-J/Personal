//
//  VDRecordTask.h
//  NewerVDSDK
//
//  Created by dengweihao on 16/3/16.
//  Copyright © 2016年 dengweihao. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol VDRecordDelegate <NSObject>

- (void)SetVolumeState:(int)voiceNum AudioValid:(BOOL)valid;
- (void)SendVoiceToServer:(NSData *)AudioData status:(NSString *)status isSpeaking:(BOOL)isSpeak;

@end


@interface VDRecordTask : NSObject

@property (weak, nonatomic) id <VDRecordDelegate>delegate;

- (void)AudioSessionInit:(BOOL)is16k MaxVoiceTime:(NSInteger)_maxVoicetime VoiceScale:(double)VoK;

- (OSStatus)AudioSessionStart;

- (void)AudioSessionDispose;

- (void)StopAudio;

- (void)SetCancle;

- (void)SetAudioValid;



@end