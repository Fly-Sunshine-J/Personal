//
//  NSObject+FSKVO.h
//  Runtime
//
//  Created by vcyber on 17/8/23.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (FSKVO)

- (void)fs_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context;

@end
