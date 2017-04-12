//
//  AudioUtil.m
//  NewerVDSDK
//
//  Created by dengweihao on 16/3/11.
//  Copyright © 2016年 dengweihao. All rights reserved.
//

#import "AudioUtil.h"
#include "tsilk.h"

static AudioUtil *_instance;

@implementation AudioUtil

#pragma mark - Use tsilk encode or dcode audio PCM data
#pragma mark -

+ (int)tsilkEncodeAudio:(NSData *)audio  encodedData:(NSData **)encodedData samplingRate:(NSInteger)hz level:(NSInteger)level
{
    const void * src = (const void *)[audio bytes];
    int src_len = (int)[audio length];
    void * encoded = malloc(src_len);
    int dst_len = src_len;
    
    int encodeRstCode = tsilk_encode_vcyber(src, src_len, encoded, dst_len, (int)hz, (int)level);
    
    int rst = 1;
    if (encodeRstCode != 0 && encodeRstCode < src_len) {
        *encodedData = [NSData dataWithBytes:encoded length:encodeRstCode];
        rst = 0;
    }
    free(encoded);
    
    return rst;
}


+ (int)tsilkDecodeAudio:(NSData *)encodData  decodedData:(NSData **)decodedData samplingRate:(NSInteger)hz
{
    const void * src = (const void *)[encodData bytes];
    int src_len = (int)[encodData length];
    int dst_len = src_len * 15;
    void * decoded = malloc(dst_len);
    int decodeRstCode = tsilk_decode_vcyber(src, src_len, decoded, dst_len, (int)hz);
    
    int rst = 1;
    if (decodeRstCode != 0) {
        if (decodeRstCode < dst_len) {
            *decodedData = [NSData dataWithBytes:decoded length:decodeRstCode];
        } else {
            free(decoded);
            decoded = malloc(decodeRstCode);
            tsilk_decode_vcyber(src, src_len, decoded, decodeRstCode, (int)hz);
            *decodedData = [NSData dataWithBytes:decoded length:decodeRstCode];
        }
        rst = 0;
    }
    free(decoded);
    
    return rst;
}


//去掉wav的音频头
+ (NSData *)cutAudioHeaderWithAudio:(NSData *)audio
{
    unsigned char key[4] = {0x64,0x61,0x74,0x61}; //data
    
    NSData *data_key = [NSData dataWithBytes:key length:4]; //data
    
    NSRange searchRange = NSMakeRange(0, audio.length - 1);
    NSRange range = [audio rangeOfData:data_key options:NSDataSearchBackwards range:searchRange];
    if (range.location == NSNotFound) {
        return audio;
    }
    
    NSRange len_range = NSMakeRange(range.location + 4, 4);
    NSData *len_data = [audio subdataWithRange:len_range];
    int audio_len = *(int *)[len_data bytes];
    
    NSRange rstRange = NSMakeRange(len_range.location + 4, audio_len);
    NSData *rstData = [audio subdataWithRange:rstRange];
    
    return rstData;
}

+ (NSData *)addHeader:(NSData *)pcmData channels:(int)channels longSampleRate:(int)longSampleRate byteWidth:(int)byteWidth {
    if (nil == pcmData)
    {
        return nil;
    }
    NSMutableData *mndata = [[NSMutableData alloc] init];
    Byte header[44] ;
    int pcmlen = (int)[pcmData length];
    int totallen = pcmlen + 36;
    header[0] = 'R';    // 资源交换文件标志(RIFF)
    header[1] = 'I';
    header[2] = 'F';
    header[3] = 'F';
    header[4] = totallen&0xff;  // 从下个地址开始到文件尾的总字节数
    header[5] = (totallen >> 8)&0xff;
    header[6] = (totallen >> 16)&0xff;
    header[7] = (totallen >> 24)&0xff;
    header[8] = 'W';    // WAV文件标志(WAVE)
    header[9] = 'A';
    header[10] = 'V';
    header[11] = 'E';
    header[12] = 'f';   // 波形格式标志(fmt), 最后一位空格.
    header[13] = 'm';
    header[14] = 't';
    header[15] = ' ';
    header[16] = 16; // 过滤字节（一般为00000010H）
    header[17] = 0;
    header[18] = 0;
    header[19] = 0;
    header[20] = 1; // 格式种类（值为1时, 表示数据为线性PCM编码）
    header[21] = 0;
    header[22] = channels; // 通道数，单声道为1，双声道为2
    header[23] = 0;
    header[24] = longSampleRate & 0xff;  // 采样率（每秒样本数），表示每个通道的播放速度，
    header[25] = longSampleRate >> 8 & 0xff;
    header[26] = longSampleRate >> 16 & 0xff;
    header[27] = longSampleRate >> 24 & 0xff;
    
    int byteRate = longSampleRate * channels * byteWidth / 8;
    header[28] = byteRate & 0xff;  // 波形数据传输速率（每秒平均字节数）, 其值为通道数×每秒数据位数×每样本的数据位数／8。播放软件利用此值可以估计缓冲区的大小
    header[29] = byteRate >> 8 & 0xff;
    header[30] = byteRate >> 16 & 0xff;
    header[31] = byteRate >> 24 & 0xff;
    header[32] = channels*byteWidth/8;  // DATA数据块长度，字节。其值为通道数×每样本的数据位值／8。播放软件需要一次处理多个该值大小的字节数据，以便将其值用于缓冲区的调整。
    header[33] = 0;
    header[34] = byteWidth; // PCM位宽, 每样本的数据位数，表示每个声道中各个样本的数据位数。如果有多个声道，对每个声道而言，样本大小都一样。
    header[35] = 0;
    header[36] = 'd';  // 数据标记符＂data＂
    header[37] = 'a';
    header[38] = 't';
    header[39] = 'a';
    header[40] = pcmlen & 0xff; // 语音数据的长度
    header[41] = pcmlen >> 8 & 0xff;
    header[42] = pcmlen >> 16 & 0xff;
    header[43] = pcmlen >> 24 & 0xff;
    [mndata appendBytes:header length:44];
    [mndata appendData:pcmData];
    
    return mndata;
}

+ (instancetype)sharedInstance
{
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        _instance = [[[self class] alloc] init];
    });
    return _instance;
}

@end
