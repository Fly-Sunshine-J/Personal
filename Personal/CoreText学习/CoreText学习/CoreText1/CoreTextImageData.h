//
//  CoreTextImageData.h
//  CoreText学习
//
//  Created by vcyber on 17/8/30.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CoreTextImageData : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, assign) NSUInteger position;

//CoreText坐标
@property (nonatomic, assign) CGRect imagePosition;

@end
