//
//  musicDescription.m
//  vcyberLoadMusic
//
//  Created by dengweihao on 16/4/19.
//  Copyright © 2016年 dengweihao. All rights reserved.
//

#import "musicDescription.h"

@implementation musicDescription

- (void)setItems1:(MPMediaItem *)items1 {
    _persistentID = items1.persistentID ;
    _mediaType = items1.mediaType ;
    _title = items1.title ;
    _albumTitle = items1.albumTitle ;
    _albumPersistentID = items1.albumPersistentID ;
    _artist = items1.artist ;
    _artistPersistentID = items1.artistPersistentID ;
    _albumArtist = items1.albumArtist;
    _albumArtistPersistentID = items1.albumArtistPersistentID ;
    _genre = items1.genre;
    _genrePersistentID = items1.genrePersistentID;
    _composer = items1.composer;
    _composerPersistentID = items1.composerPersistentID;
    _playbackDuration = items1.playbackDuration;
    _albumTrackNumber = items1.albumTrackNumber;
    _albumTrackCount = items1.albumTrackCount;
    _discNumber = items1.discNumber;
    _discCount = items1.discCount;
    _artwork = items1.artwork;
    _lyrics = items1.lyrics;
    _compilation = items1.compilation;
    _releaseDate = items1.releaseDate;
    _beatsPerMinute = items1.beatsPerMinute;
    _comments = items1.comments;
    _assetURL = items1.assetURL;
    _cloudItem = items1.cloudItem;
    _protectedAsset = items1.protectedAsset;
    _podcastTitle = items1.podcastTitle;
    _podcastPersistentID = items1.podcastPersistentID;
    _playCount = items1.playCount;
    _skipCount = items1.skipCount;
    _rating = items1.rating;
    _lastPlayedDate = items1.lastPlayedDate;
    _userGrouping = items1.userGrouping;
    _bookmarkTime = items1.bookmarkTime;
}



@end
