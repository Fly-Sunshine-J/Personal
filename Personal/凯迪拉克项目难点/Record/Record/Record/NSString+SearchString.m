//
//  NSString+SearchString.m
//  Record
//
//  Created by vcyber on 17/5/5.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import "NSString+SearchString.h"

@implementation NSString (SearchString)

- (NSMutableArray<NSString *> *)searchResult:(NSString *)searchString {
    NSMutableArray *rangeArray = [NSMutableArray array];

    NSRange searchRange = NSMakeRange(0, self.length);
    do {
        NSRange range = [self rangeOfString:searchString options:NSCaseInsensitiveSearch range:searchRange];
        if (range.location != NSNotFound) {
            searchRange = NSMakeRange(range.location + range.length - 1, self.length - range.location - range.length);
            NSString *rangeString = NSStringFromRange(range);
            [rangeArray addObject:rangeString];
        }else {
            break;
        }
    } while (YES);
    
    return rangeArray;
}

@end
