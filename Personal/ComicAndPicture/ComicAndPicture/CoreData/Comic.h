//
//  Comic.h
//  ComicAndPicture
//
//  Created by MS on 16/3/14.
//  Copyright © 2016年 JFY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ComicModel;

NS_ASSUME_NONNULL_BEGIN

@interface Comic : NSManagedObject

- (instancetype)configEntityModelWithModel:(ComicModel *)model;

@end

NS_ASSUME_NONNULL_END

#import "Comic+CoreDataProperties.h"
