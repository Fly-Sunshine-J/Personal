//
//  PictureModel.h
//  ComicAndPicture
//
//  Created by MS on 16/3/8.
//  Copyright © 2016年 JFY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PictureModel : NSObject

@property (nonatomic, strong) NSString *pic_id;

@property (nonatomic, strong) NSString *qhimg_thumb_url;

@property (nonatomic, strong) NSString *cover_width;

@property (nonatomic, strong) NSString *cover_height;

@property (nonatomic, strong) NSString *group_title;

@property (nonatomic, strong) NSString *name;

@property (nonatomic, strong) NSDictionary *icon;

@property (nonatomic, strong) NSString *next;

@property (nonatomic, strong) NSString *total_count;

@property (nonatomic, strong) NSString *qhimg_url;

@property (nonatomic, strong) NSString *downurl;

@property (nonatomic, strong) NSString *url_l;

@property (nonatomic, strong) NSNumber *l_height;

@property (nonatomic, strong) NSNumber *l_width;

@end
