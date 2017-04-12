//
//  ShowViewController.m
//  ComicAndPicture
//
//  Created by MS on 16/3/11.
//  Copyright © 2016年 JFY. All rights reserved.
//

#import "ShowViewController.h"

@interface ShowViewController ()
@end

@implementation ShowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self createData];
    
    [self createControls];
    
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
