//
//  ViewController.m
//  AssistiViewTouch
//
//  Created by vcyber on 16/5/26.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "ViewController.h"
#import "AssistViewTouch.h"
#import "MyButton.h"

@interface ViewController ()<AssistViewTouchDelegate>
@property (nonatomic, strong) UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *viewa = [[UIView alloc] initWithFrame:CGRectMake(50, 100, SCREEN_WIDTH - 100, SCREEN_HEIGHT - 200)];
    viewa.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:viewa];
    
    AssistViewTouch *view = [[AssistViewTouch alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    view.delegate = self;
    [view addAssistViewInSuperView:self.view];
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(100, 20, 100, 70)];
    view1.center = self.view.center;
    view1.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:view1];
    
    MyButton *btn = [MyButton buttonWithType:UIButtonTypeSystem];
    btn.frame = CGRectMake(20, 20, 60, 30);
    [btn setBackgroundColor:[UIColor redColor]];
    btn.eventSize = CGSizeMake(100, 70); 
    [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
    [view1 addSubview:btn];
//
//    NSLog(@"%@\n%@", NSStringFromCGRect(view1.frame), NSStringFromCGRect(btn.frame));

//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
//    btn.frame = CGRectMake(0, 0, 50, 50);
//    btn.center = view2.center;
//    btn.backgroundColor = [UIColor redColor];
//    [view2 addSubview:btn];
//    
}

- (void)click:(UIButton *)btn {
    
    NSLog(@"%@", _textField.text);
}


- (CGRect)limitRectOfAssistView:(AssistViewTouch *)assistV {
    
    return CGRectMake(50, 100, SCREEN_WIDTH - 100, SCREEN_HEIGHT - 200);
}

- (void)touchAssistView:(AssistViewTouch *)assistV {
    
    NSLog(@"touch");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
