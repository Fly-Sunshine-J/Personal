//
//  ComicCategoryVC.m
//  ComicAndPicture
//
//  Created by MS on 16/3/15.
//  Copyright © 2016年 JFY. All rights reserved.
//

#import "ComicCategoryVC.h"

@interface ComicCategoryVC ()

@end

@implementation ComicCategoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    [self createNavBar];
    
    [self createDataWithURL:[NSString stringWithFormat:CATEGORY_CLICK_URL, self.page, self.categoryId]];
    
    [self createRefresh];
    
    self.tableView.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
    
}


- (void)createNavBar {
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    leftBtn.frame = CGRectMake(0, 0, 30, 30);
    
    [leftBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    
    [leftBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    
}


- (void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)viewWillAppear:(BOOL)animated {
    
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:143 / 255.0 green:119 / 255.0 blue:181 / 255.0 alpha:1];
    
    self.navigationController.navigationBarHidden = NO;
    
    self.tabBarController.tabBar.hidden = YES;
}


- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    
    self.tabBarController.tabBar.hidden = NO;
    
}

- (void)refresh {
    
    self.page = 1;
    
    self.isPulling = YES;
    
    [self createDataWithURL:[NSString stringWithFormat:CATEGORY_CLICK_URL, self.page, self.categoryId]];
    
}


- (void)getMore {
    
    self.page++;
    
    self.isPulling = NO;
    
    [self createDataWithURL:[NSString stringWithFormat:CATEGORY_CLICK_URL, self.page, self.categoryId]];
    
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
