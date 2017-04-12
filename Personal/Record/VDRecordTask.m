//
//  VDRecordTask.m
//  NewerVDSDK
//
//  Created by dengweihao on 16/3/16.
//  Copyright © 2016年 dengweihao. All rights reserved.
//

#import "VDRecordTask.h"
#import <AVFoundation/AVFoundation.h>
#import "VDCommon.h"
#include <sys/time.h>

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
    }
    return self;
}

- (void)initAudioParams {
    isRecord = NO;
    isSpeaking = NO;
    kNumberBuffers = 3;
    isCancle = NO;
    AudioState = 0;
}

//初始化录音
- (void)AudioSessionInit:(BOOL)is16k MaxVoiceTime:(NSInteger)_maxVoicetime VoiceScale:(double)VoK
{
    session = [AVAudioSession sharedInstance];
//    [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    [session setActive:YES error:nil];
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
    
    
    if (VoK&& VoK>=1.0 && VoK<=2.0 ) {
        k = VoK;
    } else {
        k = 1.0f;
    }
    VcyberLog(@"voiceK:%f", k);
    
    tempData = [NSMutableData data];
    maxvoicetime = _maxVoicetime;
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
            struct timeval timeNow;
            gettimeofday(&timeNow, NULL);
            
//            __darwin_time_t nowTime = timeNow.tv_sec * 1000000 + timeNow.tv_usec;
//            __darwin_time_t lastPutBuff = rt->lastPutBuffTime.tv_sec * 1000000 + rt->lastPutBuffTime.tv_usec;
//            DPrint("吐包时间 %ld.%d  -- %d  吐包时间差 %ld   mSampleTime %f \n", timeNow.tv_sec, timeNow.tv_usec, (int)inNumPackets, nowTime - lastPutBuff, inStartTime->mSampleTime);
//            gettimeofday(&rt->lastPutBuffTime, NULL);
            
            if (inNumPackets > 0) {
                
                if (rt->AudioState) {
                    gettimeofday(&timeNow, NULL);
                    __darwin_time_t EndTime = timeNow.tv_sec * 1000000 + timeNow.tv_usec;
                    __darwin_time_t StartTime = rt->beginRecordTime.tv_sec * 1000000 + rt->beginRecordTime.tv_usec;
                    if (((EndTime - StartTime) > (rt->maxvoicetime * 1000000))) {
//                        DPrint("结束录音时间 %ld, %d", timeNow.tv_sec, timeNow.tv_usec);
//                        [rt StopAudio];
                        [rt sendVoice:rt->tempData status:@"AudioLast" isSpeaking:YES];
                        rt->AudioState = 0;
                        rt->isSpeaking = NO;
                        AudioQueueEnqueueBuffer(inAudioQueue, inBuffer, 0, NULL);
                        return;
                    }
                }
                
                NSData * voiceData = [[NSData alloc] initWithBytes:inBuffer->mAudioData length:inBuffer->mAudioDataByteSize];
                AudioQueueEnqueueBuffer(inAudioQueue, inBuffer, 0, NULL);
                
                /*by 2016-03-17*/
                if (voiceData.length>0) {
                    
                    short * tempBuffer = (short * )[voiceData bytes];
                    
                    long t = 0;
                    
                    for (int i = 0; i < [voiceData length] / 2; i++) {
                        
                        if (tempBuffer[i] > 0) {
                            t += (tempBuffer[i] * 2 - 1);
                        } else {
                            t += (abs(tempBuffer[i] * 2));
                        }
                    }
                    
                    float dB = 20*log10(t);
                    
//                    char s_fmt[1024] = {0};
//                    memset(s_fmt, '*', 1023);
//                    s_fmt[(unsigned int)dB] = 0;
//                    printf("%s%03u\n", s_fmt, (unsigned int)dB);
                    
                    int voiceNum = 0;
                    int k = rt->k;
                    
                    if (dB < 0) {
                        voiceNum = 1;
                    }
                    if (dB < 120 * k) {
                        voiceNum = 1;
//                        printf("**\n");
                    }
                    if (120 * k <= dB && dB < 125 * k) {
                        voiceNum = 2;
//                        printf("****\n");
                    }
                    if (125 * k <= dB && dB < 128 * k) {
                        voiceNum = 3;
//                        printf("******\n");
                    }
                    if (128 * k <= dB && dB < 130 * k) {
                        voiceNum = 4;
//                        printf("**********\n");
                    }
                    if (130 * k <= dB && dB <= 140 * k) {
                        voiceNum = 5;
//                        printf("************\n");
                    }
                    if (140 * k <= dB) {
                        voiceNum = 6;
//                        printf("**************\n");
                    }
                    
                    if (!rt->isCancle) {
                        if (rt.delegate && [rt.delegate respondsToSelector:@selector(SetVolumeState:AudioValid:)]) {
                            [rt.delegate SetVolumeState:(voiceNum-1) AudioValid:rt->AudioState];
                        }
                    }
                    
                    [rt->tempData appendData:voiceData];
//                    DPrint("[rt->tempData length] %d\n", [rt->tempData length]);
                    
                    if (rt->AudioState) {
                        if(voiceNum > 1){
                            rt->isSpeaking = YES;
                            gettimeofday(&(rt->lastClickTime), NULL);
                        } else {
                            if (rt->isSpeaking) {
                                gettimeofday(&timeNow, NULL);
//                                DPrint("voiceNum %ld.%d  -- voiceNum %d\n", timeNow.tv_sec, timeNow.tv_usec, voiceNum);
                                __darwin_time_t EndTime = timeNow.tv_sec * 1000000 + timeNow.tv_usec;
                                __darwin_time_t retlastClick = rt->lastClickTime.tv_sec * 1000000 + rt->lastClickTime.tv_usec;
                                
                                if (rt->isSpeaking && ((EndTime - retlastClick) > (TimeSilence * 1000000)) ) {
//                                    [rt StopAudio];
                                    rt->AudioState = 0;
                                    rt->isSpeaking = NO;
                                    [rt sendVoice:rt->tempData status:@"AudioLast" isSpeaking:YES];
                                }
                            }
                        }
                    }
                    
                } else {
                    VcyberLog(@"VoiceDataLeng<0");
                }
                
                if ([rt->tempData length] > 16000) {
                    
                    [rt sendVoice:rt->tempData status:@"AudioBefore" isSpeaking:rt->isSpeaking];
                }
                
            } else {
                AudioQueueEnqueueBuffer(inAudioQueue, inBuffer, 0, NULL);
                VcyberLog(@"inNumPackets<0");
            }
        }
        
    } else {
        AudioQueueEnqueueBuffer(inAudioQueue, inBuffer, 0, NULL);
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