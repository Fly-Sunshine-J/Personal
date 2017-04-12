//
//  ViewController.m
//  JSPatch
//
//  Created by vcyber on 17/1/22.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@property (nonatomic, strong) NSString *titleText;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (void)setTitleText:(NSString *)titleText {
    self.title  = titleText;
    
}

- (IBAction)push:(UIButton *)sender {
    NSLog(@"调用未覆盖前OC中的方法");
    [ViewController instanceMethod];
}

+ (void)instanceMethod {
    NSLog(@"未覆盖前OC类方法");
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
