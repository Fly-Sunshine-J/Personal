//
//  JFYMD5Tool.m
//  加密算法
//
//  Created by vcyber on 17/5/23.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import "JFYMD5Tool.h"
#import <CommonCrypto/CommonCrypto.h>

static NSString * encryptionKey = @"";

@implementation JFYMD5Tool


+ (NSString *)encryptMD5ForLower32Bate:(NSString *)openString {
    NSString *inputWithKey = [NSString stringWithFormat:@"%@%@", openString, encryptionKey];
    const char *inputString = [inputWithKey UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(inputString, (CC_LONG)strlen(inputString), result);
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02x", result[i]];
    }
    return digest;
}

+ (NSString *)encryptMD5ForUpper32Bate:(NSString *)openString {
    NSString *inputWithKey = [NSString stringWithFormat:@"%@%@", openString, encryptionKey];
    const char *inputString = [inputWithKey UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(inputString, (CC_LONG)strlen(inputString), result);
    NSMutableString *digest = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH];
    for (NSInteger i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [digest appendFormat:@"%02X", result[i]];
    }
    return digest;
}

+ (NSString *)encryptMD5ForLower16Bate:(NSString *)openString {
    NSString *result = [self encryptMD5ForLower32Bate:openString];
    NSString *digest;
    for (NSInteger i = 0; i < 24; i++) {
        digest = [result substringWithRange:NSMakeRange(8, 16)];
    }
    return digest;
}

+ (NSString *)encryptMD5ForUpper16Bate:(NSString *)openString {
    NSString *result = [self encryptMD5ForUpper32Bate:openString];
    NSString *digest;
    for (NSInteger i = 0; i < 24; i++) {
        digest = [result substringWithRange:NSMakeRange(8, 16)];
    }
    return digest;
}


@end
