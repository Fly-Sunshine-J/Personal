//
//  VMMusicPlayer.h
//  VcyberNaturalLanguageMedia
//
//  Created by dengweihao on 16/4/21.
//  Copyright © 2016年 dengweihao. All rights reserved.
//
//  音乐控制单例
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

typedef NS_ENUM(NSInteger, MusicRepeatMode) {
    MusicRepeatModeNone,
    MusicRepeatModeAll
};


typedef NS_ENUM(NSInteger, MusicPlayStatus) {
    MusicPlayStatusDefault,
    MusicPlayStatusPlaying,
    MusicPlayStatusPaused,
    MusicPlayStatusStoped
};

@protocol VMAudioPlayerDelegate <NSObject>

/**
 *  用代理更新播放列表
 */
- (void)updatePlayList;

@end


@interface VMAudioPlayer : NSObject

/**
 *  播放列表
 */
@property (nonatomic, strong,readonly) NSMutableArray *playList;

/**
 *  记录播放
 */
@property (nonatomic, assign, readonly) NSInteger index;

/**
 *  设置代理
 */
@property (nonatomic, weak) id<VMAudioPlayerDelegate>delegate;

/**
 *  设置播放模式
 */
@property (nonatomic, assign) MusicRepeatMode repeatMode;

/**
 *  播放器的播放状态
 */
@property (nonatomic, assign, readonly) MusicPlayStatus musicPlayStatus;


+ (instancetype)shareVMAVPlayer;

- (void)createAudioPlayerWithPlayList:(NSMutableArray *)playList;

/** 选择播放 */
- (BOOL)playAudioWithIndex:(NSInteger)index;

- (AVAudioPlayer *)musicPlayer;

/** 播放 */
- (void)play;

/** 暂停 */
- (void)pause;

/** 停止 */
- (void)stop;

/** 下一首 */
- (void)next;

/** 上一首 */
- (void)last;


@end
