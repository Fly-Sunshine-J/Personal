//
//  VMMusicPlayer.m
//  VcyberNaturalLanguageMedia
//
//  Created by dengweihao on 16/4/21.
//  Copyright © 2016年 dengweihao. All rights reserved.
//

#import "VMAudioPlayer.h"
#import <MediaPlayer/MediaPlayer.h>
#import "AppDelegate.h"

@interface VMAudioPlayer ()<AVAudioPlayerDelegate>

/** 播放器 */
@property (nonatomic, strong) AVAudioPlayer *musicPlayer;

@end

@implementation VMAudioPlayer


#pragma mark - 初始化

static VMAudioPlayer *player = nil;

+ (instancetype)shareVMAVPlayer {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        player = [[VMAudioPlayer alloc] init];
        
        player.repeatMode = MusicRepeatModeAll;
        
    });
    
    return player;
}



+ (id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        player = [super allocWithZone:zone];
    });
    return player;
}

- (void)createAudioPlayerWithPlayList:(NSMutableArray *)playList {
    
    if (playList.count > 0) {
        if (!_musicPlayer) {
            _index = 0;
            _playList = playList;
            _musicPlayStatus = MusicPlayStatusDefault;
            NSError *error = [self getAudioPlayerReadyForPlay];
            if (error == nil) {
                NSLog(@"初始化音频播放器成功");
                /** 接受远程事件*/
                [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
                AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
                [delegate becomeFirstResponder];
                
            } else {
                NSLog(@"初始化音频播放器失败 -> %@", error.localizedDescription);
            }
        }
    }
    
}

- (AVAudioPlayer *)musicPlayer {
    return _musicPlayer;
}

/** 选择播放 */
- (BOOL)playAudioWithIndex:(NSInteger)index {
    _index = index;
    [self sendDelegate];
    
    NSError *error = [self getAudioPlayerReadyForPlay];
    if (nil == error) {
        [self play];
    } else {
        NSLog(@" -> %@", error.localizedDescription);
        return NO;
    }
    
    return YES;
}


/**
 *  播放
 */
- (void)play {
    
    NSURL *VMAudioUrl = [self.playList[_index] valueForKey:@"musicURL"];
    if (VMAudioUrl != nil) {
        [self.musicPlayer play];
        _musicPlayStatus = MusicPlayStatusPlaying;
        [self configNowPlayingInfoCenter];
        [self sendDelegate];
    } else {
        NSLog(@"musicURL 不存在");
    }
}

/**
 *  暂停
 */
- (void)pause {
    
    if (self.musicPlayStatus == MusicPlayStatusPlaying) {
        [self.musicPlayer pause];
        _musicPlayStatus = MusicPlayStatusPaused;
        [self configNowPlayingInfoCenter];
        [self sendDelegate];
    }
}

/**
 *  停止
 */
- (void)stop {
    
    [self.musicPlayer stop];
    
    _musicPlayer = nil;

    _musicPlayStatus = MusicPlayStatusStoped;
    
    [self sendDelegate];
    
}

/**
 *  下一首
 */
- (void)next {
    _index++;
    if (_index > self.playList.count-1) {
        _index = _index-self.playList.count;
    }
    
    [self playAudioWithIndex:_index];
}

/**
 *  上一首
 */
- (void)last {
    _index--;
    if (_index < 0) {
        _index = _index+self.playList.count;
    }
    
    [self playAudioWithIndex:_index];
}



#pragma mark ---私有方法---

- (void)sendDelegate {
    if (self.delegate && [self.delegate respondsToSelector:@selector(updatePlayList)]) {
        [self.delegate updatePlayList];
    }
}

- (NSError *)getAudioPlayerReadyForPlay {
    if (_musicPlayer) {
        [_musicPlayer stop];
        _musicPlayer = nil;
        NSLog(@"重置播放器");
    }
    
    NSURL *VMAudioUrl = [self.playList[_index] valueForKey:@"musicURL"];
    NSLog(@"musicURL--> %@, AudioIndex:%d", VMAudioUrl, (int)_index);
    
    NSError *error = nil;
    self.musicPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:VMAudioUrl error:&error];
    self.musicPlayer.delegate = self;
    self.musicPlayer.numberOfLoops = 0;
    self.musicPlayer.volume = 0.4;
    [self.musicPlayer prepareToPlay];
    return error;
}

- (void)configNowPlayingInfoCenter {

    if (NSClassFromString(@"MPNowPlayingInfoCenter")) {
        
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        [dict setObject:[self.playList[self.index] valueForKey:@"music"] forKey:MPMediaItemPropertyTitle];
        [dict setObject:[self.playList[self.index] valueForKey:@"singer"] forKey:MPMediaItemPropertyArtist];
        if ([self.playList[self.index] valueForKey:@"artwork"] != nil) {
            [dict setObject:[self.playList[self.index] valueForKey:@"artwork"] forKey:MPMediaItemPropertyArtwork];
        }
    
        [dict setObject:[NSNumber numberWithDouble:self.musicPlayer.currentTime] forKey:MPNowPlayingInfoPropertyElapsedPlaybackTime];
        [dict setObject:[NSNumber numberWithDouble:self.musicPlayer.duration] forKey:MPMediaItemPropertyPlaybackDuration];
        
        if (self.musicPlayStatus == MusicPlayStatusPlaying) {
            
            [dict setObject:[NSNumber numberWithFloat:1.0] forKey:MPNowPlayingInfoPropertyPlaybackRate];
        }else {
            
            [dict setObject:[NSNumber numberWithFloat:0.0] forKey:MPNowPlayingInfoPropertyPlaybackRate];
        }
        
        [[MPNowPlayingInfoCenter defaultCenter] setNowPlayingInfo:dict];
    }
    
}


#pragma mark ---AVAudioPlayerDelegate---
- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag {

    if (flag) {
        
        if (self.repeatMode == MusicRepeatModeAll) {
            
            [self next];
        }else {
            
            [self stop];
        }
        
    }
    
}

- (void)audioPlayerBeginInterruption:(AVAudioPlayer *)player {
    
    [self pause];
}


- (void)audioPlayerEndInterruption:(AVAudioPlayer *)player withOptions:(NSUInteger)flags {
    
    if (flags == AVAudioSessionInterruptionOptionShouldResume) {
        
    }else {
        
        [self play];
    }
}


@end
