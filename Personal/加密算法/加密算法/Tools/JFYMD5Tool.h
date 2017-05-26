//
//  JFYMD5Tool.h
//  加密算法
//
//  Created by vcyber on 17/5/23.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JFYMD5Tool : NSObject

/**
 MD5加密32位小写加密

 @param openString 待加密字符串
 @return 加密后字符串
 */
+ (NSString *)encryptMD5ForLower32Bate:(NSString *)openString;

/**
 MD5加密32位d大写加密
 
 @param openString 待加密字符串
 @return 加密后字符串
 */
+ (NSString *)encryptMD5ForUpper32Bate:(NSString *)openString;

/**
 MD5加密16位小写加密
 
 @param openString 待加密字符串
 @return 加密后字符串
 */
+ (NSString *)encryptMD5ForLower16Bate:(NSString *)openString;

/**
 MD5加密16位大写加密
 
 @param openString 待加密字符串
 @return 加密后字符串
 */
+ (NSString *)encryptMD5ForUpper16Bate:(NSString *)openString;

@end
