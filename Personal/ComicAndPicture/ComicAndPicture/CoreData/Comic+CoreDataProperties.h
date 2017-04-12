//
//  Comic+CoreDataProperties.h
//  ComicAndPicture
//
//  Created by Wudan on 16/3/19.
//  Copyright © 2016年 JFY. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Comic.h"

NS_ASSUME_NONNULL_BEGIN

@interface Comic (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *author;
@property (nullable, nonatomic, retain) NSString *categorys;
@property (nullable, nonatomic, retain) NSString *comicId;
@property (nullable, nonatomic, retain) NSData *downloadData;
@property (nullable, nonatomic, retain) NSString *images;
@property (nullable, nonatomic, retain) NSString *introduction;
@property (nullable, nonatomic, retain) NSNumber *isCollection;
@property (nullable, nonatomic, retain) NSNumber *isDownload;
@property (nullable, nonatomic, retain) NSNumber *isRead;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *tag;
@property (nullable, nonatomic, retain) NSString *totalChapterCount;
@property (nullable, nonatomic, retain) NSString *updateInfo;
@property (nullable, nonatomic, retain) NSString *updateType;
@property (nullable, nonatomic, retain) NSString *updateValue;
@property (nullable, nonatomic, retain) NSNumber *downloading;

@end

NS_ASSUME_NONNULL_END
