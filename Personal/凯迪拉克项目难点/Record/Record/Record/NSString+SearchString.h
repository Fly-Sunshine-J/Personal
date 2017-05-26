//
//  NSString+SearchString.h
//  Record
//
//  Created by vcyber on 17/5/5.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SearchString)

- (NSMutableArray<NSString *> *)searchResult:(NSString *)searchString;

@end
