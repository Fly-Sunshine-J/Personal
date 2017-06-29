//
//  MyClass1.m
//  Runtime
//
//  Created by vcyber on 17/6/27.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import "MyClass1.h"
#import <objc/runtime.h>

@interface MyClass1 (){
    NSInteger   _instance1;
    NSString    *_instance2;
    NSMutableDictionary *_propertys;
}

@property (nonatomic, assign) NSInteger integer;

- (void)method3WithArg1:(id)arg1 arg2:(id)arg2;

@end

@implementation MyClass1

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

+ (void)classMethod1 {
    
}

- (void)method1 {
    NSLog(@"method1");
}

- (void)method2 {
    NSLog(@"method2");
    [self method3WithArg1:@12 arg2:@"aaaa"];
}


- (void)method3WithArg1:(id)arg1 arg2:(NSString *)arg2 {
    NSLog(@"arg1 : %@  arg2: %@", arg1, arg2);
}

- (id)copyWithZone:(NSZone *)zone {
    return [[[self class] alloc] init];
}


- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    return [super init];
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    
}


@end
