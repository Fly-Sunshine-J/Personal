//
//  PCMSmallReader.h
//  RawAudioDataPlayer
//
//  Created by ztf on 16/1/15.
//  Copyright © 2016年 SamYou. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AudioToolbox/AudioToolbox.h>

@interface PCMSmallReader : NSObject
- (instancetype)initWithPath:(NSString *)path;
-(BOOL)play;
-(void)stop;
@end
