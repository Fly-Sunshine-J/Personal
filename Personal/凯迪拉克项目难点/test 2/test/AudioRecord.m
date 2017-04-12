//
//  AudioRecord.m
//  test
//
//  Created by vcyber on 17/3/16.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import "AudioRecord.h"
#import <AVFoundation/AVFoundation.h>

@interface AudioRecord ()<AVAudioRecorderDelegate> {
    AVAudioRecorder *_audioRecorder;
    BOOL _interruptedOnPlayback;
    BOOL _recording;
}


@end

@implementation AudioRecord

+ (instancetype)shareInstance {
    static AudioRecord *record;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        record = [AudioRecord new];
    });
    return record;
}



- (void)setRecordFileWithFilePath:(NSString *)filePath {
    NSMutableDictionary *setting = [NSMutableDictionary new];
    setting[AVFormatIDKey] = @(kAudioFormatMPEG4AAC);
    setting[AVSampleRateKey] = @(8000);
    setting[AVNumberOfChannelsKey] = @(1);
    NSError *initError;
    _audioRecorder = [[AVAudioRecorder alloc] initWithURL:[NSURL fileURLWithPath:filePath] settings:setting error:&initError];
    _audioRecorder.delegate = self;
    if (initError) {
        NSLog(@"初始化错误:%@", initError.localizedDescription);
        return;
    }
    NSError *sessionError;
    BOOL success = [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
    if (!success) {
        NSLog(@"setCategory:%@", sessionError.localizedDescription);
    }else {
        NSError *activeErr;
        [[AVAudioSession sharedInstance] setActive:YES error:&activeErr];
        if (activeErr) {
            NSLog(@"setActive: %@", activeErr.localizedDescription);
        }else {
            [_audioRecorder prepareToRecord];
        }
    }
}


- (BOOL)record {
    NSLog(@"开始");
    _recording = YES;
    return [_audioRecorder record];
}


- (void)pause {
    NSLog(@"暂停");
    _recording = NO;
    [_audioRecorder pause];
}

- (void)stop {
    NSLog(@"停止");
    _recording = NO;
    [_audioRecorder stop];
}


/* audioRecorderDidFinishRecording:successfully: is called when a recording has been finished or stopped. This method is NOT called if the recorder is stopped due to an interruption. */
- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag {
    if (flag) {
        NSLog(@"录音完成");
    }
}

/* if an error occurs while encoding it will be reported to the delegate. */
- (void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError * __nullable)error {
    NSLog(@"EncodeError: %@", error.localizedDescription);
}


/* AVAudioRecorder INTERRUPTION NOTIFICATIONS ARE DEPRECATED - Use AVAudioSession instead. */

/* audioRecorderBeginInterruption: is called when the audio session has been interrupted while the recorder was recording. The recorded file will be closed. */
- (void)audioRecorderBeginInterruption:(AVAudioRecorder *)recorder NS_DEPRECATED_IOS(2_2, 8_0) {
    if(_recording) {
        [self pause];
        _interruptedOnPlayback = YES;
    }
    
}

/* audioRecorderEndInterruption:withOptions: is called when the audio session interruption has ended and this recorder had been interrupted while recording. */
/* Currently the only flag is AVAudioSessionInterruptionFlags_ShouldResume. */
- (void)audioRecorderEndInterruption:(AVAudioRecorder *)recorder withOptions:(NSUInteger)flags NS_DEPRECATED_IOS(6_0, 8_0) {
    if(_interruptedOnPlayback){
        [_audioRecorder prepareToRecord];
        [self record];
        _interruptedOnPlayback = NO;
    }
}



@end
