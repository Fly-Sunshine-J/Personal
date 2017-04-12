//
//  JFYMusicModel.h
//  StreamMedia(Study)
//
//  Created by vcyber on 16/5/4.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>

@interface JFYMusicModel : NSObject

@property (nonatomic, copy) NSString *music;
@property (nonatomic, copy) NSString *musicType;
@property (nonatomic, copy) NSString *singer;
@property (nonatomic, strong) NSURL *musicURL;
@property (nonatomic, strong) MPMediaItemArtwork *artwork;
@property (nonatomic, assign) NSTimeInterval time;

@end
