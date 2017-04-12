//
//  ComicModel.m
//  ComicAndPicture
//
//  Created by MS on 16/3/4.
//  Copyright © 2016年 JFY. All rights reserved.
//

#import "ComicModel.h"
#import "Comic.h"

@implementation ComicModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    if ([key isEqualToString:@"id"]) {
        
        self.comicId = value;
        
    }
    
}


- (instancetype)configModelWithEntityModel:(Comic *)entityModel {
    
    self.author = entityModel.author;

    self.categorys = entityModel.categorys;
    
    self.comicId = entityModel.comicId;
    
    self.images = entityModel.images;
    
    self.introduction = entityModel.introduction;
    
    self.name = entityModel.name;
    
    self.tag = [entityModel.tag integerValue];
    
    self.totalChapterCount = entityModel.totalChapterCount;
    
    self.updateInfo = entityModel.updateInfo;
    
    self.updateType = entityModel.updateType;
    
    self.updateValue = entityModel.updateValue;
    
    self.collection = [entityModel.isCollection boolValue];
    
    self.read = [entityModel.isRead boolValue];
    
    self.download = [entityModel.isDownload boolValue];
    
    self.data = entityModel.downloadData;
    
    self.downloading = [entityModel.downloading boolValue];
    
    return self;
}

@end
