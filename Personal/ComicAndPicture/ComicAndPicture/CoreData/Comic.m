//
//  Comic.m
//  ComicAndPicture
//
//  Created by MS on 16/3/14.
//  Copyright © 2016年 JFY. All rights reserved.
//

#import "Comic.h"
#import "ComicModel.h"

@implementation Comic

- (instancetype)configEntityModelWithModel:(ComicModel *)model {
    
    self.author = model.author;
    
    self.categorys = model.categorys;
    
    self.comicId = model.comicId;
    
    self.images = model.images;
    
    self.introduction = model.introduction;
    
    self.name = model.name;
    
    self.totalChapterCount = model.totalChapterCount;
    
    self.updateInfo = model.updateInfo;
    
    self.updateType = model.updateType;
    
    self.updateValue = model.updateValue;
    
    self.tag = [NSNumber numberWithInteger:model.tag];
    
    self.isCollection = [NSNumber numberWithBool:model.collection];
    
    self.isRead = [NSNumber numberWithBool:model.read];
    
    self.isDownload = [NSNumber numberWithBool:model.download];
    
    self.downloadData = model.data;
    
    self.downloading = [NSNumber numberWithBool:model.downloading];
    
    return self;
}

@end
