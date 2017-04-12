//
//  MainViewController.m
//  ComicAndPicture
//
//  Created by MS on 16/3/9.
//  Copyright © 2016年 JFY. All rights reserved.
//

#import "MainViewController.h"



@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (void)createTitleBar {
    
    //设置整体的内容尺寸
    [self setUpContentViewFrame:^(UIView *contentView) {
        
        CGFloat contentX = 0;
        
        CGFloat ContentY = 20;
        
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
