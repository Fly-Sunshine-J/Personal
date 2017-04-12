//
//  VDRecordTask.m
//  NewerVDSDK
//
//  Created by dengweihao on 16/3/16.
//  Copyright © 2016年 dengweihao. All rights reserved.
//

#import "VDRecordTask.h"
#import <AVFoundation/AVFoundation.h>
#include <sys/time.h>
#   define VcyberLog(fmt, ...) \
\
NSLog(@"%s [Line %d] " fmt, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__); \

#   define DPrint(format, ...) printf(format, ##__VA_ARGS__)

#define TimeSilence 0.9


@implementation VDRecordTask
{
    AVAudioSession * session ;
    AudioStreamBasicDescription mDataFormat;
    AudioQueueRef queue;
    UInt32 frameSize;
    int kNumberBuffers ;
    BOOL isRecord ;
    
    AudioQueueLevelMeterState	_chan_lvls;
    BOOL isSpeaking; //是否为有效录音
    BOOL isCancle;
    NSInteger maxvoicetime ; //有效录音最大超时时间
    double k; //录音灵敏度系数
    
    NSMutableData *tempData; //缓存录音数据
    struct timeval lastClickTime; //上一次说话的时间点
    struct timeval beginRecordTime; //开始录音时间点
    struct timeval lastPutBuffTime;
    struct AudioTimeStamp currentTime; //取样有效开始时间
    
    int AudioState; //录音状态, 0:无效录音, 1:有效录音
}

- (void)SetAudioValid {
    [session setActive:YES error:nil];
    AudioQueueGetCurrentTime(queue, NULL, &currentTime, NULL);
    VcyberLog(@"currentSampleTime %f", currentTime.mSampleTime);
    
    AudioState = 1;
    isSpeaking = NO;
    [tempData setData:[NSData data]];
    gettimeofday(&beginRecordTime, NULL);
    
    gettimeofday(&lastPutBuffTime, NULL);
    DPrint("启动时间点 %ld.%d\n", beginRecordTime.tv_sec, beginRecordTime.tv_usec);
}

- (id)init {
    self = [super init];
    if (self) {
        [self initAudioParams];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(interruptHandle:) name:AVAudioSessionInterruptionNotification object:nil];
    }
    return self;
}


- (void)interruptHandle:(NSNotification *)notification {
    int inInterruptionState = [[notification.userInfo objectForKey:AVAudioSessionInterruptionTypeKey] intValue];
    if (inInterruptionState == kAudioSessionBeginInterruption)
    {
        if (isRecord) {
            [self pauseAudio];
            isRecord = NO;
        }
    }
    else if (inInterruptionState == kAudioSessionEndInterruption)
    {

        [self AudioSessionStart];
    }

}

- (void)initAudioParams {
    isRecord = NO;
    isSpeaking = NO;
    kNumberBuffers = 3;
    isCancle = NO;
    AudioState = 0;
}

//初始化录音
- (void)AudioSessionInit:(BOOL)is16k {
    memset(&mDataFormat, 0, sizeof(mDataFormat));
    if (is16k) {
        mDataFormat.mSampleRate = 16000;
    }else{
        mDataFormat.mSampleRate = 8000;
    }
    
    mDataFormat.mFormatID = kAudioFormatLinearPCM;
    mDataFormat.mFormatFlags = kLinearPCMFormatFlagIsSignedInteger | kLinearPCMFormatFlagIsPacked;
    mDataFormat.mBitsPerChannel = 16;   // 采样位数
    mDataFormat.mChannelsPerFrame = 1;  // 通道数 1.单声道 2.立体声
    mDataFormat.mBytesPerFrame = 2;     // 每一个采样帧中多少字节
    mDataFormat.mFramesPerPacket = 1;   // 每一个数据包中有多少采样帧
    mDataFormat.mBytesPerPacket = 2;    // 每一个数据包中多少字节
    

    
    tempData = [NSMutableData data];

    [self initAudioParams];
    frameSize = [self ComputeRecordBufferSize:&mDataFormat mescSeconds:40];
    AudioQueueNewInput(&mDataFormat, AQInputCallback,(__bridge void * _Nullable)(self), NULL, kCFRunLoopCommonModes,0, &queue);
    AudioQueueBufferRef         mBuffers[3];
    for (int i=0;i<kNumberBuffers;++i)
    {
        AudioQueueAllocateBuffer(queue,  frameSize, &mBuffers[i]);
        AudioQueueEnqueueBuffer(queue, mBuffers[i], 0, NULL);
    }
    UInt32 val = 1;
    AudioQueueSetProperty(queue, kAudioQueueProperty_EnableLevelMetering, &val, sizeof(UInt32));
    
}


- (OSStatus)AudioSessionStart {
    VcyberLog(@"AudioSessionBegin");

    OSStatus statusCode = AudioQueueStart(queue, NULL);
    VcyberLog(@"statusCode %d", (int)statusCode);

    gettimeofday(&lastPutBuffTime, NULL);
    
    isRecord = YES;
    
    return statusCode;
}


- (void)pauseAudio {
    AudioQueuePause(queue);
}

- (void)SetCancle {
    isCancle = YES;
}

- (void)AudioSessionDispose {
    if (isRecord) {
        [self AudioSessionStop];
    }
    AudioQueueDispose(queue, YES);
    
    VcyberLog(@"AudioSessionDispose");
}

- (void)AudioSessionStop {
    AudioQueueStop(queue , YES);
    VcyberLog(@"AudioSessionStop");
    isRecord = NO;
    isSpeaking = NO;
    isCancle = NO;
}

- (void)StopAudio {
    
    [self AudioSessionStop];
    
    //发送最后一条音频
    [self sendVoice:tempData status:@"AudioLast" isSpeaking:YES];
}

- (void)dealloc {
    if (self) {
        [self AudioSessionDispose];
    }
}


void AQInputCallback (void           * inUserData,
                      AudioQueueRef          inAudioQueue,
                      AudioQueueBufferRef    inBuffer,
                      const AudioTimeStamp   * inStartTime,
                      UInt32          inNumPackets,
                      const AudioStreamPacketDescription * inPacketDesc)
{
    VDRecordTask * rt = (__bridge VDRecordTask*)inUserData;
    if (rt->isRecord && !rt->isCancle)
    {
        if (inStartTime->mSampleTime < rt->currentTime.mSampleTime) {
            VcyberLog(@"\n忽略无效包 mSampleTime %f\n", inStartTime->mSampleTime);
            AudioQueueEnqueueBuffer(inAudioQueue, inBuffer, 0, NULL);
        } else {
                
                NSData * voiceData = [[NSData alloc] initWithBytes:inBuffer->mAudioData length:inBuffer->mAudioDataByteSize];
                AudioQueueEnqueueBuffer(inAudioQueue, inBuffer, 0, NULL);
                [rt->tempData appendData:voiceData];
            
            if ([rt->tempData length] > 1024 * 5) {
                
                [rt sendVoice:rt->tempData status:@"AudioBefore" isSpeaking:rt->isSpeaking];
                VcyberLog(@"吐包中。。。。。");
            }
            
        }
    }
}

- (void)sendVoice:(NSData *)tData status:(NSString *)status isSpeaking:(BOOL)isSpeak {
    if (!isCancle) {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(SendVoiceToServer:status:isSpeaking:)]) {
            
            [self.delegate SendVoiceToServer:tempData status:status isSpeaking:isSpeak];
            [tempData setData:[NSData data]];
        }
    }
}


- (int)ComputeRecordBufferSize:(const AudioStreamBasicDescription *)format  mescSeconds:(int)mescSeconds {
    int packets, frames, bytes = 0;
    frames = (int)ceil(format->mSampleRate / 1000 * mescSeconds);
    
    if (format->mBytesPerFrame > 0)
        bytes = frames * format->mBytesPerFrame;
    else {
        UInt32 maxPacketSize;
        if (format->mBytesPerPacket > 0)
            maxPacketSize = format->mBytesPerPacket;    // constant packet size
        else {
            UInt32 propertySize = sizeof(maxPacketSize);
            AudioQueueGetProperty(queue, kAudioQueueProperty_MaximumOutputPacketSize, &maxPacketSize,&propertySize);
        }
        if (format->mFramesPerPacket > 0)
            packets = frames / format->mFramesPerPacket;
        else
            packets = frames;   // worst-case scenario: 1 frame in a packet
        if (packets == 0)       // sanity check
            packets = 1;
        bytes = packets * maxPacketSize;
    }
    return bytes;
}

@end
