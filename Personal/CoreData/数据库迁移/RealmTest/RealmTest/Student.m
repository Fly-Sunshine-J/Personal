//
//  Student.m
//  RealmTest
//
//  Created by vcyber on 16/10/25.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "Student.h"

@implementation Student

+ (Sex)sexTypeForString:(NSString *)typeString {
    if ([typeString isEqualToString:@"男"]) {
        return Male;
    }else if ([typeString isEqualToString:@"女"]) {
        return Female;
    }else {
        return Unknow;
    }
}

//设置主键
+ (NSString *)primaryKey {
    return @"num";
}


//非空字段
+ (NSArray<NSString *> *)requiredProperties {
    return @[@"name"];
}

//设置忽略字段
+ (NSArray<NSString *> *)ignoredProperties {
    return nil;
}

@end
