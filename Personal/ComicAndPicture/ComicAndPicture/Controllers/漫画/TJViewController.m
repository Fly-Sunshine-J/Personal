//
//  TJViewController.m
//  ComicAndPicture
//
//  Created by MS on 16/3/3.
//  Copyright © 2016年 JFY. All rights reserved.
//

#import "TJViewController.h"

@interface TJViewController ()

@end

@implementation TJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
   [self createDataWithURL:[NSString stringWithFormat:self.urlString, self.page]];    
    [self createRefresh];
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
