//
//  PPSAppDelegate.m
//  PPSSignatureDemo
//
//  Created by Jason Harwig on 12/30/13.
//  Copyright (c) 2013 Jason Harwig. All rights reserved.
//

#import "PPSAppDelegate.h"
#import "PPSSignatureView.h"

@implementation PPSAppDelegate


// utf8 -> gbk
- (char *)utf8ToGbk:(NSString *)string
{
    NSStringEncoding encoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSLog(@"%lx",(unsigned long)encoding);
    return  (char *)[string cStringUsingEncoding:encoding];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    return YES;
}


@end
