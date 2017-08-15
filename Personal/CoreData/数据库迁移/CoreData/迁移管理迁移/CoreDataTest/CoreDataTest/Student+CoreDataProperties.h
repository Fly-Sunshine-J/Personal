//
//  Student+CoreDataProperties.h
//  CoreDataTest
//
//  Created by vcyber on 17/8/11.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import "Student+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Student (CoreDataProperties)

+ (NSFetchRequest<Student *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSNumber *age;
@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) NSOrderedSet<Book *> *books;

@end

@interface Student (CoreDataGeneratedAccessors)

- (void)insertObject:(Book *)value inBooksAtIndex:(NSUInteger)idx;
- (void)removeObjectFromBooksAtIndex:(NSUInteger)idx;
- (void)insertBooks:(NSArray<Book *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeBooksAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInBooksAtIndex:(NSUInteger)idx withObject:(Book *)value;
- (void)replaceBooksAtIndexes:(NSIndexSet *)indexes withBooks:(NSArray<Book *> *)values;
- (void)addBooksObject:(Book *)value;
- (void)removeBooksObject:(Book *)value;
- (void)addBooks:(NSOrderedSet<Book *> *)values;
- (void)removeBooks:(NSOrderedSet<Book *> *)values;

@end

NS_ASSUME_NONNULL_END
