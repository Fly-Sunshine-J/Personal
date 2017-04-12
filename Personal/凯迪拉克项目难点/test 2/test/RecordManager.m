//
//  RecordManager.m
//  Cadillac
//
//  Created by vcyber on 17/1/13.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import "RecordManager.h"
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>

#define CLog(fmt, ...) \
\
NSLog(@"%s [Line %d] " fmt, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__); \

static UInt32 gBufferSizeBytes = 1024;
#define  kNumberBuffers 3

@interface RecordManager ()

- (void)audioQueueStartedCallback;
- (void)audioQueueStoppedCallback;

@end

/*
 
 测试下来，在处于stopping状态的时候，就可以开启另一个对象来录音了，在stopping的时候，录音设备应该不工作了，是指把录音好的缓存发送给上层，所以此时可以开启其他对象来录音。但是对于播放设备，在stopping状态时，仍然需要播放完缓存中的对象，也就是说播放仍在继续。
 
 |--playing---|
 |--starting--|--playing--|--pause--|--playing--|--stopping--|--stopped--|
 |---------started-----------------|
 */

@implementation RecordManager
{
    AudioStreamBasicDescription mDataFormat;
    AudioQueueRef queue;
    AudioQueueBufferRef buffers[kNumberBuffers];
    
    // audio queue need some time to start, so during we call AudioQueueStart and it really starts, _starting is YES
    BOOL _starting;
    // audio queue is started
    BOOL _started;
    
    // audio device may not finish immediately after call AudioQueueStop, if you pass false as its second paramter.
    // during we call AudioQueueStop to it really finishs, _stopping is YES
    BOOL _stopping;
    // YES means finished, NO means started
    BOOL _stopped;
    
    AudioFileID					recordFile;
    SInt64						recordPacket; // current packet number in record file
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
        if (_recording) {
            [self pauseAudio];
            NSError *err;
            [[AVAudioSession sharedInstance] setActive:NO error:&err];
            CLog(@"err----%@", err.localizedDescription);
//            [[UIApplication sharedApplication] beginReceivingRemoteControlEvents];
        }
    }
    else if (inInterruptionState == kAudioSessionEndInterruption)
    {
        if (_started) {
            NSError *err1;
            NSError *err2;
            [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord withOptions:AVAudioSessionCategoryOptionMixWithOthers error:&err1];
            [[AVAudioSession sharedInstance] setActive:YES error:&err2];
            CLog(@"AVAudioSession--err1:%@, err2:%@", err1.localizedDescription, err2.localizedDescription);
            [self AudioSessionStart];
//            [[UIApplication sharedApplication] endReceivingRemoteControlEvents];
        }
    }
    
}

- (void)initAudioParams {
    _starting = NO;
    _started = NO;
    _recording = NO;
    _stopping = NO;
    _stopped = YES;
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
    
    
    [self initAudioParams];
    
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
                CLog(@"successfully write magic cookie to file");
            }else {
                CLog(@"faild write magic cookie to file");
            }
        }
        free(magicCookie);
    }
    
    AudioQueueAddPropertyListener(queue, kAudioQueueProperty_IsRunning, AudioQueueIsRunningPropertyChange, (__bridge void *)self);
    
    UInt32 basicDescriptionSize = sizeof(mDataFormat);
    OSStatus status = AudioQueueGetProperty(queue, kAudioQueueProperty_StreamDescription, &mDataFormat, &basicDescriptionSize);
    NSAssert(status == noErr, @"get stream description error");
    
}


void AQInputCallback (void           * inUserData,
                      AudioQueueRef          inAudioQueue,
                      AudioQueueBufferRef    inBuffer,
                      const AudioTimeStamp   * inStartTime,
                      UInt32          inNumPackets,
                      const AudioStreamPacketDescription * inPacketDesc)
{
    RecordManager * rt = (__bridge RecordManager*)inUserData;
    
    if (!rt ->_starting && !rt->_started && !rt->_stopping) {
        return;
    }
    
    if (inNumPackets == 0 && rt->mDataFormat.mBytesPerPacket != 0)
        inNumPackets = inBuffer->mAudioDataByteSize / rt->mDataFormat.mBytesPerPacket;
    if (inNumPackets > 0) {
        OSStatus err = AudioFileWritePackets(rt->recordFile, FALSE, inBuffer->mAudioDataByteSize, inPacketDesc, rt->recordPacket, &inNumPackets, inBuffer->mAudioData);
        if (err != noErr) {
            CLog(@"fail write to file with error:%d, inNumPackets:%u, audioDataByteSize:%u", (int)err, (unsigned int)inNumPackets, (unsigned int)inBuffer->mAudioDataByteSize);
            return;
        }
        CLog(@"success write audio file packet %d", (int)inNumPackets);
        rt->recordPacket += inNumPackets;
        AudioQueueEnqueueBuffer(inAudioQueue, inBuffer, 0, NULL);
    }
    
}


static void AudioQueueIsRunningPropertyChange(void *inUserData, AudioQueueRef inAQ, AudioQueuePropertyID inID) {
    RecordManager * rt = (__bridge RecordManager*)inUserData;
    
    UInt32 isRunning = 0;
    UInt32 size = sizeof(isRunning);
    AudioQueueGetProperty(inAQ, kAudioQueueProperty_IsRunning, &isRunning, &size);
    if (isRunning) {
        [rt audioQueueStartedCallback];
    } else {
        [rt audioQueueStoppedCallback];
    }
}


- (OSStatus)AudioSessionStart {
    if (_recording) {
        return YES;
    }
    
    // during starting
    if (_starting) {
        return NO;
    }
    
    // during stopping, we can't start it
    if (_stopping) {
        return NO;
    }
    
    // now audio queue is paused, resume play
    if (_started) {
        return [self resume];
    }
    
    OSStatus status = noErr;
    for (NSInteger i = 0; i < kNumberBuffers; ++i) {
        status = AudioQueueAllocateBuffer(queue, gBufferSizeBytes, &buffers[i]);
        if (status != noErr) {
            break;
        }
        status = AudioQueueEnqueueBuffer(queue, buffers[i], 0, NULL);
        if (status != noErr) {
            break;
        }
    }
    if (status != noErr) {
        CLog(@"Allocate Buffer or Enqueue Buffer error:%d", (int)status);
        goto Failed_label;
    }
    
    _starting = YES;
    
    // The second parameter
    // The time at which the audio queue should start.
    // To specify a start time relative to the timeline of the associated audio device, use the mSampleTime field of the AudioTimeStamp structure. Use NULL to indicate that the audio queue should start as soon as possible.
    status = AudioQueueStart(queue, NULL);
    if (status != noErr) {
        goto Failed_label;
    }
    return YES;
    
Failed_label:
    _starting = NO;
    
    if (queue) {
        AudioQueueDispose(queue, false);
        queue = NULL;
    }
    for (NSInteger i = 0; i < kNumberBuffers; ++i) {
        buffers[i] = NULL;
    }
    
    return NO;
}


- (BOOL)resume {
    if (_started && !_recording) {
        OSStatus status = AudioQueueStart(queue, NULL);
        if (status == noErr) {
            _recording = YES;
        }
        return status == noErr;
    }
    return NO;
}


- (BOOL)pauseAudio {
    if (_recording) {
        // if audio queue is in stopping status, we omit the pause operation and return NO
        if (_stopping) {
            CLog(@"audio queue is in stopping status");
            return NO;
        }
        
        OSStatus status = AudioQueuePause(queue);
        if (status == noErr) {
            _recording = NO;
        }
        return status == noErr;
    }
    return NO;
}


- (void)AudioSessionDispose {
    if (queue) {
        AudioQueueDispose(queue, false);
        CLog(@"AudioSessionDispose");
        queue = NULL;
    }
    if (recordFile) {
        AudioFileClose(recordFile);
        recordFile = NULL;
    }
    self->recordPacket = 0;
    for (NSInteger i = 0; i < kNumberBuffers; ++i) {
        buffers[i] = NULL;
    }
    
}

- (void)stopImmediately:(BOOL)immediate {
    if (_started) {
        Boolean imme = immediate ? true : false;
        /*
         we don't get the result of AudioQueueStop because I think it would fail if audio queue is already stopped or audio queue is invalid, no matter what it is, the queue would be stopped
         */
        _started = NO;
        
        // audio queue begin to stop
        _stopping = YES;
        
        AudioQueueStop(queue, imme);
    }
}


- (void)StopAudio {
    [self stopImmediately:NO];
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


#pragma mark -

- (void)audioQueueStartedCallback {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    _starting = NO;
    _started = YES;
    _recording = YES;
}

- (void)audioQueueStoppedCallback {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    _recording = NO;
    _stopping = NO;
    _stopped = YES;
    
    
}


- (void)dealloc {
    if (queue) {
        AudioQueueRemovePropertyListener(queue, kAudioQueueProperty_IsRunning, AudioQueueIsRunningPropertyChange, (__bridge void *)self);
        
        if (_started) {
            AudioQueueStop(queue, true);
        }
        AudioQueueDispose(queue, true);
        
        queue = NULL;
    }
}



@end
