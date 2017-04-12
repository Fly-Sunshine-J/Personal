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
#import "SSZipArchive/ZipArchive.h"

@interface ViewController ()<VDRecordDelegate, AVAudioRecorderDelegate>{
    BOOL pause;
}

@property (nonatomic, strong) VDRecordTask *record;
@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong) PCMSmallReader *reader;
@property (nonatomic, strong) AudioStreamer *stream;

@property (nonatomic, strong) AVAudioRecorder *recorder;


@property (nonatomic, strong) NSString *tempZipPath;
@property (nonatomic, strong) NSString *temUnzipPath;

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
    _path = [NSString stringWithFormat:@"%@/%0.fsource.m4a", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0], [[NSDate date] timeIntervalSince1970]];
    
    [_record AudioSessionInit:NO AudioPath:_path];
    [_record AudioSessionStart];
    
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

    _stream = [[AudioStreamer alloc] initWithURL:[NSURL URLWithString:@"http://192.168.6.9/2.mp3"]];
    [_stream start];
    
}
- (IBAction)pause:(id)sender {
//    [_reader stop];
    pause = !pause;
    if (pause) {
        [_record pauseAudio];
    }else {
        [_record AudioSessionStart];
    }
    
    [_stream pause];
}
- (IBAction)compress:(UIButton *)sender {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData *encodeData = [NSData data];
        NSData *data = [NSData dataWithContentsOfFile:_path];
        int result = [AudioUtil tsilkEncodeAudio:data encodedData:&encodeData samplingRate:16000 level:10];
        if (result == 0) {
            [encodeData writeToFile:[NSString stringWithFormat:@"%@/%@.m4a", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0], @"tem"] atomically:YES];
            NSLog(@"-------------------压缩完成");
        }
    });
}

- (IBAction)unCompress:(UIButton *)sender {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSData *data = [NSData dataWithContentsOfFile:[NSString stringWithFormat:@"%@/%@.m4a", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0], @"tem"]];
        NSData *decodeData = [NSData data];
        int result = [AudioUtil tsilkDecodeAudio:data decodedData:&decodeData samplingRate:16000];
        if (result == 0) {
            [decodeData writeToFile:[NSString stringWithFormat:@"%@/%@.m4a", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0], @"decode_tem"] atomically:YES];
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


- (IBAction)zip:(UIButton *)sender {
    NSString *sampleDataPath = [[NSBundle mainBundle].bundleURL URLByAppendingPathComponent:@"Sample Data" isDirectory:YES].path;
    BOOL success = [SSZipArchive createZipFileAtPath:self.tempZipPath withContentsOfDirectory:sampleDataPath];
    if (success) {
        NSLog(@"打包成功");
    }
}


- (IBAction)unzip:(UIButton *)sender {
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:self.tempZipPath]) {
        return;
    }
    
    if (![manager fileExistsAtPath:self.temUnzipPath]) {
        [manager createDirectoryAtPath:self.temUnzipPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    
    BOOL success = [SSZipArchive unzipFileAtPath:self.tempZipPath toDestination:self.temUnzipPath];
    if (success) {
        NSLog(@"解包成功");
        NSData *data = [NSData dataWithContentsOfFile:self.tempZipPath];
        [manager removeItemAtPath:self.tempZipPath error:nil];
    }
}

- (NSString *)tempZipPath {
    if (!_tempZipPath) {
        _tempZipPath = [NSString stringWithFormat:@"%@/temp.zip", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]];
    }
    return _tempZipPath;
}


- (NSString *)temUnzipPath {
    if (!_temUnzipPath) {
        _temUnzipPath = [NSString stringWithFormat:@"%@/tempUnzip", [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]];
    }
    return _temUnzipPath;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
