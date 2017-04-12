//
//  NextViewController.m
//  运行时改变字体大小
//
//  Created by vcyber on 16/8/19.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "NextViewController.h"

@interface NextViewController ()

@end

@implementation NextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UISlider *slide = [[UISlider alloc] initWithFrame:CGRectMake(40, 200, 200, 20)];
    slide.value = [[[NSUserDefaults standardUserDefaults] valueForKey:@"fontsize"] floatValue] - 1;
    slide.maximumValue = 1.0;
    slide.minimumValue = 0.0;
    [slide addTarget:self action:@selector(change:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:slide];
    
}


- (void)change:(UISlider *)slide {
    
    [[NSUserDefaults standardUserDefaults] setValue:@(slide.value + 1) forKey:@"fontsize"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeTextSize" object:nil userInfo:@{@"size":@(slide.value + 1)}];
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
