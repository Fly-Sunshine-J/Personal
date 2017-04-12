//
//  FYRecordManager.h
//  test
//
//  Created by vcyber on 17/3/17.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@class FYRecordManager;

@protocol FYRecordManagerDelegate <NSObject>
@required
- (AudioStreamBasicDescription)configASBDForRecord:(FYRecordManager *)record;

@optional
- (void)audioQueueRecorder:(FYRecordManager *)recorder Buffer:(AudioQueueBufferRef)buffer streamPacketDesc:(const AudioStreamPacketDescription *)inPacketDesc numberOfPacketDescription:(UInt32)inNumPackets;
- (void)audioQueueRecorderDidFinishRecord:(FYRecordManager *)recorder;
- (void)audioQueueRecorderBeginInterruption:(FYRecordManager *)recorder;
- (void)audioQueueRecorderEndInterruption:(FYRecordManager *)recorder;

@end

@interface FYRecordManager : NSObject

- (instancetype)initWithDelegate:(id<FYRecordManagerDelegate>)delegate AndRecordFilePath:(NSString *)path;

@property (nonatomic, weak) id<FYRecordManagerDelegate>delegate;

@property (nonatomic, assign) BOOL recording;

- (void)queueDispose;
- (void)queueStop;
- (BOOL)queuePause;
- (BOOL)queueStart;

@end
