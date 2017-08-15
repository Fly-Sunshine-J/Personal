//
//  Book+CoreDataProperties.h
//  CoreDataTest
//
//  Created by vcyber on 17/8/11.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import "Book+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Book (CoreDataProperties)

+ (NSFetchRequest<Book *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSNumber *price;
@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSString *author;
@property (nullable, nonatomic, retain) Student *student;

@end

NS_ASSUME_NONNULL_END
