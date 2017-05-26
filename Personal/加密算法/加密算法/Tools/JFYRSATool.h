//
//  JFYRSATool.h
//  加密算法
//
//  Created by vcyber on 17/5/24.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JFYRSATool : NSObject

+ (instancetype)shareInstance;


/**
 从文件中获取公钥

 @param derFilePath 路径
 */
-(void) loadPublicKeyFromFile: (NSString*) derFilePath;

/**
 从文件中获取私钥

 @param p12FilePath 路径
 @param p12Password 密码
 */
-(void) loadPrivateKeyFromFile: (NSString*) p12FilePath password:(NSString*)p12Password;

/**
 加密字符串

 @param string 待加密字符串
 @return 加密结果
 */
-(NSString*) rsaEncryptString:(NSString*)string;

/**
 解密字符串

 @param string 待解密字符串
 @return 解密结果
 */

-(NSString*) rsaDecryptString:(NSString*)string;


/**
 加密二进制

 @param data 待加密二进制
 @return 加密结果
 */
-(NSData*) rsaEncryptData:(NSData*)data ;


/**
 解密二进制

 @param data 待解密二进制
 @return 解密结果
 */
-(NSData*) rsaDecryptData:(NSData*)data;



/**
 对数据进行sha256签名
 
 @param data 待签名数据
 @return 签名后的结果
 */
- (NSData *)rsaSHA256SignData:(NSData *)data;


/**
 验证签名

 @param data 待验证的数据
 @param signature 签名
 @return 是否验证通过
 */
- (BOOL)rsaSHA256VerifyData:(NSData *)data Signature:(NSData *)signature;


@end
