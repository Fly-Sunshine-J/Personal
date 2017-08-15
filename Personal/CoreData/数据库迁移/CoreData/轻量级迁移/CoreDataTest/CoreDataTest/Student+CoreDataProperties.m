//
//  Student+CoreDataProperties.m
//  CoreDataTest
//
//  Created by vcyber on 17/8/11.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import "Student+CoreDataProperties.h"

@implementation Student (CoreDataProperties)

+ (NSFetchRequest<Student *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Student"];
}

@dynamic age;
@dynamic name;
@dynamic books;

@end
