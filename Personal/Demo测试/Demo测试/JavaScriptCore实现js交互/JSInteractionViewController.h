//
//  JSInteractionViewController.h
//  Demo测试
//
//  Created by vcyber on 16/7/5.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "BaseViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>

@protocol JSInteractionDelegate <JSExport>

JSExportAs(share, - (void)share:(NSString *)shareContent);

@end

@interface JSInteractionViewController : BaseViewController

@end
