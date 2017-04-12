//
//  ViewController.m
//  NavTest
//
//  Created by vcyber on 16/6/2.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "ViewController.h"
#import "SearchView.h"
#import "HeadImageView.h"

@interface ViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong)HeadImageView *headView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeAll;//允许上下扩从
    self.extendedLayoutIncludesOpaqueBars = NO;//允许扩展到透明的导航栏下面
    self.modalPresentationCapturesStatusBarAppearance = NO;
    
    //不设置会自动调用scrollView的代理方法
    self.automaticallyAdjustsScrollViewInsets = NO;  //设置scrollview延伸

    
    self.view.backgroundColor = [UIColor whiteColor];
    UIScrollView *sc = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    sc.backgroundColor = [UIColor yellowColor];
    sc.contentSize = CGSizeMake(self.view.frame.size.width, 1000);
    sc.delegate = self;
    [self.view addSubview:sc];
    
    _headView = [[HeadImageView alloc] initWithFrame:CGRectZero Image:[UIImage imageNamed:@"userCenterBgimage"]];
    [self.view addSubview:_headView];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.y > 0) {
        _headView.frame = CGRectMake(0, -scrollView.contentOffset.y, _headView.frame.size.width, _headView.frame.size.width);
        return;
    }
    
    CGFloat change = scrollView.contentOffset.y - _headView.frame.origin.y;
    if (change < 0) {
        _headView.scale = ABS(change / 100);
    }
    
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"barBg"] forBarMetrics:UIBarMetricsDefault];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.translucent = YES;

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
