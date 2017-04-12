//
//  GoodsModel.m
//  Demo测试
//
//  Created by vcyber on 16/6/30.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "GoodsModel.h"

@implementation GoodsModel

- (instancetype)initWithDict:(NSDictionary *)dict
{
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

@end
