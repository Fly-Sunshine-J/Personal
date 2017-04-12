//
//  ViewController.m
//  Record
//
//  Created by vcyber on 16/12/21.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVFoundation/AVFAudio.h>
#import "VDRecordTask.h"
#import "PCMSmallReader.h"
#import "AudioStreamer.h"
#import "AudioUtil.h"
#import "ChartViewController.h"

@interface ViewController ()<VDRecordDelegate, AVAudioRecorderDelegate>

@property (nonatomic, strong) VDRecordTask *record;
@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong) PCMSmallReader *reader;
@property (nonatomic, strong) AudioStreamer *stream;

@property (nonatomic, strong) AVAudioRecorder *recoder;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    _record = [[VDRecordTask alloc] init];
    _record.delegate = self;
    _path = [NSString stringWithFormat:@"%@/%@source.pcm", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0], @"1482462115"];
    NSError *err1;
    NSError *err2;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord withOptions:AVAudioSessionCategoryOptionMixWithOthers error:&err1];
    [[AVAudioSession sharedInstance] setActive:YES error:&err2];
    NSLog(@"err1 : %@, err2: %@", err1.localizedDescription, err2.localizedDescription);
}

- (IBAction)start:(UIButton *)sender {
    
    [_record AudioSessionInit:NO];
    [_record AudioSessionStart];
    _path = [NSString stringWithFormat:@"%@/%0.fsource.pcm", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0], [[NSDate date] timeIntervalSince1970]];
    
//    NSMutableDictionary *setting = [NSMutableDictionary dictionary];
//    [setting setValue:@(kAudioFormatMPEG4AAC) forKey:AVFormatIDKey];
//    [setting setValue:@(44100) forKey:AVSampleRateKey];
//    [setting setValue:@1 forKey:AVNumberOfChannelsKey];
//    [setting setValue:@16 forKey:AVLinearPCMBitDepthKey];
//    [setting setValue:@1 forKey:AVLinearPCMIsBigEndianKey];
//    [setting setValue:@1 forKey:AVLinearPCMIsFloatKey];
//    
//    NSError *error;
//    _recoder = [[AVAudioRecorder alloc] initWithURL:[NSURL fileURLWithPath:_path] settings:setting error:&error];
//    NSLog(@"error %@", error.localizedDescription);
//    _recoder.delegate = self;
//    if ([_recoder prepareToRecord]) {
//        [_recoder record];
//    }
//    
}





- (IBAction)stop:(UIButton *)sender {
    [_record AudioSessionDispose];
//    [_recoder stop];
}

- (IBAction)play:(id)sender {
//    AVAudioSession* audioSession = [AVAudioSession sharedInstance];
//    [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
//    [audioSession setActive:YES error:nil];
//    _reader = nil;
//    _reader = [[PCMSmallReader alloc] initWithPath:_path];
//    [_reader play];

    _stream = [[AudioStreamer alloc] initWithURL:[NSURL URLWithString:@"http://mp3.haoduoge.com/s/2017-01-05/1483609631.mp3"]];
    [_stream start];
    
}
- (IBAction)pause:(id)sender {
//    [_reader stop];
    
    [_record pauseAudio];
    [_stream pause];
}
- (IBAction)compress:(UIButton *)sender {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData *encodeData = [NSData data];
        NSData *data = [NSData dataWithContentsOfFile:_path];
        int result = [AudioUtil tsilkEncodeAudio:data encodedData:&encodeData samplingRate:16000 level:10];
        if (result == 0) {
            [encodeData writeToFile:[NSString stringWithFormat:@"%@/%@.pcm", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0], @"tem"] atomically:YES];
            NSLog(@"-------------------压缩完成");
        }
    });
}

- (IBAction)unCompress:(UIButton *)sender {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData *data = [NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/%@.pcm", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0], @"tem"]];
        NSData *decodeData = [NSData data];
        int result = [AudioUtil tsilkDecodeAudio:data decodedData:&decodeData samplingRate:16000];
        if (result == 0) {
            [decodeData writeToFile:[NSString stringWithFormat:@"%@/%@.pcm", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0], @"decode_tem"] atomically:YES];
            NSLog(@"----------------解压缩完成");
        }
    });
}


- (void)SendVoiceToServer:(NSData *)AudioData status:(NSString *)status isSpeaking:(BOOL)isSpeak {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSData *encodeData = [NSData data];
//    int result = [AudioUtil tsilkEncodeAudio:AudioData encodedData:&encodeData samplingRate:16000 level:10];
    if ([fileManager fileExistsAtPath:_path]) {
//        if (result == 0) {
            NSFileHandle *handle = [NSFileHandle fileHandleForWritingAtPath:_path];
            [handle seekToEndOfFile];
            [handle writeData:AudioData];
            [handle closeFile];
//    }
        
    }else {
//        NSData *data = [AudioUtil addHeader:AudioData channels:1 longSampleRate:16000 byteWidth:16];
//        [AudioUtil tsilkEncodeAudio:data encodedData:&encodeData samplingRate:16000 level:10];
        [fileManager createFileAtPath:_path contents:AudioData attributes:nil];
    }
}


- (IBAction)showBarChart:(UIButton *)sender {
    ChartViewController *chart = [[ChartViewController alloc] init];
    [self.navigationController pushViewController:chart animated:YES];
}




#pragma mark --AVAudioRecoderDelegate 
- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag {
    
}

/* if an error occurs while encoding it will be reported to the delegate. */
- (void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError * __nullable)error{
    
}


/* AVAudioRecorder INTERRUPTION NOTIFICATIONS ARE DEPRECATED - Use AVAudioSession instead. */

/* audioRecorderBeginInterruption: is called when the audio session has been interrupted while the recorder was recording. The recorded file will be closed. */
- (void)audioRecorderBeginInterruption:(AVAudioRecorder *)recorder NS_DEPRECATED_IOS(2_2, 8_0) {
    
}

/* audioRecorderEndInterruption:withOptions: is called when the audio session interruption has ended and this recorder had been interrupted while recording. */
/* Currently the only flag is AVAudioSessionInterruptionFlags_ShouldResume. */
- (void)audioRecorderEndInterruption:(AVAudioRecorder *)recorder withOptions:(NSUInteger)flags NS_DEPRECATED_IOS(6_0, 8_0) {
    
}

- (void)audioRecorderEndInterruption:(AVAudioRecorder *)recorder withFlags:(NSUInteger)flags NS_DEPRECATED_IOS(4_0, 6_0) {
    
}

/* audioRecorderEndInterruption: is called when the preferred method, audioRecorderEndInterruption:withFlags:, is not implemented. */
- (void)audioRecorderEndInterruption:(AVAudioRecorder *)recorder NS_DEPRECATED_IOS(2_2, 6_0) {
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
