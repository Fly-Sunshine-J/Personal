//
//  PCMSmallReader.m
//  RawAudioDataPlayer
//
//  Created by ztf on 16/1/15.
//  Copyright © 2016年 SamYou. All rights reserved.
//

#import "PCMSmallReader.h"
#define QUEUE_BUFFER_SIZE 4 //队列缓冲个数
#define EVERY_READ_LENGTH 1000 //每次从文件读取的长度
#define MIN_SIZE_PER_FRAME 2000 //每侦最小数据长度




@interface PCMSmallReader ()
{
    AudioStreamBasicDescription _audioDescription;///音频参数
    AudioQueueRef _audioQueue;//音频播放队列
    AudioQueueBufferRef audioQueueBuffers[QUEUE_BUFFER_SIZE];//音频缓存
    NSLock *_synlock ;///同步控制
    Byte *pcmDataBuffer;//pcm的读文件数据区
    FILE *_file;//pcm源文件
}



@end
@implementation PCMSmallReader

#pragma mark -
#pragma mark life cycle

- (instancetype)initWithPath:(NSString *)path
{
    self = [super init];
    if (self) {
        _synlock = [[NSLock alloc] init];
        
        _file = [self openFilePath:path];
    }
    return self;
}


-(void)dealloc{
    
    [_synlock release];
    [super dealloc];
}

/**
 *  打开文件
 */
-(FILE *)openFilePath:(NSString *)path{
    
    NSLog(@"%s:openFilePath:%@",__func__,path);
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:path] == NO) {
        NSLog(@"%s:openFilePath:fail",__func__);
    }
    FILE *file  = fopen([path UTF8String], "r");
    if(file){
        fseek(file, 0, SEEK_SET);
        pcmDataBuffer = malloc(EVERY_READ_LENGTH);
        return file;
    }
    return nil;
}


/**
 *  关闭文件
 */
-(int )closeFile:(FILE *)file{
    if (file) {
        return fclose(file);
    }
    return -1;
}


-(BOOL)play
{
    if (_file == nil) {
        return NO;
    }
    [self initAudio];
    AudioQueueStart(_audioQueue, NULL);
    for(int i=0;i<QUEUE_BUFFER_SIZE;i++){
        [self readPCMAndPlay:_audioQueue buffer:audioQueueBuffers[i]];
    }
    return YES;

    /*
     audioQueue使用的是驱动回调方式，即通过AudioQueueEnqueueBuffer(outQ, outQB, 0, NULL);传入一个buff去播放，播放完buffer区后通过回调通知用户,
     用户得到通知后再重新初始化buff去播放，周而复始,当然，可以使用多个buff提高效率(测试发现使用单个buff会小卡)
     */
}

-(void)stop{
    AudioQueueStop(_audioQueue, true);
}


#pragma mark player call back
/*
 试了下其实可以不用静态函数，但是c写法的函数内是无法调用[self ***]这种格式的写法，所以还是用静态函数通过void *input来获取原类指针
 这个回调存在的意义是为了重用缓冲buffer区，当通过AudioQueueEnqueueBuffer(outQ, outQB, 0, NULL);函数放入queue里面的音频文件播放完以后，通过这个函数通知
 调用者，这样可以重新再使用回调传回的AudioQueueBufferRef
 */
void AudioPlayerAQInputCallback(void *input, AudioQueueRef outQ, AudioQueueBufferRef outQB)
{
    NSLog(@"AudioPlayerAQInputCallback");
    PCMSmallReader *reader = (PCMSmallReader *)input;
    [reader checkUsedQueueBuffer:outQB];
    [reader readPCMAndPlay:outQ buffer:outQB];
}



-(void)initAudio
{
    ///设置音频参数
    _audioDescription.mSampleRate = 16000;//采样率
    _audioDescription.mFormatID = kAudioFormatLinearPCM;
    _audioDescription.mFormatFlags = kLinearPCMFormatFlagIsSignedInteger | kAudioFormatFlagIsPacked;
    _audioDescription.mChannelsPerFrame = 1;///单声道
    _audioDescription.mFramesPerPacket = 1;//每一个packet一侦数据
    _audioDescription.mBitsPerChannel = 16;//每个采样点16bit量化
    _audioDescription.mBytesPerFrame = 2;
    _audioDescription.mBytesPerPacket = 2;
    
    /**
     *创建一个新的从audioqueue到硬件层的通道
     */
    AudioQueueNewOutput(&_audioDescription, AudioPlayerAQInputCallback, self, nil, nil, 0, &_audioQueue);//使用player的内部线程播
    /**
     *添加buffer区
     */
    for(int i=0;i<QUEUE_BUFFER_SIZE;i++){
        /**
         *创建buffer区，MIN_SIZE_PER_FRAME为每一侦所需要的最小的大小，该大小应该比每次往buffer里写的最大的一次还大
         
         */
        int result =  AudioQueueAllocateBuffer(_audioQueue, MIN_SIZE_PER_FRAME, &audioQueueBuffers[i]);
        NSLog(@"AudioQueueAllocateBuffer i = %d,result = %d",i,result);
    }
}

-(void)readPCMAndPlay:(AudioQueueRef)outQ buffer:(AudioQueueBufferRef)outQB
{
    [_synlock lock];
    int readLength = (int)fread(pcmDataBuffer, 1, EVERY_READ_LENGTH, _file);//读取文件
    NSLog(@"read raw data size = %d",readLength);
    outQB->mAudioDataByteSize = readLength;
    Byte *audiodata = (Byte *)outQB->mAudioData;
    for(int i=0;i<readLength;i++){
        audiodata[i] = pcmDataBuffer[i];
    }
    /*
     将创建的buffer区添加到audioqueue里播放
     AudioQueueBufferRef用来缓存待播放的数据区，AudioQueueBufferRef有两个比较重要的参数，AudioQueueBufferRef->mAudioDataByteSize用来指示数据区大小，AudioQueueBufferRef->mAudioData用来保存数据区
     */
    AudioQueueEnqueueBuffer(outQ, outQB, 0, NULL);
    [_synlock unlock];
}

-(void)checkUsedQueueBuffer:(AudioQueueBufferRef) qbuf
{
    if(qbuf == audioQueueBuffers[0])
    {
//        NSLog(@"AudioPlayerAQInputCallback,bufferindex = 0");
    }
    if(qbuf == audioQueueBuffers[1])
    {
//        NSLog(@"AudioPlayerAQInputCallback,bufferindex = 1");
    }
    if(qbuf == audioQueueBuffers[2])
    {
//        NSLog(@"AudioPlayerAQInputCallback,bufferindex = 2");
    }
    if(qbuf == audioQueueBuffers[3])
    {
//        NSLog(@"AudioPlayerAQInputCallback,bufferindex = 3");
    }
}


@end
