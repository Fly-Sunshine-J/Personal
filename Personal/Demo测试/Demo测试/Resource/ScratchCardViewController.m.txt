//
//  ScratchCardViewController.m
//  Demo测试
//
//  Created by vcyber on 16/7/6.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "ScratchCardViewController.h"
#import "ScratchView.h"

@interface ScratchCardViewController ()

@end

@implementation ScratchCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 100, 200, 200)];
//    imageView.center = self.view.center;
    imageView.image = [UIImage imageNamed:@"scratch_bg"];
    [self.view addSubview:imageView];
    
    NSArray *array = @[@"很遗憾,你未中奖!", @"恭喜你,抽中iPad!", @"恭喜你, 抽中iPhone6s!", @"恭喜你,抽中Mac Pro!"];
    ScratchView *view = [[ScratchView alloc] initWithFrame:CGRectMake(50, 100, 200, 200)];
    view.center = imageView.center;
    view.text = array[arc4random() % 4];
    [self.view addSubview:view];
    
    self.SourceArray = [NSMutableArray arrayWithObjects:@[@"ScratchView.h", @"DemoSourceViewController"], @[@"ScratchView.m", @"DemoSourceViewController"], @[@"ScratchCardViewController.h", @"DemoSourceViewController"], @[@"ScratchCardViewController.m", @"DemoSourceViewController"], nil];
    
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
