//
//  MRTestHeader.h
//  MRTest
//
//  Created by vcyber on 16/5/30.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#ifndef MRTestHeader_h
#define MRTestHeader_h
#import <Foundation/Foundation.h>

#define LogControl 1

#if LogControl
#define VcyberLog(fmt,...) \
\
NSLog(@"%s [Line %d]" fmt, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__); \

#   define DPrint(format, ...) printf(format, ##__VA_ARGS__)

#else
#define VcyberLog(...);
#define Dprint(format, ...);
#endif

#endif /* MRTestHeader_h */
