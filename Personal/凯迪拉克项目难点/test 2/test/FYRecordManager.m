//
//  FYRecordManager.m
//  test
//
//  Created by vcyber on 17/3/17.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import "FYRecordManager.h"

#define  kNumberBuffers 3

/*
 
 测试下来，在处于stopping状态的时候，就可以开启另一个对象来录音了，在stopping的时候，录音设备应该不工作了，是指把录音好的缓存发送给上层，所以此时可以开启其他对象来录音。
 
 |--playing---|
 |--starting--|--playing--|--pause--|--playing--|--stopping--|--stopped--|
 |---------started-----------------|
 */

@interface FYRecordManager (){
    AudioStreamBasicDescription _asbd;
    AudioQueueRef _queue;
    
    AudioQueueBufferRef _buffers[kNumberBuffers];
    UInt32 _bufferSize;
    
    // audio queue is started AudioQueue can callBack
    BOOL _started;
    
    // audio device may not finish immediately after call AudioQueueStop, if you pass false as its second paramter.
    // during we call AudioQueueStop to it really finishs, _stopping is YES
    BOOL _stopping;
    
    UInt32 currentPacket;
    
    /**AudioFile的使用一定要在结束的时候关闭  不然音频文件不完整，无法播放*/
    AudioFileID afileId;
}

- (void)audioQueueStartedCallback;
- (void)audioQueueStoppedCallback;

@end

@implementation FYRecordManager

- (void)interruptHandle:(NSNotification *)notification {
    int inInterruptionState = [[notification.userInfo objectForKey:AVAudioSessionInterruptionTypeKey] intValue];
    if (inInterruptionState == kAudioSessionBeginInterruption)
    {
        if (_recording) {
            if (_delegate && [_delegate respondsToSelector:@selector(audioQueueRecorderBeginInterruption:)]) {
                [_delegate audioQueueRecorderBeginInterruption:self];
            }
            [self queuePause];
            NSError *err;
//            [[AVAudioSession sharedInstance] setActive:NO error:&err];
            NSLog(@"err----%@", err.localizedDescription);
        }
    }
    else if (inInterruptionState == kAudioSessionEndInterruption)
    {
        if (_started) {
            NSError *err, *err1;
            [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:&err];
            [[AVAudioSession sharedInstance]setActive:YES withOptions:AVAudioSessionSetActiveOptionNotifyOthersOnDeactivation error:&err1];
            NSLog(@"err----%@---%@", err.localizedDescription, err1.localizedDescription);
            if (_delegate && [_delegate respondsToSelector:@selector(audioQueueRecorderEndInterruption:)]) {
                [_delegate audioQueueRecorderEndInterruption:self];
            }
            [self queueStart];
        }
    }
    
}


- (instancetype)initWithDelegate:(id<FYRecordManagerDelegate>)delegate AndRecordFilePath:(NSString *)path {
    self = [super init];
    if (self) {
        /**打断处理*/
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(interruptHandle:) name:AVAudioSessionInterruptionNotification object:nil];
        
        _delegate = delegate;
        _started = NO;
        _stopping = NO;
        _recording = NO;
        
        _asbd = [_delegate configASBDForRecord:self];
        OSStatus status = noErr;
        status = AudioQueueNewInput(&_asbd, AudioQueueCallbackHandleBuffer, (__bridge void * _Nullable)(self), NULL, NULL, 0, &_queue);
        if (status != noErr) {
            _queue = nil;
            return self;
        }
        /*
         监测AudioQueue是不是在运行
         */
        AudioQueueAddPropertyListener(_queue, kAudioQueueProperty_IsRunning, AudioQueueListenerIsRunning, (__bridge void * _Nullable)(self));
        
//        UInt32 basicDescriptionSize = sizeof(_asbd);
//        status = AudioQueueGetProperty(_queue, kAudioQueueProperty_StreamDescription, &_asbd, &basicDescriptionSize);
//        NSAssert(status == noErr, @"get stream description error");
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(audioQueueRecorder:Buffer:streamPacketDesc:numberOfPacketDescription:)]) {
            /**如果代理实现这个方法，创建AudioFile在代理中创建*/
        }else {
            AudioFileTypeID audioFileType = kAudioFileM4AType;
            const char *recordFileName = [path UTF8String];
            CFURLRef url = CFURLCreateFromFileSystemRepresentation(NULL, (Byte *)recordFileName, strlen(recordFileName), FALSE);
            AudioFileCreateWithURL(url, audioFileType, &_asbd, kAudioFileFlags_EraseFile, &afileId);
            
            // Set a magic cookie to file
            OSStatus result = noErr;
            UInt32 cookieSize;
            if (AudioQueueGetPropertySize(_queue, kAudioQueueProperty_MagicCookie, &cookieSize) == noErr) {
                char *magicCookie = (char *)malloc(cookieSize);
                if (AudioQueueGetProperty(_queue,
                                          kAudioQueueProperty_MagicCookie,
                                          magicCookie,
                                          &cookieSize) == noErr) {
                    result = AudioFileSetProperty(afileId, kAudioFilePropertyMagicCookieData, cookieSize, magicCookie);
                    if (result == noErr) {
                        NSLog(@"successfully write magic cookie to file");
                    }else {
                        NSLog(@"faild write magic cookie to file");
                    }
                }
                free(magicCookie);
            }
        }
        
    }
    return self;
}


static void AudioQueueCallbackHandleBuffer(
                                    void * __nullable               inUserData,
                                    AudioQueueRef                   inAQ,
                                    AudioQueueBufferRef             inBuffer,
                                    const AudioTimeStamp *          inStartTime,
                                    UInt32                          inNumberPacketDescriptions,
                                    const AudioStreamPacketDescription * __nullable inPacketDescs){
    FYRecordManager *manager = (__bridge FYRecordManager *)inUserData;
    if (!manager->_started && !manager->_stopping) {
        return;
    }
    if (inNumberPacketDescriptions == 0 && manager->_asbd.mBytesPerPacket != 0)
        inNumberPacketDescriptions = inBuffer->mAudioDataByteSize / manager->_asbd.mBytesPerPacket;
    
    if (manager.delegate && [manager.delegate respondsToSelector:@selector(audioQueueRecorder:Buffer:streamPacketDesc:numberOfPacketDescription:)]) {
        [manager.delegate audioQueueRecorder:manager Buffer:inBuffer streamPacketDesc:inPacketDescs numberOfPacketDescription:inNumberPacketDescriptions];
    }else {
        if (inNumberPacketDescriptions > 0) {
            OSStatus err = AudioFileWritePackets(manager->afileId, FALSE, inBuffer->mAudioDataByteSize, inPacketDescs, manager->currentPacket, &inNumberPacketDescriptions, inBuffer->mAudioData);
            if (err != noErr) {
                NSLog(@"fail write to file with error:%d, inNumPackets:%u, audioDataByteSize:%u", (int)err, (unsigned int)inNumberPacketDescriptions, (unsigned int)inBuffer->mAudioDataByteSize);
                return;
            }
            NSLog(@"success write audio file packet %d", (int)inNumberPacketDescriptions);
            manager->currentPacket += inNumberPacketDescriptions;
        }
    }
    
    AudioQueueEnqueueBuffer(inAQ, inBuffer, 0, NULL);
}

/**
 回调监测是不是运行
 */
static void AudioQueueListenerIsRunning (
                                         void * __nullable       inUserData,
                                         AudioQueueRef           inAQ,
                                         AudioQueuePropertyID    inID){
    FYRecordManager *manager = (__bridge FYRecordManager *)inUserData;
    UInt32 isRunning = 0;
    UInt32 size = sizeof(isRunning);
    AudioQueueGetProperty(inAQ, kAudioQueueProperty_IsRunning, &isRunning, &size);
    if (isRunning) {
        [manager audioQueueStartedCallback];
    } else {
        [manager audioQueueStoppedCallback];
    }
    
}

#pragma mark -

- (void)audioQueueStartedCallback {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    _started = YES;
    _recording = YES;
}

- (void)audioQueueStoppedCallback {
    NSLog(@"%@", NSStringFromSelector(_cmd));
    
    _recording = NO;
    _stopping = YES;
    
    if (_delegate && [_delegate respondsToSelector:@selector(audioQueueRecorderDidFinishRecord:)]) {
        [_delegate audioQueueRecorderDidFinishRecord:self];
    }
}

#pragma mark ----
- (BOOL)queueStart {
    if (_recording) {
        return YES;
    }

    if (_stopping) {
        return NO;
    }
    if (_started) {
        return [self resume];
    }
    
    OSStatus stauts = noErr;
    _bufferSize = [self deriveAudioBufferWithSeconds:0.1];
    for (int i = 0; i <kNumberBuffers; i++) {
        stauts = AudioQueueAllocateBuffer(_queue, _bufferSize, &_buffers[i]);
        if (stauts != noErr) {
            break;
        }
        stauts = AudioQueueEnqueueBuffer(_queue, _buffers[i], 0, NULL);
        if (stauts != noErr) {
            break;
        }
    }
    if (stauts != noErr) {
        NSLog(@"创建buffer失败--%@", @(stauts));
        
        goto Failed_label;
    }
    
    stauts = AudioQueueStart(_queue, NULL);
    if (stauts != noErr) {
        goto Failed_label;
    }
    return YES;
    
Failed_label:
    
    if (_queue) {
        AudioQueueDispose(_queue, false);
        _queue = NULL;
    }
    for (NSInteger i = 0; i < kNumberBuffers; ++i) {
        _buffers[i] = NULL;
    }
    
    return NO;
}



- (BOOL)resume {
    if (_started && !_recording) {
        OSStatus status = AudioQueueStart(_queue, NULL);
        if (status == noErr) {
            _recording = YES;
            return YES;
        }
        return status == noErr;
    }
    return NO;
}


- (BOOL)queuePause {
    if (_recording) {
        if (_stopping) {
            NSLog(@"queue已经暂停状态");
            return NO;
        }
        OSStatus status = noErr;
        status = AudioQueuePause(_queue);
        if (status == noErr) {
            _recording = NO;
        }
        return status == noErr;
    }
    return NO;
}


- (void)queueStop:(BOOL)immediate {
    if (_started) {
        Boolean imme = immediate ? true : false;
        _started = NO;
        _stopping = YES;
        AudioQueueStop(_queue, imme);
    }
}

- (void)queueStop {
    [self queueStop:NO];
}

- (void)queueDispose {
    if (_queue) {
        AudioQueueDispose(_queue, false);
        _queue = NULL;
    }
    if (afileId) {
        AudioFileClose(afileId);
        afileId = NULL;
    }
    self->currentPacket = 0;
    for (NSInteger i = 0; i < kNumberBuffers; ++i) {
        _buffers[i] = NULL;
    }
    NSLog(@"AudioSessionDispose");
}


/**
 计算根据时间buffer的大小，这个计算方法不适用m4a&aac  但是如果是m4a&aac的buffer的大小建议固定为1024，有一些值是不行的1024测试可以
 
 @param seconds 秒数
 @return buffer的大小
 */
- (UInt32)deriveAudioBufferWithSeconds:(Float64)seconds {
    // 0x10000 = 5*16*16*16*16 ~ 320k
    static const int maxBufferSize = 0x50000;
    
    if (_asbd.mFormatID == kAudioFormatMPEG4AAC) {
        return 1024;
    }
    
    int maxPacketSize = _asbd.mBytesPerPacket;
    if (maxPacketSize == 0) {
        UInt32 maxVBRPacketSize = sizeof(maxPacketSize);
        AudioQueueGetProperty (_queue,
                               kAudioQueueProperty_MaximumOutputPacketSize,
                               &maxPacketSize,
                               &maxVBRPacketSize);
    }
    
    Float64 numBytesForTime = 0;
    if (_asbd.mFramesPerPacket > 0) {
        numBytesForTime = (_asbd.mSampleRate / _asbd.mFramesPerPacket) * maxPacketSize * seconds;
    } else {
        numBytesForTime = _asbd.mSampleRate * maxPacketSize * seconds;
    }
    
    // don't exceed maxBufferSize
    numBytesForTime = numBytesForTime < maxBufferSize ? numBytesForTime : maxBufferSize;
    // don't less than maxPacketSize
    return numBytesForTime < maxPacketSize ? maxPacketSize : numBytesForTime;
}



@end
