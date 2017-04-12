//
//  ViewController.m
//  自定义抽屉
//
//  Created by vcyber on 16/6/7.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "ViewController.h"
#import "boxViewController.h"
#import "UIColor+ColorToImage.h"
#import "UIButton+BtnClick.h"

@interface ViewController ()
@property (nonatomic, assign) BOOL change;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(100, 100, 100, 40);
    [btn setTitle:@"点击" forState:UIControlStateNormal];
    [btn BtnClickWithAction:^{
        
        NSLog(@"click");
        
    } event:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    [self.view addSubview:btn];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!_change) {
        [self.navigationController.navigationBar setBackgroundImage:[[UIColor cyanColor] transformToImage] forBarMetrics:UIBarMetricsDefault];
    }else {
        
        [self.navigationController.navigationBar setBackgroundImage:[[UIColor clearColor] transformToImage] forBarMetrics:UIBarMetricsDefault];
        [self.navigationController.navigationBar setBackIndicatorTransitionMaskImage:[[UIColor clearColor] transformToImage]];
        [self.navigationController.navigationBar setShadowImage:[[UIColor clearColor] transformToImage]];
    }
    
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.translucent = YES;
    
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
//    boxViewController *box = [[boxViewController alloc] init];
//    [box showWithComeFromType:ModalViewControlComeFromRight];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
