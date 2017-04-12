//
//  SecondViewController.h
//  JSPatch
//
//  Created by vcyber on 17/1/22.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController

@property (nonatomic, copy) void(^callBack)(NSString *);

@end
