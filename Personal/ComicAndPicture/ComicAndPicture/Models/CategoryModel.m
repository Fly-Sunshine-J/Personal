//
//  CategoryModel.m
//  ComicAndPicture
//
//  Created by MS on 16/3/12.
//  Copyright © 2016年 JFY. All rights reserved.
//

#import "CategoryModel.h"

@implementation CategoryModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    if ([key isEqualToString:@"id"]) {
        
        self.categoryId = value;
        
    }
    
}

@end
