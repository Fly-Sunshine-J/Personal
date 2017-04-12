//
//  AdView.h
//  启动页加载广告页面
//
//  Created by vcyber on 16/6/7.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kscreenWidth [UIScreen mainScreen].bounds.size.width
#define kscreenHeight [UIScreen mainScreen].bounds.size.height
#define kUserDefaults [NSUserDefaults standardUserDefaults]
static NSString *const adImageName = @"adImageName";
static NSString *const adUrl = @"adUrl";

@interface AdView : UIView

@property (nonatomic, strong)NSString *filePath;

- (void)show;

@end
