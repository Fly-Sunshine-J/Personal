//
//  JFYSoundEffect.h
//  StreamMedia(Study)
//
//  Created by vcyber on 16/5/4.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface JFYSoundEffect : NSObject

+ (instancetype)shareSoundEffect;

- (void)playSoundEffect:(NSString *)soundName;

@end
