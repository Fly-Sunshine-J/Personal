//
//  GoodsModel.h
//  Demo测试
//
//  Created by vcyber on 16/6/30.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface GoodsModel : NSObject

@property (nonatomic, assign) CGFloat w;
@property (nonatomic, assign) CGFloat h;
@property (nonatomic, strong) NSString *img;
@property (nonatomic, strong) NSString *price;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
