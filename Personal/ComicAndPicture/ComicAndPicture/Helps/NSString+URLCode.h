//
//  NSString+URLCode.h
//  LOL
//
//  Created by 刘清 on 16/3/10.
//  Copyright (c) 2016年 LQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (URLCode)
//编码 string code -> url code
-(NSString *)URLEncodedString;
//解码 url code -> string code
-(NSString *)URLDecodedString;

@end
