//
//  Person+CoreDataProperties.h
//  CoreDataTest
//
//  Created by vcyber on 16/5/30.
//  Copyright © 2016年 vcyber. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Person.h"

NS_ASSUME_NONNULL_BEGIN

@interface Person (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *age;

@end

NS_ASSUME_NONNULL_END
