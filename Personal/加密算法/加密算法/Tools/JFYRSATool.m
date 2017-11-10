//
//  JFYRSATool.m
//  加密算法
//
//  Created by vcyber on 17/5/24.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import "JFYRSATool.h"
#import <Security/Security.h>
#import <CommonCrypto/CommonCrypto.h>

@implementation JFYRSATool {
    SecKeyRef publicKey;
    SecKeyRef privateKey;
}

static JFYRSATool *tool = nil;

+ (instancetype)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        tool = [[JFYRSATool alloc] init];
    });
    return tool;
}

-(SecKeyRef) getPublicKey {
    return publicKey;
}
-(SecKeyRef) getPrivateKey {
    return privateKey;
}


- (void)loadPublicKeyFromFile:(NSString *)filePath {
    NSData *data = [[NSData alloc] initWithContentsOfFile:filePath];
    SecCertificateRef certificateRef = SecCertificateCreateWithData(kCFAllocatorDefault, (__bridge CFDataRef)data);
    SecPolicyRef policyRef = SecPolicyCreateBasicX509();
    SecTrustRef trustRef;
    OSStatus status = SecTrustCreateWithCertificates(certificateRef, policyRef, &trustRef);
    SecTrustResultType trustResult;
    if (status == noErr) {
        status = SecTrustEvaluate(trustRef, &trustResult);
    }
    
    SecKeyRef securityKey = SecTrustCopyPublicKey(trustRef);
    CFRelease(policyRef);
    CFRelease(certificateRef);
    CFRelease(trustRef);
    publicKey = securityKey;
}


- (void)loadPrivateKeyFromFile:(NSString *)filePath password:(NSString *)p12Password {
    NSData *p12Data = [[NSData alloc] initWithContentsOfFile:filePath];
    SecKeyRef privateKeyRef = NULL;
    NSMutableDictionary *options = [[NSMutableDictionary alloc] init];
    [options setObject:p12Password forKey:(__bridge NSString*)kSecImportExportPassphrase];
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    OSStatus securityError = SecPKCS12Import((__bridge CFDataRef)p12Data, (__bridge CFDictionaryRef)options, &items);
    if (securityError == noErr && CFArrayGetCount(items) > 0) {
        CFDictionaryRef identityDict = CFArrayGetValueAtIndex(items, 0);
        SecIdentityRef identityRef = (SecIdentityRef)CFDictionaryGetValue(identityDict, kSecImportItemIdentity);
        securityError = SecIdentityCopyPrivateKey(identityRef, &privateKeyRef);
        if (securityError != noErr) {
            privateKeyRef = NULL;
        }
    }
    CFRelease(items);
    privateKey = privateKeyRef;
}


#pragma mark - Encrypt
-(NSString*) rsaEncryptString:(NSString*)string {
    NSData* data = [string dataUsingEncoding:NSUTF8StringEncoding];
    NSData* encryptedData = [self rsaEncryptData: data];
    NSString* base64EncryptedString = [encryptedData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    return base64EncryptedString;
}

// 加密的大小受限于SecKeyEncrypt函数，SecKeyEncrypt要求明文和密钥的长度一致，如果要加密更长的内容，需要把内容按密钥长度分成多份，然后多次调用SecKeyEncrypt来实现
-(NSData*) rsaEncryptData:(NSData*)data {
    SecKeyRef key = [self getPublicKey];
    size_t cipherBufferSize = SecKeyGetBlockSize(key);
    uint8_t *cipherBuffer = malloc(cipherBufferSize * sizeof(uint8_t));
    size_t blockSize = cipherBufferSize - 11;       // 分段加密
    size_t blockCount = (size_t)ceil([data length] / (double)blockSize);
    NSMutableData *encryptedData = [[NSMutableData alloc] init] ;
    for (int i=0; i<blockCount; i++) {
        unsigned long bufferSize = MIN(blockSize,[data length] - i * blockSize);
        NSData *buffer = [data subdataWithRange:NSMakeRange(i * blockSize, bufferSize)];
        OSStatus status = SecKeyEncrypt(key, kSecPaddingPKCS1, (const uint8_t *)[buffer bytes], [buffer length], cipherBuffer, &cipherBufferSize);
        if (status == noErr){
            NSData *encryptedBytes = [[NSData alloc] initWithBytes:(const void *)cipherBuffer length:cipherBufferSize];
            [encryptedData appendData:encryptedBytes];
        }else{
            if (cipherBuffer) {
                free(cipherBuffer);
            }
            return nil;
        }
    }
    if (cipherBuffer){
        free(cipherBuffer);
    }
    return encryptedData;
}


#pragma mark - Decrypt
-(NSString*) rsaDecryptString:(NSString*)string {
    NSData* data = [[NSData alloc] initWithBase64EncodedString:string options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSData* decryptData = [self rsaDecryptData: data];
    NSString* result = [[NSString alloc] initWithData: decryptData encoding:NSUTF8StringEncoding];
    return result;
}

-(NSData*) rsaDecryptData:(NSData*)data {
    SecKeyRef key = [self getPrivateKey];
    size_t cipherLen = [data length];
    void *cipher = malloc(cipherLen);
    [data getBytes:cipher length:cipherLen];
    size_t plainLen = SecKeyGetBlockSize(key) - 12;
    void *plain = malloc(plainLen);
    OSStatus status = SecKeyDecrypt(key, kSecPaddingPKCS1, cipher, cipherLen, plain, &plainLen);
    if (status != noErr) {
        return nil;
    }
    NSData *decryptedData = [[NSData alloc] initWithBytes:(const void *)plain length:plainLen];
    return decryptedData;
}


#pragma mark --Sign
- (NSData *)rsaSHA256SignData:(NSData *)data {
    SecKeyRef key = [self getPrivateKey];
    
    size_t signedHashBytesSize = SecKeyGetBlockSize(key);
    uint8_t* signedHashBytes = malloc(signedHashBytesSize);
    memset(signedHashBytes, 0x0, signedHashBytesSize);
    
    size_t hashBytesSize = CC_SHA256_DIGEST_LENGTH;
    uint8_t* hashBytes = malloc(hashBytesSize);
    if (!CC_SHA256([data bytes], (CC_LONG)[data length], hashBytes)) {
        return nil;
    }
    
    SecKeyRawSign(key,
                  kSecPaddingPKCS1SHA256,
                  hashBytes,
                  hashBytesSize,
                  signedHashBytes,
                  &signedHashBytesSize);
    
    NSData* signedHash = [NSData dataWithBytes:signedHashBytes
                                        length:(NSUInteger)signedHashBytesSize];
    
    if (hashBytes)
        free(hashBytes);
    if (signedHashBytes)
        free(signedHashBytes);
    
    return signedHash;
}


#pragma mark --Verify
- (BOOL)rsaSHA256VerifyData:(NSData *)data Signature:(NSData *)signature {
    SecKeyRef key = [self getPublicKey];
    
    size_t signedHashBytesSize = SecKeyGetBlockSize(key);
    const void* signedHashBytes = [signature bytes];
    
    size_t hashBytesSize = CC_SHA256_DIGEST_LENGTH;
    uint8_t* hashBytes = malloc(hashBytesSize);
    if (!CC_SHA256([data bytes], (CC_LONG)[data length], hashBytes)) {
        return NO;
    }
    
    OSStatus status = SecKeyRawVerify(key,
                                      kSecPaddingPKCS1SHA256,
                                      hashBytes,
                                      hashBytesSize,
                                      signedHashBytes,
                                      signedHashBytesSize);
    
    return status == errSecSuccess;
}

@end
