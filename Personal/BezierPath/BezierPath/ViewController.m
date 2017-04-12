//
//  ViewController.m
//  BezierPath
//
//  Created by vcyber on 16/6/22.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "ViewController.h"
#import "AnimationView.h"

@interface ViewController ()<AnimationViewDelegate>
@property (nonatomic, strong) AnimationView *animationView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor purpleColor];
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    CGFloat size = 100.0;
    self.animationView = [[AnimationView alloc] initWithFrame:CGRectMake(CGRectGetWidth(self.view.frame)/2 - size/2, CGRectGetHeight(self.view.frame)/2 - size/2, size, size)];
        _animationView.delegate = self;
    for (UIView *view in self.view.subviews) {
        if ([view isKindOfClass:[AnimationView class]]) {
            [view removeFromSuperview];
        }
    }
    [self.view addSubview:_animationView];
}

- (void)completeAnimation {
    
    UILabel *label = [[UILabel alloc] initWithFrame:self.view.frame];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"Welcome";
    label.font = [UIFont fontWithName:@"HelveticaNeue-Thin" size:50.0];
    label.transform = CGAffineTransformScale(label.transform, 0.25, 0.25);
    [self.view addSubview:label];
    
    [UIView animateWithDuration:0.4 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        label.transform = CGAffineTransformScale(label.transform, 4, 4);
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
