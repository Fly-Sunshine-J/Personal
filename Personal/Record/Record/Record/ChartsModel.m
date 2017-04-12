//
//  ChartsModel.m
//  Record
//
//  Created by vcyber on 17/1/6.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import "ChartsModel.h"

@implementation ChartsModel

+ (instancetype)modelWithDictionary:(NSDictionary *)dict {
    
    ChartsModel *model = [[ChartsModel alloc] init];
    [model setValuesForKeysWithDictionary:dict];
    model.numH = (200 - 40) * [model.num intValue] / 100;
    model.avgH = (200 - 40) * [model.avg intValue] / 100;
    if (model.numH > 160) {
        model.numH = 160;
    }
    return model;
}

@end
