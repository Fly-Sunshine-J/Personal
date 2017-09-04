//
//  BaseViewController.m
//  消息转发
//
//  Created by vcyber on 17/9/4.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import "BaseViewController.h"
#import "AppDelegate.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setBackgroundColor {
    self.view.backgroundColor = [UIColor redColor];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    if (aSelector == NSSelectorFromString(@"changeColor")) {
        return [NSMethodSignature signatureWithObjCTypes:"v@:"];
    }
    return [super methodSignatureForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    if (anInvocation.selector == NSSelectorFromString(@"changeColor")) {
        AppDelegate *delgate = (AppDelegate *)[UIApplication sharedApplication].delegate;
        for (BaseViewController *c in delgate.targets) {
            [c setBackgroundColor];
        }
    }else {
        [super forwardInvocation:anInvocation];
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
