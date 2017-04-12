//
//  RecordManager.h
//  Cadillac
//
//  Created by vcyber on 17/1/13.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RecordManager : NSObject

@property (nonatomic, getter=isRecording) BOOL recording;

- (void)AudioSessionInit:(BOOL)is16k AudioPath:(NSString *)path;

- (OSStatus)AudioSessionStart;

- (void)AudioSessionDispose;

- (void)StopAudio;

- (BOOL)pauseAudio;


@end
