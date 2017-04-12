//
//  NetWorkViewController.m
//  音频相关
//
//  Created by vcyber on 16/12/7.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "NetWorkViewController.h"
#import <AVFoundation/AVFoundation.h>
@interface NetWorkViewController () {
    id _timeObserver;
}

@property (nonatomic, strong) AVPlayer *player;

@property (weak, nonatomic) IBOutlet UISlider *progressSlide;

@property (weak, nonatomic) IBOutlet UISlider *volumSlide;

@property (weak, nonatomic) IBOutlet UIProgressView *progressView;
@property (weak, nonatomic) IBOutlet UIProgressView *bufferProgress;

@property (nonatomic, strong) NSMutableArray *musicArray;

@property (nonatomic, assign) NSInteger currentIndex;


@end

@implementation NetWorkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.musicArray = [NSMutableArray arrayWithArray:@[@"http://192.168.6.9/1.mp3", @"http://192.168.6.9/2.mp3", @"http://192.168.6.9/3.mp3"]];
    self.currentIndex = 0;
    
   
}

- (void)viewDidDisappear:(BOOL)animated {
    if (_timeObserver) {
        [self.player removeTimeObserver:_timeObserver];
    }
    [self removeObserver];
    
}

- (IBAction)changVolum:(UISlider *)sender {
    self.player.volume = sender.value;
}

- (IBAction)changeProgress:(UISlider *)sender {
    if (self.player.status == AVPlayerStatusReadyToPlay) {
        [self.player seekToTime:CMTimeMake(CMTimeGetSeconds(self.player.currentItem.duration) * sender.value, 1)];
    }
}

- (AVPlayer *)player {
    if (!_player) {
//        根据链接数组获取第一个播放的item， 用这个item来初始化AVPlayer
        AVPlayerItem *item = [self getItemWithIndex:self.currentIndex];
//        初始化AVPlayer
        _player = [[AVPlayer alloc] initWithPlayerItem:item];
        __weak typeof(self)weakSelf = self;
//        监听播放的进度的方法，addPeriodicTime: ObserverForInterval: usingBlock:
        /*
         DMTime 每到一定的时间会回调一次，包括开始和结束播放
         block回调，用来获取当前播放时长
         return 返回一个观察对象，当播放完毕时需要，移除这个观察
         */
        _timeObserver = [_player addPeriodicTimeObserverForInterval:CMTimeMake(1, 1) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
            float current = CMTimeGetSeconds(time);
            if (current) {
                [weakSelf.progressView setProgress:current / CMTimeGetSeconds(item.duration) animated:YES];
                weakSelf.progressSlide.value = current / CMTimeGetSeconds(item.duration);
            }
        }];
    }
    return _player;
}

- (AVPlayerItem *)getItemWithIndex:(NSInteger)index {
    NSURL *url = [NSURL URLWithString:self.musicArray[index]];
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:url];
    //KVO监听播放状态
    [item addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
    //KVO监听缓存大小
    [item addObserver:self forKeyPath:@"loadedTimeRanges" options:NSKeyValueObservingOptionNew context:nil];
    //通知监听item播放完毕
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playOver:) name:AVPlayerItemDidPlayToEndTimeNotification object:item];
    return item;
}


- (void)playOver:(NSNotification *)noti {
    [self next:nil];
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    AVPlayerItem *item = object;
    
    if ([keyPath isEqualToString:@"status"]) {
        switch (self.player.status) {
            case AVPlayerStatusUnknown:
                NSLog(@"未知状态，不能播放");
                break;
            case AVPlayerStatusReadyToPlay:
                NSLog(@"准备完毕，可以播放");
                break;
            case AVPlayerStatusFailed:
                NSLog(@"加载失败, 网络相关问题");
                break;
                
            default:
                break;
        }
    }
    
    if ([keyPath isEqualToString:@"loadedTimeRanges"]) {
        NSArray *array = item.loadedTimeRanges;
        //本次缓存的时间
        CMTimeRange timeRange = [array.firstObject CMTimeRangeValue];
        NSTimeInterval totalBufferTime = CMTimeGetSeconds(timeRange.start) + CMTimeGetSeconds(timeRange.duration); //缓存的总长度
        self.bufferProgress.progress = totalBufferTime / CMTimeGetSeconds(item.duration);
    }
}

- (IBAction)play:(id)sender {
    [self.player play];
}


- (IBAction)pause:(id)sender {
    [self.player pause];
}

- (IBAction)next:(UIButton *)sender {
    [self removeObserver];
   self.currentIndex ++;
    if (self.currentIndex >= self.musicArray.count) {
        self.currentIndex = 0;
    }
    [self.player replaceCurrentItemWithPlayerItem:[self getItemWithIndex:self.currentIndex]];
    [self.player play];
}

- (IBAction)last:(UIButton *)sender {
    [self removeObserver];
    self.currentIndex --;
    if (self.currentIndex < 0) {
        self.currentIndex = 0;
    }
    [self.player replaceCurrentItemWithPlayerItem:[self getItemWithIndex:self.currentIndex]];
    [self.player play];
}


- (void)removeObserver {
    [self.player.currentItem removeObserver:self forKeyPath:@"status"];
    [self.player.currentItem removeObserver:self forKeyPath:@"loadedTimeRanges"];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
