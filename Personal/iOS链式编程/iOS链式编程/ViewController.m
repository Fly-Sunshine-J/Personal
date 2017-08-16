//
//  ViewController.m
//  iOS链式编程
//
//  Created by vcyber on 17/8/16.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+MyButton.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    __block int count = 0;
    [[UIButton alloc] initWithFrame:CGRectMake(100, 100, 100, 40)].FS_BackgroundColor([UIColor greenColor]).FS_AddTargetBlock(^(UIButton *button) {
        if (count++ % 2 == 0) {
            button.FS_BackgroundColor([UIColor greenColor]);
        }else {
            button.FS_BackgroundColor([UIColor redColor]);
        }
        
    }, UIControlEventTouchUpInside).FS_AddInView(self.view);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
