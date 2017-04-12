//
//  JFYRecordController.m
//  StreamMedia(Study)
//
//  Created by vcyber on 16/5/5.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "JFYRecordController.h"
#import <AVFoundation/AVFoundation.h>
#import "VMAudioPlayer.h"
#import "JFYMusicModel.h"

#define kRecordAudioFile @"/myRecord.caf"

@interface JFYRecordController()<AVAudioRecorderDelegate>
@property (weak, nonatomic) IBOutlet UIButton *recordBtn;
@property (weak, nonatomic) IBOutlet UIButton *pauseBtn;
@property (weak, nonatomic) IBOutlet UIButton *startBtn;
@property (weak, nonatomic) IBOutlet UIButton *stopBtn;

@property (nonatomic, strong) AVAudioRecorder *audioRecoder; //录音对象
@property (nonatomic, strong) VMAudioPlayer *audioPlayer; //播放录音的对象
@end

@implementation JFYRecordController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    [audioSession setActive:YES error:nil];

}

- (NSURL *)getSaveFileURL {
    
    NSString *urlStr = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    urlStr = [urlStr stringByAppendingString:kRecordAudioFile];
    NSURL *url = [NSURL fileURLWithPath:urlStr];
    return url;
}

- (NSDictionary *)getAudioSetting {
    
    NSMutableDictionary *setting = [NSMutableDictionary dictionary];
    //设置录音格式
    [setting setObject:@(kAudioFormatLinearPCM) forKey:AVFormatIDKey];
    //设置录音采样频率 8000电话采样率 一般的够用
    [setting setObject:@8000 forKey:AVSampleRateKey];
    //设置通道 这里采用单声道
    [setting setObject:@(1) forKey:AVNumberOfChannelsKey];
    //设置采样点位数,分别为8,16,24,32
    [setting setObject:@(8) forKey:AVLinearPCMBitDepthKey];
    //是否使用浮点数采样
    [setting setObject:@(YES) forKey:AVLinearPCMIsFloatKey];
    
    return setting;
}

- (AVAudioRecorder *)audioRecoder {
    
    if (!_audioRecoder) {
        
        NSURL *url = [self getSaveFileURL];
        NSDictionary *setting = [self getAudioSetting];
        NSError *error = nil;
        _audioRecoder = [[AVAudioRecorder alloc] initWithURL:url settings:setting error:&error];
        _audioRecoder.delegate = self;
        _audioRecoder.meteringEnabled = YES;//监听声波变化必须设为YES
        if (error) {
            
            NSLog(@"%@",error.localizedDescription);
            return nil;
        }
    }
    return _audioRecoder;
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    JFYMusicModel *model = [[JFYMusicModel alloc] init];
    model.musicURL =[self getSaveFileURL];
    model.music = @"我的录音";
    model.singer = @"JFY";
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:model];
    [[VMAudioPlayer shareVMAVPlayer] createAudioPlayerWithPlayList:array];
    [[VMAudioPlayer shareVMAVPlayer] play];
    
}

- (IBAction)recordClick:(id)sender {
    
    if (![self.audioRecoder isRecording]) {
        
        [self.audioRecoder record];
        
    }
}

- (IBAction)pauseClick:(id)sender {
    
    if (![self.audioRecoder isRecording]) {
        
        [self.audioRecoder pause];
        
    }
}

- (IBAction)resumeClick:(id)sender {
    
    if (![self.audioRecoder isRecording]) {
        
        [self recordClick:sender];
        
    }
}


- (IBAction)stopClick:(id)sender {
    
    [self.audioRecoder stop];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
