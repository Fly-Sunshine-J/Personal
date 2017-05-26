//
//  JFYAESTool.m
//  加密算法
//
//  Created by vcyber on 17/5/23.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import "JFYAESTool.h"
#import <CommonCrypto/CommonCryptor.h>

//加密模式  CBC
//填充方式 PKCS7Padding
//密钥长度 128
//初始向量

//初始向量
NSString *const kInitVector = @"16-Bytes--String";

@implementation JFYAESTool

+ (NSData *)cipherOperationWithData:(NSData *)contentData KeyString:(NSString *)key Operation:(CCOperation)operation {

    
    char keyPtr[kCCKeySizeAES128 + 1];
    memset(keyPtr, 0, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSUInteger dataLength = contentData.length;
    
    void const *initVectorBytes = [kInitVector dataUsingEncoding:NSUTF8StringEncoding].bytes;
    void const *contentBytes = contentData.bytes;
    
    size_t operationSize = dataLength + kCCBlockSizeAES128;
    void *operationBytes = malloc(operationSize);
    size_t actualOutSize = 0;
    
    CCCryptorStatus cryptStatus = CCCrypt(operation,
                                          kCCAlgorithmAES,
                                          kCCOptionPKCS7Padding,
                                          keyPtr,
                                          kCCBlockSizeAES128,
                                          initVectorBytes,
                                          contentBytes,
                                          dataLength,
                                          operationBytes,
                                          operationSize,
                                          &actualOutSize);
    
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:operationBytes length:actualOutSize];
    }
    free(operationBytes);
    return nil;
}

+ (NSString *)encryptUseAES:(NSString *)plainText key:(NSString *)key {
    NSData *contentData = [plainText dataUsingEncoding:NSUTF8StringEncoding];
    NSData *encrptyData = [JFYAESTool cipherOperationWithData:contentData KeyString:key Operation:kCCEncrypt];
    return [encrptyData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
}

+ (NSString *)decryptUseAES:(NSString *)cipherText key:(NSString *)key {
    NSData *contentData = [[NSData alloc] initWithBase64EncodedString:cipherText options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSData *encrptyData = [JFYAESTool cipherOperationWithData:contentData KeyString:key Operation:kCCDecrypt];
    return [[NSString alloc] initWithData:encrptyData encoding:NSUTF8StringEncoding];
}

@end
