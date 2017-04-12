//
//  ComicModel.h
//  ComicAndPicture
//
//  Created by MS on 16/3/4.
//  Copyright © 2016年 JFY. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Comic;

@interface ComicModel : NSObject

@property (nonatomic, strong) NSString *comicId;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSString *images;

@property (nonatomic, strong) NSString *author;

@property (nonatomic, strong) NSString *categorys;

@property (nonatomic, strong) NSString *introduction;

@property (nonatomic, strong) NSString *updateType;

@property (nonatomic, strong) NSString *updateValue;

@property (nonatomic, strong) NSString *totalChapterCount;

@property (nonatomic, strong) NSString *updateInfo;

@property (nonatomic, assign) NSInteger tag;

@property (nonatomic, assign, getter=isCollection) BOOL collection;

@property (nonatomic, assign, getter=isRead) BOOL read;

@property (nonatomic, assign, getter=isDownload) BOOL download;

@property (nonatomic, strong) NSData *data;

@property (nonatomic, strong) NSString *totalCartoonSize;

@property (nonatomic, assign, getter=isDownloading) BOOL downloading;

@property (nonatomic, assign) float progress;

- (instancetype)configModelWithEntityModel:(Comic *)entityModel;

@end
