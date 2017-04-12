//
//  musicDescription.h
//  vcyberLoadMusic
//
//  Created by dengweihao on 16/4/19.
//  Copyright © 2016年 dengweihao. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MPMediaItem.h>

@interface musicDescription : NSObject

@property (nonatomic, strong, nullable) MPMediaItem *items1;

@property (nonatomic, readonly) MPMediaEntityPersistentID persistentID;
@property (nonatomic, readonly) MPMediaType mediaType;
@property (nonatomic, readonly, nullable) NSString *title;
@property (nonatomic, readonly, nullable) NSString *albumTitle;
@property (nonatomic, readonly) MPMediaEntityPersistentID albumPersistentID;
@property (nonatomic, readonly, nullable) NSString *artist;
@property (nonatomic, readonly) MPMediaEntityPersistentID artistPersistentID;
@property (nonatomic, readonly, nullable) NSString *albumArtist;
@property (nonatomic, readonly) MPMediaEntityPersistentID albumArtistPersistentID;
@property (nonatomic, readonly, nullable) NSString *genre;
@property (nonatomic, readonly) MPMediaEntityPersistentID genrePersistentID;
@property (nonatomic, readonly, nullable) NSString *composer;
@property (nonatomic, readonly) MPMediaEntityPersistentID composerPersistentID;
@property (nonatomic, readonly) NSTimeInterval playbackDuration;
@property (nonatomic, readonly) NSUInteger albumTrackNumber;
@property (nonatomic, readonly) NSUInteger albumTrackCount;
@property (nonatomic, readonly) NSUInteger discNumber;
@property (nonatomic, readonly) NSUInteger discCount;
@property (nonatomic, readonly, nullable) MPMediaItemArtwork *artwork;
@property (nonatomic, readonly, nullable) NSString *lyrics;
@property (nonatomic, readonly, getter = isCompilation) BOOL compilation;
@property (nonatomic, readonly, nullable) NSDate *releaseDate;
@property (nonatomic, readonly) NSUInteger beatsPerMinute;
@property (nonatomic, readonly, nullable) NSString *comments;
@property (nonatomic, readonly, nullable) NSURL *assetURL;
@property (nonatomic, readonly, getter = isCloudItem) BOOL cloudItem;
@property (nonatomic, readonly, getter = hasProtectedAsset) BOOL protectedAsset;
@property (nonatomic, readonly, nullable) NSString *podcastTitle;
@property (nonatomic, readonly) MPMediaEntityPersistentID podcastPersistentID;
@property (nonatomic, readonly) NSUInteger playCount;
@property (nonatomic, readonly) NSUInteger skipCount;
@property (nonatomic, readonly) NSUInteger rating;
@property (nonatomic, readonly, nullable) NSDate *lastPlayedDate;
@property (nonatomic, readonly, nullable) NSString *userGrouping;
@property (nonatomic, readonly) NSTimeInterval bookmarkTime;

@end
