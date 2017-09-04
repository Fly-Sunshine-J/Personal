//
//  CTFrameConfig.m
//  CoreText学习
//
//  Created by vcyber on 17/8/30.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import "CTFrameConfig.h"

@implementation CTFrameConfig

- (instancetype)init
{
    self = [super init];
    if (self) {
        _width = 200.0f;
        _fontSize = 17.0f;
        _lineSpace = 10.0f;
        _textColor = [UIColor blackColor];
    }
    return self;
}

@end
