//
//  MyClass1.h
//  Runtime
//
//  Created by vcyber on 17/6/27.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyClass1 : NSObject<NSCopying, NSCoding>

@property (nonatomic, strong) NSArray *array;
@property (nonatomic, strong) NSString *string;

- (void)method1;
- (void)method2;
+ (void)classMethod1;

@end
