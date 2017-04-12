//
//  RootViewController.m
//  ComicAndPicture
//
//  Created by MS on 16/3/3.
//  Copyright © 2016年 JFY. All rights reserved.
//

#import "RootViewController.h"
//漫画
#import "ComicViewController.h"

//漫图
#import "PictureViewController.h"

//排行
#import "TopViewController.h"

//分类
#import "CategoryViewController.h"

//我的
#import "MeViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tabBar.barTintColor = [UIColor colorWithRed:233 / 255.0 green:235 / 255.0 blue:254 / 255.0 alpha:1];
    
    self.tabBar.tintColor = [UIColor colorWithRed:181 / 255.0 green:229 / 255.0 blue:181 / 255.0 alpha:1];
    
    [self createViewControllers];

}


- (void)createViewControllers {

    NSArray *titleArray = @[@"漫画", @"图片", @"排行", @"分类", @"我的"];
    
    NSArray *imageArray = @[@"TabBarItemComic", @"TabBarItemPicture", @"TabBarItemTop", @"TabBarCategory", @"TabBarItemMe"];
    
    NSMutableArray *viewControllers = [NSMutableArray arrayWithObjects:@"ComicViewController", @"PictureViewController", @"TopViewController", @"CategoryViewController", @"MeViewController", nil];
    
    for (int i = 0; i < titleArray.count; i++) {
        
        Class class = NSClassFromString(viewControllers[i]);
        
        UIViewController *viewController = [[class alloc] init];
        
        viewController.tabBarItem.title = titleArray[i];
        
        viewController.tabBarItem.image = [UIImage imageNamed:imageArray[i]];
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:viewController];
        
        viewController.navigationController.navigationBarHidden = YES;
        
        [viewControllers replaceObjectAtIndex:i withObject:nav];
        
        
    }
    
    self.viewControllers = viewControllers;
    
    
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
