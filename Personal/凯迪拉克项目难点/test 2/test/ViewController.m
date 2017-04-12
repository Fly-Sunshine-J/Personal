//
//  ViewController.m
//  test
//
//  Created by vcyber on 17/3/10.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import "ViewController.h"
#import "RecordManager.h"
#import <AVFoundation/AVFoundation.h>
#import "AudioRecord.h"
#import "FYRecordManager.h"

@interface ViewController ()<FYRecordManagerDelegate>

@property (nonatomic, strong) RecordManager *record;
@property (nonatomic, strong) NSString *path;
@property (nonatomic, strong) FYRecordManager *recorder;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSString *name = @"aaa官aaaaaa:";
//    
//    NSString *text = [NSString stringWithFormat:@"aaaaa宿管淡饭黄齑桑德环境jggglllljsfhgskdkfhjdsgfhjjhdgfkjhasdgjh"];
//    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 200, 160)];
//    textLabel.backgroundColor = [UIColor yellowColor];
//    //textLabel.lineBreakMode = NSLineBreakByCharWrapping;
//    textLabel.textColor = [UIColor blackColor];
//    textLabel.numberOfLines = 3;
//    
//    
//    
//    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:name attributes:@{NSFontAttributeName :[UIFont systemFontOfSize:20], NSForegroundColorAttributeName:[UIColor greenColor]}];
//    
//    NSTextAttachment *attch = [[NSTextAttachment alloc] init];
//    attch.image = [UIImage imageNamed:@"pia"];
//    // 设置图片大小
//    attch.bounds = CGRectMake(0, 0, 32, 32);
//    NSAttributedString *string = [NSAttributedString attributedStringWithAttachment:attch];
//    [att appendAttributedString:string];
//    [att appendAttributedString:[[NSAttributedString alloc] initWithString:text]];
//    textLabel.attributedText = att;
//    
//    
//    [self.view addSubview:textLabel];
//    
    _record = [[RecordManager alloc] init];
    _path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"test.m4a"];
    NSError *err1;
    NSError *err2;
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord withOptions:AVAudioSessionCategoryOptionMixWithOthers error:&err1];
    [[AVAudioSession sharedInstance] setActive:YES withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:&err2];
    NSLog(@"AVAudioSession--err1:%@, err2:%@", err1.localizedDescription, err2.localizedDescription);
    [_record AudioSessionInit:NO AudioPath:_path];
    
//    [[AudioRecord shareInstance] setRecordFileWithFilePath:_path];
    
//    _recorder = [[FYRecordManager alloc] initWithDelegate:self AndRecordFilePath:_path];
    
}

- (AudioStreamBasicDescription)configASBDForRecord:(FYRecordManager *)record {
    AudioStreamBasicDescription asbd;
    memset(&asbd, 0, sizeof(asbd));
    asbd.mSampleRate = 8000;
    asbd.mFormatID = kAudioFormatMPEG4AAC;
    asbd.mChannelsPerFrame = 1;
    asbd.mFramesPerPacket = 0;
    return asbd;
}

- (IBAction)dispose:(id)sender {
//    [[AudioRecord shareInstance] stop];
    [_record AudioSessionDispose];
    [_recorder queueDispose];
}

- (IBAction)play:(id)sender {
//    [[AudioRecord shareInstance] record];
    [_record AudioSessionStart];
    [_recorder queueStart];
}


- (IBAction)stop:(id)sender {
//    [[AudioRecord shareInstance] pause];
    [_record pauseAudio];
    [_recorder queuePause];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    NSLog(@"aaaaaaaaa");
}


@end
