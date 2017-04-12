//
//  AudioRecord.h
//  test
//
//  Created by vcyber on 17/3/16.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AudioRecordDelegate <NSObject>

@end

@interface AudioRecord : NSObject

+ (instancetype)shareInstance;

- (void)setRecordFileWithFilePath:(NSString *)filePath;

- (BOOL)record;

- (void)pause;

- (void)stop;

@property (nonatomic, weak) id<AudioRecordDelegate>delegate;

@end
