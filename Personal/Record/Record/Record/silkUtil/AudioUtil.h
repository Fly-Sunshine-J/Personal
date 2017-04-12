//
//  AudioUtil.h
//  NewerVDSDK
//
//  Created by dengweihao on 16/3/11.
//  Copyright © 2016年 dengweihao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AudioUtil : NSObject

/*
 *
 * hz 8000 or 16000
 *
 * level 1 ~ 10
 *
 * reture 0 encode success , 1 encord error
 */
+ (int)tsilkEncodeAudio:(NSData *)audio  encodedData:(NSData **)encodedData samplingRate:(NSInteger)hz level:(NSInteger)level;

/*
 *
 * hz 8000 or 16000
 *
 * reture 0 decode success , 1 decord error
 */
+ (int)tsilkDecodeAudio:(NSData *)encodData  decodedData:(NSData **)decodedData samplingRate:(NSInteger)hz;

/*
 * 去掉wav的音频头
 */
+ (NSData *)cutAudioHeaderWithAudio:(NSData *)audio;

/*
 *添加音频头
 */
+ (NSData *)addHeader:(NSData *)pcmData channels:(int)channels longSampleRate:(int)longSampleRate byteWidth:(int)byteWidth;

@end
