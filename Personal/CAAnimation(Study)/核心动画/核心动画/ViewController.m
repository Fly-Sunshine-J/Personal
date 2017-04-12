//
//  ViewController.m
//  核心动画
//
//  Created by vcyber on 16/12/20.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UILabel *testLabel;
@property (nonatomic, strong) SecondViewController *second;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _testLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
    [self.view addSubview:_testLabel];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    _second = [[SecondViewController alloc] init];
    _second.block = ^(UIColor *color) {
        self.testLabel.backgroundColor = color;
    };
    [self.navigationController pushViewController:_second animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
