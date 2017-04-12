//
//  CategoryViewController.m
//  ComicAndPicture
//
//  Created by MS on 16/3/3.
//  Copyright © 2016年 JFY. All rights reserved.
//

#import "CategoryViewController.h"
#import "CComicViewController.h"
#import "CPictureViewController.h"

@interface CategoryViewController ()

@end

@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createTitleBar];
    
    [self createAllViewController];
}


- (void)createAllViewController {
    
    CComicViewController *comic = [[CComicViewController alloc] init];
    comic.title = @"漫画分类";
    
    CPictureViewController *picture = [[CPictureViewController alloc] init];
    picture.title = @"图片分类";

    [self addChildViewController:comic];
    
    [self addChildViewController:picture];
    
    
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
