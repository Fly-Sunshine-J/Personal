//
//  MyLayout.m
//  Record
//
//  Created by vcyber on 16/12/29.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "MyLayout.h"

@implementation MyLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return self;
}

@end
