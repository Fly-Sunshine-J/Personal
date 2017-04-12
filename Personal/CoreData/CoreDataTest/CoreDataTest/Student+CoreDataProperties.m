//
//  Student+CoreDataProperties.m
//  CoreDataTest
//
//  Created by vcyber on 16/10/25.
//  Copyright © 2016年 vcyber. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Student+CoreDataProperties.h"

@implementation Student (CoreDataProperties)

@dynamic name;
@dynamic age;
@dynamic books;

- (void)addBooksObject:(Book *)value {
    NSMutableOrderedSet *set = [self.books mutableCopy];
    [set addObject:value];
    self.books = set;
}

@end
