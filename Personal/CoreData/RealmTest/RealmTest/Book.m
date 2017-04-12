//
//  Book.m
//  RealmTest
//
//  Created by vcyber on 16/10/25.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "Book.h"

@implementation Book

//设置默认值
+ (NSDictionary *)defaultPropertyValues {
    return nil;
}

//非空字段
+ (NSArray<NSString *> *)requiredProperties {
    return @[@"title"];
}

//设置忽略字段, 如果设置该字段将不会插入数据库
+ (NSArray<NSString *> *)ignoredProperties {
    return nil;
}

@end
