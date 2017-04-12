//
//  ViewController.m
//  CAAnimation-转场动画
//
//  Created by vcyber on 16/5/24.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    
    UIView *_demoView;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _demoView = [[UIView alloc] initWithFrame:self.view.bounds];
    [_demoView setBackgroundColor:[UIColor redColor]];
    [self.view addSubview:_demoView];
    
//    增加手势
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [_demoView addGestureRecognizer:swipeLeft];
    
    UISwipeGestureRecognizer *swipeRight = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeAction:)];
    swipeRight.direction = UISwipeGestureRecognizerDirectionRight;
    [_demoView addGestureRecognizer:swipeRight];
}

- (void)swipeAction:(UISwipeGestureRecognizer *)sender {
    
    if (_demoView.tag == 0) {
        _demoView.backgroundColor = [UIColor blueColor];
        _demoView.tag = 1;
    }else {
        
        _demoView.backgroundColor = [UIColor redColor];
        _demoView.tag = 0;
    }
    
    //转场动画
    CATransition *transition = [CATransition animation];
    //设置动画的过渡类型
    transition.type = @"cube";
    //根据手势的方向决定动画的方向
    if (sender.direction ==UISwipeGestureRecognizerDirectionLeft) {
        transition.subtype = kCATransitionFromRight;
    }else {
        
        transition.subtype = kCATransitionFromLeft;
    }
    [_demoView.layer addAnimation:transition forKey:nil];
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 10, self.view.frame.size.width, 30);
    [btn setTitle:@"Dismiss" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
}


- (void)dismiss {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(modalViewControllerDidClickedDismissBtn:)]) {
        [self.delegate modalViewControllerDidClickedDismissBtn:self];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
