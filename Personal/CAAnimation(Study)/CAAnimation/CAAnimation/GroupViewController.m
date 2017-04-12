//
//  GroupViewController.m
//  CAAnimation
//
//  Created by vcyber on 16/5/13.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "GroupViewController.h"

@interface GroupViewController ()
@property (nonatomic, strong) UIView *view1;
@property (nonatomic, strong) UIView *view2;

@end

@implementation GroupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(100, 200, 100, 100)];
    view1.backgroundColor = [UIColor redColor];
    [self.view addSubview:view1];
    view1.layer.anchorPoint = CGPointMake(1, 1);
    view1.hidden = YES;
    _view1 = view1;
    
    UIView *view2 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
//    view2.layer.position = CGPointMake(50, 50);
    view2.backgroundColor = [UIColor yellowColor];
    [view1 addSubview:view2];
    _view2 = view2;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _view1.hidden = NO;
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.duration = 0.5;
    animation.keyPath = @"transform.scale";
    animation.fromValue = [NSNumber numberWithFloat:0.0];
    animation.toValue = [NSNumber numberWithFloat:1.0];
    animation.removedOnCompletion = NO;
    
    //保持最新的状态
    animation.fillMode= kCAFillModeForwards;
    [_view1.layer addAnimation:animation forKey:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
