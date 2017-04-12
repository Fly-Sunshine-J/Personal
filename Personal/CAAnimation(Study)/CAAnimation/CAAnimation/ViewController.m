//
//  ViewController.m
//  CAAnimation
//
//  Created by vcyber on 16/5/13.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "ViewController.h"
#import "BaseViewController.h"

@interface ViewController ()<CAAnimationDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *url = [[NSBundle mainBundle] URLForResource:@"曲婉婷-Jar Of Love.mp3" withExtension:nil];
    NSLog(@"%@", url);
    
}


- (IBAction)push2Base:(id)sender {
    BaseViewController *base = [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"Base"];
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.3;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    transition.type = @"cube";
    transition.subtype = kCATransitionFromTop;
    transition.delegate = self;
    [self.navigationController.view.layer addAnimation:transition forKey:@"push"];
    [self.navigationController pushViewController:base animated:NO];
    

}

- (void)animationDidStart:(CAAnimation *)anim {
    
    NSLog(@"Start");
}


- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    
    NSLog(@"Stop");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
