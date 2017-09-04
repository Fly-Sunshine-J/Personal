//
//  CTFrameConfig.h
//  CoreText学习
//
//  Created by vcyber on 17/8/30.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//绘制参数的配置  文字颜色 大小  行间距等
@interface CTFrameConfig : NSObject

@property (nonatomic, assign) CGFloat width;        ///区域宽度
@property (nonatomic, assign) CGFloat fontSize;     ///文字大小
@property (nonatomic, assign) CGFloat lineSpace;    ///行间距
@property (nonatomic, assign) UIColor *textColor;   ///文字颜色

@end
