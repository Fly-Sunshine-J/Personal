//
//  ChartsModel.h
//  Record
//
//  Created by vcyber on 17/1/6.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ChartsModel : NSObject

@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *num;
@property (nonatomic, strong) NSString *avg;
@property (nonatomic, assign) CGFloat numH;
@property (nonatomic, assign) CGFloat avgH;
@property (nonatomic, assign) BOOL isRed;

+ (instancetype)modelWithDictionary:(NSDictionary *)dict;

@end
