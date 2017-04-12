//
//  NextViewController.h
//  aaa
//
//  Created by vcyber on 16/7/4.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol JSObjcDelegate <JSExport>

JSExportAs(share, - (void)share:(NSString *)shareContent);

@end

@interface NextViewController : UIViewController<JSObjcDelegate>

@end
