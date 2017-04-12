//
//  Student.m
//  RealmTest
//
//  Created by vcyber on 16/10/25.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "Student.h"

@implementation Student
//设置主键
+ (NSString *)primaryKey {
    return @"num";
}


//非空字段
+ (NSArray<NSString *> *)requiredProperties {
    return @[@"name"];
}

//设置默认值
+ (NSDictionary *)defaultPropertyValues {
    return nil;
}

//设置忽略字段
+ (NSArray<NSString *> *)ignoredProperties {
    return nil;
}

@end
