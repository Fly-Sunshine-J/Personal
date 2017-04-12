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
#   define CLog(fmt, ...) \
\
NSLog(@"%s [Line %d] " fmt, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__); \

#   define CPrint(format, ...) printf(format, ##__VA_ARGS__)

#define TimeSilence 0.9

static UInt32 gBufferSizeBytes= 1024;

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
    
    AudioFileID					recordFile;
    SInt64						recordPacket; // current packet number in record file
    
    NSString *_path;
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
        }
    }
    else if (inInterruptionState == kAudioSessionEndInterruption)
    {
        NSError *err;
        [[AVAudioSession sharedInstance]setActive:YES error:&err];
        CLog(@"err----%@", err.localizedDescription);
        for (int i=0;i<kNumberBuffers;++i)
        {
            AudioQueueBufferRef buffer;
            AudioQueueAllocateBuffer(queue,  gBufferSizeBytes, &buffer);
            AudioQueueEnqueueBuffer(queue, buffer, 0, NULL);
        }
        [self AudioSessionStart];
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



static Boolean InferAudioFileFormatFromFilename(CFStringRef filename, AudioFileTypeID *outFiletype)
{
    OSStatus err;
    
    // find the extension in the filename.
    CFRange range = CFStringFind(filename, CFSTR("."), kCFCompareBackwards);
    if (range.location == kCFNotFound)
        return FALSE;
    range.location += 1;
    range.length = CFStringGetLength(filename) - range.location;
    CFStringRef extension = CFStringCreateWithSubstring(NULL, filename, range);
    
    UInt32 propertySize = sizeof(AudioFileTypeID);
    err = AudioFileGetGlobalInfo(kAudioFileGlobalInfo_TypesForExtension, sizeof(extension), &extension, &propertySize, outFiletype);
    CFRelease(extension);
    
    return (err == noErr && propertySize > 0);
}


//初始化录音
- (void)AudioSessionInit:(BOOL)is16k AudioPath:(NSString *)path {
    
//    .AudioFileTypeID audioFileType = kAudioFileM4AType;
//    const char *recordFileName = [path UTF8String];
//    CFStringRef cfRecordFileName = CFStringCreateWithCString(NULL, recordFileName, kCFStringEncodingUTF8);
//    InferAudioFileFormatFromFilename(cfRecordFileName, &audioFileType);
//    CFRelease(cfRecordFileName);
    
    
    memset(&mDataFormat, 0, sizeof(mDataFormat));
    if (is16k) {
        mDataFormat.mSampleRate = 16000;
    }else{
        mDataFormat.mSampleRate = 8000;
    }
    
//    //    _basicDescription.mFormatID = kAudioFormatMPEG4AAC_HE;
    mDataFormat.mFormatID = kAudioFormatMPEG4AAC;
//    mDataFormat.mFormatFlags = 0;
//    // The number of bytes in a packet of audio data. To indicate variable packet size, set this field to 0. For a format that uses variable packet size, specify the size of each packet using an AudioStreamPacketDescription structure.
    mDataFormat.mBytesPerPacket = 0;
//    // The number of frames in a packet of audio data. For uncompressed audio, the value is 1. For variable bit-rate formats, the value is a larger fixed number, such as 1024 for AAC. For formats with a variable number of frames per packet, such as Ogg Vorbis, set this field to 0.
//    // AAC-HE 2048
    mDataFormat.mFramesPerPacket = 1024;
//    mDataFormat.mChannelsPerFrame = 1;
//    // The number of bytes from the start of one frame to the start of the next frame in an audio buffer. Set this field to 0 for compressed formats.
//    // For an audio buffer containing interleaved data for n channels, with each sample of type AudioSampleType, calculate the value for this field as follows:
//    //    mBytesPerFrame = n * sizeof (AudioSampleType);
//    // For an audio buffer containing noninterleaved (monophonic) data, also using AudioSampleType samples, calculate the value for this field as follows:
//    //    mBytesPerFrame = sizeof (AudioSampleType);
//    mDataFormat.mBytesPerFrame = 0;
//    // The number of bits for one audio sample. For example, for linear PCM audio using the kAudioFormatFlagsCanonical format flags, calculate the value for this field as follows:
//    // mBitsPerChannel = 8 * sizeof (AudioSampleType);
//    // Set this field to 0 for compressed formats.
//    mDataFormat.mBitsPerChannel = 0;
//    mDataFormat.mReserved = 0;
    
//    mDataFormat.mFormatID = kAudioFormatAMR;
//    mDataFormat.mBytesPerFrame = 8;
 //   mDataFormat.mChannelsPerFrame = 1;
  //  mDataFormat.mBytesPerFrame = 1;

    
    
    tempData = [NSMutableData data];
    
    [self initAudioParams];
    //     frameSize = [self ComputeRecordBufferSize:&mDataFormat mescSeconds:128];
    AudioQueueNewInput(&mDataFormat, AQInputCallback,(__bridge void * _Nullable)(self), CFRunLoopGetMain(), kCFRunLoopCommonModes,0, &queue);

    const char *pFilePath = [path UTF8String];
    CFURLRef audioFileURL = CFURLCreateFromFileSystemRepresentation(NULL, (const UInt8 *)pFilePath, strlen(pFilePath), false);
    OSStatus status = AudioFileCreateWithURL(audioFileURL, kAudioFileM4AType, &mDataFormat, kAudioFileFlags_EraseFile, &recordFile);
    if (status != noErr) {
        recordFile = NULL;
    }
    
    
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
        AudioQueueBufferRef buffer;
        AudioQueueAllocateBuffer(queue,  gBufferSizeBytes, &buffer);
        AudioQueueEnqueueBuffer(queue, buffer, 0, NULL);
    }
//    UInt32 val = 1;
//    AudioQueueSetProperty(queue, kAudioQueueProperty_EnableLevelMetering, &val, sizeof(UInt32));
    
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
    AudioQueueDispose(queue, NO);
    if (recordFile) {
        AudioFileClose(recordFile);
        recordFile = NULL;
    }
    self->recordPacket = 0;
    CLog(@"AudioSessionDispose");
}

- (void)AudioSessionStop {
    AudioQueueStop(queue , NO);
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
    VDRecordTask * rt = (__bridge VDRecordTask*)inUserData;
    if (inNumPackets == 0 && rt->mDataFormat.mBytesPerPacket != 0)
        inNumPackets = inBuffer->mAudioDataByteSize / rt->mDataFormat.mBytesPerPacket;
    OSStatus status = AudioFileWritePackets(rt->recordFile, FALSE, inBuffer->mAudioDataByteSize, inPacketDesc, rt->recordPacket, &inNumPackets, inBuffer->mAudioData);
    rt->recordPacket += inNumPackets;
    AudioQueueEnqueueBuffer(inAudioQueue, inBuffer, 0, NULL);
    if (status == noErr) {
        CLog(@"吐包中。。。。。");
        NSLog(@"success write audio file packet %d", (int)inNumPackets);
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
