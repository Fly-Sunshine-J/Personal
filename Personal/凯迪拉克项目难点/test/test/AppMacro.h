//
//  AppMacro.h
//  Cadillac
//
//  Created by vcyber on 17/1/13.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#ifndef AppMacro_h
#define AppMacro_h

//define this constant if you want to use Masonry without the 'mas_' prefix
#define MAS_SHORTHAND

//define this constant if you want to enable auto-boxing for default syntax
#define MAS_SHORTHAND_GLOBALS


#define Debug

#ifdef Debug
#define CLog(fmt, ...) \
\
NSLog(@"%s [Line %d] " fmt, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__); \

#define CPrint(format, ...) printf(format, ##__VA_ARGS__)

//http://192.168.6.46:8091/vcyber-cadillac/api/ //李春前
//http://111.200.239.209:3333/v-c/api/  //线上
//http://192.168.3.39:8080/vcyber-cadillac/api/  赵晶微

#define API_URL  @"http://111.200.239.209:3333/v-c/api/"   //测试地址
#define QRCODE_URL @"http://kdlkwxtest.vcyber.com/kdlk/weixin/qrcode"   //测试二维码地址

#else

#define CLog(...);
#define CPrint(format, ...)

#define API_URL  @""   //正式地址

#endif

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

#define CColor(color) [UIColor colorWithHexString:color]
#define RGBColor(r, g, b) [UIColor colorWithRed:r / 255.0 green:g / 255.0 blue:b / 255.0 alpha:1]
#define MAIN_COLOR  RGBColor(243, 243, 243) //主色调

#define CFont(fontSize) [UIFont systemFontOfSize:fontSize]
#define NORMAL_FONT CFont(12)

#define CImage(imageName) [UIImage imageNamed:imageName]



#define FitRealValue(value) ((value)/414.0f*[UIScreen mainScreen].bounds.size.width)
#define FitHeightValue(value) ((value)/736.0f*[UIScreen mainScreen].bounds.size.height)


//判断iPhone/iPad
#define iPhone [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone

#endif /* AppMacro_h */
