//
//  ViewController.m
//  JPushTest
//
//  Created by vcyber on 16/5/25.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "ViewController.h"
#import "JPUSHService.h"
#import "TestViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    
    [JPUSHService setAlias:@"Fly_Sunshine_J" callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:self];
}

- (IBAction)sendLocalMessage:(id)sender {
#if TARGET_IPHONE_SIMULATOR//模拟器
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Title" message:@"Message" preferredStyle:UIAlertControllerStyleActionSheet];
    alert.view.tintColor = [UIColor redColor];

    UIAlertAction *action = [UIAlertAction actionWithTitle:@"Action1" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSLog(@"action1");
        
    }];
    [alert addAction:action];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
        
    }];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];
    
//    for (UIView *view1 in alert.view.subviews) {
//        NSLog(@"view1%@", NSStringFromClass([view1 class]));
//        view1.backgroundColor = [UIColor blueColor];
//        for (UIView *view2 in view1.subviews) {
//            NSLog(@"view2%@", NSStringFromClass([view2 class]));
//            view2.backgroundColor = [UIColor redColor];
//            for (UIView *view3 in view2.subviews) {
//                NSLog(@"view3%@", NSStringFromClass([view3 class]));
//                view3.backgroundColor = [UIColor yellowColor];
//                for (UIView *view4 in view3.subviews) {
//                    NSLog(@"view4%@", NSStringFromClass([view4 class]));
//                    view4.backgroundColor = [UIColor greenColor];
//                    if ([view4 isKindOfClass:[UIImageView class]]) {
//                        view4.backgroundColor = [UIColor cyanColor];
//                    }
//                }
//            }
//        }
//    }
    
#elif TARGET_OS_IPHONE//真机
    [JPUSHService setLocalNotification:[NSDate dateWithTimeIntervalSinceNow:10] alertBody:@"AlertBody" badge:1 alertAction:@"打开" identifierKey:@"identifierKey" userInfo:nil soundName:nil];
#endif
    

}

-(void)tagsAliasCallback:(int)iResCode
                    tags:(NSSet*)tags
                   alias:(NSString*)alias
{
    NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
