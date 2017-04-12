//
//  DemoSourceViewController.m
//  Demo测试
//
//  Created by vcyber on 16/6/27.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "DemoSourceViewController.h"

@interface DemoSourceViewController ()

@end

@implementation DemoSourceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:self.view.bounds];
    NSURL *url = [[NSBundle mainBundle] URLForResource:self.fileName withExtension:@"txt"];
    textView.editable = NO;
    [textView setText:[NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil]];
    [self.view addSubview:textView];
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
