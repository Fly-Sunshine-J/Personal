//
//  DetailViewController.m
//  Demo测试
//
//  Created by vcyber on 16/7/7.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "DetailViewController.h"
#import "global.h"


@interface DetailViewController ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    self.imageView.center = self.view.center;
    [self.view addSubview:self.imageView];
}


- (void)setItem:(NSDictionary *)item {
    
    _item = item;
    self.view.backgroundColor = [UIColor colorWithRed:[item[@"colors"][0] floatValue] / 255.0 green:[item[@"colors"][1] floatValue] / 255.0 blue:[item[@"colors"][2] floatValue] / 255.0 alpha:1];
    self.imageView.image = [UIImage imageNamed:item[@"bigImage"]];
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
