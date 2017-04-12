//
//  LocalMusicViewController.m
//  音频相关
//
//  Created by vcyber on 16/12/7.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "LocalMusicViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface LocalMusicViewController ()<AVAudioPlayerDelegate>

/**
 播放器
 */
@property (nonatomic, strong) AVAudioPlayer *player;

/**
 播放进度条
 */
@property (weak, nonatomic) IBOutlet UIProgressView *progress;

/**
 改变播放进度滑块
 */
@property (weak, nonatomic) IBOutlet UISlider *progressSlide;

/**
 改变声音滑块
 */
@property (weak, nonatomic) IBOutlet UISlider *volum;

/**
 改变进度条滑块显示的定时器
 */
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation LocalMusicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSError *err;
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"1" withExtension:@"mp3"];
//    初始化播放器
    _player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&err];
    self.volum.value = 0.5;
//    设置播放器声音
    _player.volume = self.volum.value;
//    设置代理
    _player.delegate = self;
//    设置播放速率
    _player.rate = 1.0;
//    设置播放次数 负数代表无限循环
    _player.numberOfLoops = -1;
//    准备播放
    [_player prepareToPlay];
    self.progress.progress = 0;
    self.progressSlide.value = 0;
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(change) userInfo:nil repeats:YES];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    _player = nil;
}

- (void)change {
    self.progress.progress = _player.currentTime / _player.duration;
}

- (IBAction)progressChange:(UISlider *)sender {
//    改变当前的播放进度
    _player.currentTime = sender.value * _player.duration;
    self.progress.progress = sender.value;
    
}
- (IBAction)volumChange:(UISlider *)sender {
//    改变声音大小
    _player.volume = sender.value;
}

- (IBAction)player:(id)sender {
//    开始播放
    [_player play];
}


- (IBAction)stop:(id)sender {
//    暂停播放
    [_player stop];
}

#pragma mark --AVAudioPlayerDelegate
/**
 完成播放， 但是在打断播放和暂停、停止不会调用
 */
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {
    
}


/**
 播放过程中解码错误时会调用
 */
- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError * __nullable)error {
    
}



/**
 播放过程被打断

 */
- (void)audioPlayerBeginInterruption:(AVAudioPlayer *)player NS_DEPRECATED_IOS(2_2, 8_0) {
    
}


/**
 打断结束
*/
- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player withOptions:(NSUInteger)flags NS_DEPRECATED_IOS(6_0, 8_0) {
    
}

/**
 打断结束

 */
- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player withFlags:(NSUInteger)flags NS_DEPRECATED_IOS(4_0, 6_0) {
    
}


/**
 这个方法被上面的方法代替了
 */
- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player NS_DEPRECATED_IOS(2_2, 6_0) {
    
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
