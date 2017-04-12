//
//  PictureViewController.m
//  ComicAndPicture
//
//  Created by MS on 16/3/3.
//  Copyright © 2016年 JFY. All rights reserved.
//

#import "PictureViewController.h"
#import "NewestViewController.h"
#import "FKViewController.h"
#import "JPViewController.h"

@interface PictureViewController ()

@end

@implementation PictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createTitleBar];
    
    [self createAllViewController];
    
}


- (void)createAllViewController {
    
    NewestViewController *newest = [[NewestViewController alloc] init];
    newest.title = @"最新";
    newest.url = ZX_URL;
    newest.categoryId = @"164";
    
    FKViewController *fk = [[FKViewController alloc] init];
    fk.title = @"番库";
    fk.url = FK_URL;
    
    JPViewController *jp = [[JPViewController alloc] init];
    jp.title = @"精品";
    jp.url = JP_URL;
    jp.categoryId = @"164";
    
    [self addChildViewController:newest];
    
    [self addChildViewController:fk];
    
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
