//
//  CoreTextData.h
//  CoreText学习
//
//  Created by vcyber on 17/8/30.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>
#import "CoreTextImageData.h"
#import "CoreTextLinkData.h"

@interface CoreTextData : NSObject

@property (nonatomic, assign) CTFrameRef ctFrame;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, strong) NSArray <CoreTextImageData *> *images;
@property (nonatomic, strong) NSArray <CoreTextLinkData *> *links;

@end
