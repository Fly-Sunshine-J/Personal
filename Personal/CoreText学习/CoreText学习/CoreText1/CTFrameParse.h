//
//  CTFrameParse.h
//  CoreText学习
//
//  Created by vcyber on 17/8/30.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreTextData.h"
#import "CTFrameConfig.h"

@interface CTFrameParse : NSObject

+ (NSMutableDictionary *)attributesWithConfig:(CTFrameConfig *)config;

+ (CoreTextData *)parseContent:(NSAttributedString *)content config:(CTFrameConfig *)config;

+ (CoreTextData *)parseTemplateFile:(NSString *)path config:(CTFrameConfig *)config;

@end
