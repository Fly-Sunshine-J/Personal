//
//  JFYAESTool.h
//  加密算法
//
//  Created by vcyber on 17/5/23.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JFYAESTool : NSObject

/**
 加密方法
 
 @param plainText 原始数据
 @param key 加密的key(8位)
 @return 加密后的结果
 */
+(NSString *)encryptUseAES:(NSString *)plainText key:(NSString *)key;

/**
 解密方法
 
 @param cipherText 原始数据
 @param key 加密的key
 @return 解密后的结果
 */
+(NSString *)decryptUseAES:(NSString *)cipherText key:(NSString *)key;

@end
