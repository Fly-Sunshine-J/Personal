//
//  PictureModel.m
//  ComicAndPicture
//
//  Created by MS on 16/3/8.
//  Copyright © 2016年 JFY. All rights reserved.
//

#import "PictureModel.h"

@implementation PictureModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
    if ([key isEqualToString:@"id"]) {
        
        self.pic_id = value;
    }
}

@end
