//
//  RecordManager.m
//  Cadillac
//
//  Created by vcyber on 17/1/13.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import "RecordManager.h"
#import "AppMacro.h"
#import <AVFoundation/AVFoundation.h>
#include <sys/time.h>

static UInt32 gBufferSizeBytes= 512;

@implementation RecordManager
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
    
    AudioFileID					recordFile;
    SInt64						recordPacket; // current packet number in record file
    
    AudioQueueBufferRef buffers[3];
    
}

- (void)SetAudioValid {
    [[AVAudioSession sharedInstance] setActive:YES error:nil];
    AudioQueueGetCurrentTime(queue, NULL, &currentTime, NULL);
    CLog(@"currentSampleTime %f", currentTime.mSampleTime);
    
    AudioState = 1;
    isSpeaking = NO;
    [tempData setData:[NSData data]];
    gettimeofday(&beginRecordTime, NULL);
    
    gettimeofday(&lastPutBuffTime, NULL);
    CPrint("启动时间点 %ld.%d\n", beginRecordTime.tv_sec, beginRecordTime.tv_usec);
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
            NSError *err;
            [[AVAudioSession sharedInstance] setActive:NO error:&err];
            CLog(@"err----%@", err.localizedDescription);
        }
    }
    else if (inInterruptionState == kAudioSessionEndInterruption)
    {
        if (!isRecord && [[notification.userInfo objectForKey:AVAudioSessionInterruptionOptionKey] intValue] == 1) {
            NSError *err, *err1;
            [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord withOptions:AVAudioSessionCategoryOptionInterruptSpokenAudioAndMixWithOthers | AVAudioSessionCategoryOptionMixWithOthers | AVAudioSessionCategoryOptionDuckOthers | AVAudioSessionCategoryOptionDefaultToSpeaker error:&err1];
            [[AVAudioSession sharedInstance]setActive:YES error:&err];
            AudioQueueReset(queue);
           CLog(@"err----%@---%@", err.localizedDescription, err1.localizedDescription);
            for (int i = 0; i < kNumberBuffers; i++) {
                OSStatus s2 = AudioQueueAllocateBuffer(queue,  gBufferSizeBytes, &buffers[i]);
                OSStatus s3 = AudioQueueEnqueueBuffer(queue, buffers[i], 0, NULL);
                CLog(@"%@---%@---", @(s2), @(s3));
           }
            [self AudioSessionStart];
        }
        
    }
    
}

- (void)initAudioParams {
    isRecord = NO;
    isSpeaking = NO;
    kNumberBuffers = 3;
    isCancle = NO;
    AudioState = 0;
    recordPacket = 0;
    
}



//初始化录音
- (void)AudioSessionInit:(BOOL)is16k AudioPath:(NSString *)path {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(AudioSessionDispose) name:@"Terminate" object:nil];
    
    memset(&mDataFormat, 0, sizeof(mDataFormat));
    if (is16k) {
        mDataFormat.mSampleRate = 16000;
    }else{
        mDataFormat.mSampleRate = 8000;
    }
    
    //    mDataFormat.mFormatID = kAudioFormatLinearPCM;
    mDataFormat.mFormatID = kAudioFormatMPEG4AAC;
    //    mDataFormat.mFormatFlags = kLinearPCMFormatFlagIsSignedInteger | kLinearPCMFormatFlagIsPacked;
    //    mDataFormat.mBitsPerChannel = 16;   // 采样位数
    mDataFormat.mChannelsPerFrame = 1;  // 通道数 1.单声道 2.立体声
    //    mDataFormat.mBytesPerFrame = 2;     // 每一个采样帧中多少字节
    //AAC文件数据包采样帧数必须是1024或0
    mDataFormat.mFramesPerPacket = 0;   // 每一个数据包中有多少采样帧
    //    mDataFormat.mFramesPerPacket = 1;   // 每一个数据包中有多少采样帧
    //    mDataFormat.mBytesPerPacket = 2;    // 每一个数据包中多少字节
    
    
    
    tempData = [NSMutableData data];
    
    [self initAudioParams];
//     frameSize = [self ComputeRecordBufferSize:&mDataFormat mescSeconds:128];
    AudioQueueNewInput(&mDataFormat, AQInputCallback,(__bridge void * _Nullable)(self), NULL, kCFRunLoopCommonModes,0, &queue);
    
    AudioFileTypeID audioFileType = kAudioFileM4AType;
    const char *recordFileName = [path UTF8String];
    CFURLRef url = CFURLCreateFromFileSystemRepresentation(NULL, (Byte *)recordFileName, strlen(recordFileName), FALSE);
    AudioFileCreateWithURL(url, audioFileType, &mDataFormat, kAudioFileFlags_EraseFile, &recordFile);
    
    // Set a magic cookie to file
    OSStatus result = noErr;
    UInt32 cookieSize;
    if (AudioQueueGetPropertySize(queue, kAudioQueueProperty_MagicCookie, &cookieSize) == noErr) {
        char *magicCookie = (char *)malloc(cookieSize);
        if (AudioQueueGetProperty(queue,
                                  kAudioQueueProperty_MagicCookie,
                                  magicCookie,
                                  &cookieSize) == noErr) {
            result = AudioFileSetProperty(recordFile, kAudioFilePropertyMagicCookieData, cookieSize, magicCookie);
            if (result == noErr) {
                NSLog(@"successfully write magic cookie to file");
            }else {
                NSLog(@"faild write magic cookie to file");
            }
        }
        free(magicCookie);
    }

    for (int i=0;i<kNumberBuffers;++i)
    {
        AudioQueueAllocateBuffer(queue,  gBufferSizeBytes, &buffers[i]);
        AudioQueueEnqueueBuffer(queue, buffers[i], 0, NULL);
    }
    UInt32 val = 1;
    AudioQueueSetProperty(queue, kAudioQueueProperty_EnableLevelMetering, &val, sizeof(UInt32));
    
}


- (OSStatus)AudioSessionStart {
    CLog(@"AudioSessionBegin");
    
    OSStatus statusCode = AudioQueueStart(queue, NULL);
    CLog(@"statusCode %d", (int)statusCode);
    
    gettimeofday(&lastPutBuffTime, NULL);
    
    isRecord = YES;
    
    return statusCode;
}


- (void)pauseAudio {
    OSStatus status = AudioQueuePause(queue);
    CLog(@"pause: %@", @(status));
    isRecord = NO;
}

- (void)SetCancle {
    isCancle = YES;
}

- (void)AudioSessionDispose {
    if (isRecord) {
        [self AudioSessionStop];
    }
    AudioQueueDispose(queue, YES);
    if (recordFile) {
        AudioFileClose(recordFile);
        recordFile = NULL;
    }
    self->recordPacket = 0;
    
    CLog(@"AudioSessionDispose");
}

- (void)AudioSessionStop {
    AudioQueueStop(queue , YES);
    CLog(@"AudioSessionStop");
    isRecord = NO;
    isSpeaking = NO;
    isCancle = NO;
}

- (void)StopAudio {
    [self AudioSessionStop];
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
    RecordManager * rt = (__bridge RecordManager*)inUserData;
    if (inNumPackets == 0 && rt->mDataFormat.mBytesPerPacket != 0)
        inNumPackets = inBuffer->mAudioDataByteSize / rt->mDataFormat.mBytesPerPacket;
    if (rt->isRecord && !rt->isCancle)
    {
        if (inStartTime->mSampleTime < rt->currentTime.mSampleTime) {
            CLog(@"\n忽略无效包 mSampleTime %f\n", inStartTime->mSampleTime);
            AudioQueueEnqueueBuffer(inAudioQueue, inBuffer, 0, NULL);
        } else {
            AudioFileWritePackets(rt->recordFile, FALSE, inBuffer->mAudioDataByteSize, inPacketDesc, rt->recordPacket, &inNumPackets, inBuffer->mAudioData);
            rt->recordPacket += inNumPackets;
            OSStatus err = AudioQueueEnqueueBuffer(inAudioQueue, inBuffer, 0, NULL);
//            CLog(@"Size: %d", (unsigned int)inBuffer->mAudioDataByteSize);
            CLog(@"err---------%@", @(err));
            CLog(@"吐包中。。。。。");
        }
    }
}


- (UInt32)deriveAudioBufferWithSeconds:(Float64)seconds {
    // 0x10000 = 5*16*16*16*16 ~ 320k
    static const int maxBufferSize = 0x50000;
    
    int maxPacketSize = mDataFormat.mBytesPerPacket;
    if (maxPacketSize == 0) {
        UInt32 maxVBRPacketSize = sizeof(maxPacketSize);
        AudioQueueGetProperty (queue,
                               kAudioQueueProperty_MaximumOutputPacketSize,
                               &maxPacketSize,
                               &maxVBRPacketSize);
    }
    
    Float64 numBytesForTime = 0;
    if (mDataFormat.mFramesPerPacket > 0) {
        numBytesForTime = (mDataFormat.mSampleRate / mDataFormat.mFramesPerPacket) * maxPacketSize * seconds;
    } else {
        numBytesForTime = mDataFormat.mSampleRate * maxPacketSize * seconds;
    }
    
    // don't exceed maxBufferSize
    numBytesForTime = numBytesForTime < maxBufferSize ? numBytesForTime : maxBufferSize;
    // don't less than maxPacketSize
    return numBytesForTime < maxPacketSize ? maxPacketSize : numBytesForTime;
}


@end
