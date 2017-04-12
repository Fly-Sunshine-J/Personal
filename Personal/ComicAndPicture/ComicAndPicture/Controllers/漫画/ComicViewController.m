//
//  ComicViewController.m
//  ComicAndPicture
//
//  Created by MS on 16/3/3.
//  Copyright © 2016年 JFY. All rights reserved.
//

#import "ComicViewController.h"
#import "RPViewController.h"
#import "XZViewController.h"
#import "TJViewController.h"
#import "SearchViewController.h"
#import "UpdateViewController.h"

@interface ComicViewController ()

@end

@implementation ComicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createTitleBar];
    
    [self createAllViewController];
    
}



- (void)createAllViewController {
    
    TJViewController *tj = [[TJViewController alloc] init];
    tj.title = @"推荐";
    tj.urlString = TJ_URL;
    
    RPViewController *rp = [[RPViewController alloc] init];
    rp.title = @"热评";
    rp.urlString = RP_URL;
    
    XZViewController *xz = [[XZViewController alloc] init];
    xz.title = @"新作";
    xz.urlString = XZ_URL;
    
    UpdateViewController *update = [[UpdateViewController alloc] init];
    update.title = @"更新";
    update.urlString = GX_URL;
    
    SearchViewController *cSearch = [[SearchViewController alloc] init];
    cSearch.title = @"搜索";
    cSearch.urlString = SS_URL;
    
    [self addChildViewController:tj];
    
    [self addChildViewController:rp];
    
    [self addChildViewController:xz];
    
    [self addChildViewController:update];
    
    [self addChildViewController:cSearch];
    
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
