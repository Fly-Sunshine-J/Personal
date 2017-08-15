//
//  Book+CoreDataProperties.m
//  CoreDataTest
//
//  Created by vcyber on 17/8/11.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import "Book+CoreDataProperties.h"

@implementation Book (CoreDataProperties)

+ (NSFetchRequest<Book *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Book"];
}

@dynamic price;
@dynamic title;
@dynamic author;
@dynamic student;

@end
