//
//  PictureCategoryVC.m
//  ComicAndPicture
//
//  Created by MS on 16/3/12.
//  Copyright © 2016年 JFY. All rights reserved.
//

#import "PictureCategoryVC.h"
#import "NewestViewController.h"
#import "JPViewController.h"

@interface PictureCategoryVC ()

@end

@implementation PictureCategoryVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    [self createNavBar];
    
    [self createTitleBar];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createAllViewController];
    
}

- (void)createTitleBar {
    
    //设置整体的内容尺寸
    [self setUpContentViewFrame:^(UIView *contentView) {
        
        CGFloat contentX = 0;
        
        CGFloat ContentY = 64;
        
        CGFloat contentH = HEIGHT;
        
        contentView.frame = CGRectMake(contentX, ContentY, WIDTH, contentH);
        
        contentView.backgroundColor = [UIColor colorWithRed:241 / 255.0 green:158 / 255.0 blue:194 / 255.0 alpha:1];
        
    }];
    
    //设置标题渐变
    [self setUpTitleGradient:^(BOOL *isShowTitleGradient, YZTitleColorGradientStyle *titleColorGradientStyle, CGFloat *startR, CGFloat *startG, CGFloat *startB, CGFloat *endR, CGFloat *endG, CGFloat *endB) {
        
        *isShowTitleGradient = YES;
        
        *endR = 1;
        
        *endG = 0;
        
        *endB = 1;
        
    }];
    
    //设置遮盖
    [self setUpCoverEffect:^(BOOL *isShowTitleCover, UIColor *__autoreleasing *coverColor, CGFloat *coverCornerRadius) {
        
        *isShowTitleCover = YES;
        
        *coverColor = [UIColor colorWithWhite:0.7 alpha:0.4];
        
        *coverCornerRadius = 10;
        
    }];
    
    
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

- (void)createAllViewController {
    
    NewestViewController *newest = [[NewestViewController alloc] init];
    newest.title = @"最新";
    newest.url = ZX_URL;
    newest.categoryId = self.categoryId;
    
    JPViewController *jp = [[JPViewController alloc] init];
    jp.title = @"精品";
    jp.url = JP_URL;
    jp.categoryId = self.categoryId;
    
    [self addChildViewController:newest];
    
    [self addChildViewController:jp];
    
    
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
