//
//  ContainerViewController.m
//  Demo测试
//
//  Created by vcyber on 16/7/7.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "ContainerViewController.h"
#import "global.h"
#import "MenuViewController.h"
#import "DetailViewController.h"

@interface ContainerViewController ()<UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIView *menuView;

@property (nonatomic, strong) DetailViewController *detail;

@property (nonatomic, strong) UIButton *leftBtn;

@end

@implementation ContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self createUI];
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self.navigationItem.leftBarButtonItems = @[[[UIBarButtonItem alloc] initWithCustomView:self.leftBtn], item1];
    
    self.SourceArray = [NSMutableArray arrayWithObjects:@[@"ContainerViewController.h", @"DemoSourceViewController"], @[@"ContainerViewController.m", @"DemoSourceViewController"], @[@"MenuViewController.h", @"DemoSourceViewController"], @[@"MenuViewController.m", @"DemoSourceViewController"], @[@"DetailViewController.h", @"DemoSourceViewController"], @[@"DetailViewController.m", @"DemoSourceViewController"], @[@"MenuItemCell.h", @"DemoSourceViewController"], @[@"MenuItemCell.m", @"DemoSourceViewController"], nil];
}

- (void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)createUI {
    
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.contentView];
    [self.contentView addSubview:self.containerView];
    [self.contentView addSubview:self.menuView];
    
    self.detail = [[DetailViewController alloc] init];
    [self addChildViewController:self.detail];
    [self.containerView addSubview:self.detail.view];
    
    MenuViewController *menu = [[MenuViewController alloc] init];
    [self addChildViewController:menu];
    [self.menuView addSubview:menu.view];
    
}


- (void)setItem:(NSDictionary *)item {
    
    self.detail.item = item;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)showMenu:(BOOL)show animation:(BOOL)animation {
    
    [self.scrollView setContentOffset:show ? CGPointZero : CGPointMake(leftWidth, 0) animated:animation];
    self.show = show;
}

#pragma mark --懒加载

- (UIScrollView *)scrollView {
    
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT - 64)];
        _scrollView.delegate = self;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.delaysContentTouches = NO;
        _scrollView.contentSize = CGSizeMake(SCREEN_WIDTH + leftWidth, SCREEN_HEIGHT - 64);
        _scrollView.bounces = NO;
        _scrollView.pagingEnabled = YES;
    }
    return _scrollView;
}

- (UIView *)contentView {
    
    if (!_contentView) {
        _contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH + leftWidth, SCREEN_HEIGHT)];
    }
    return _contentView;
}


- (UIView *)containerView {
    
    if (!_containerView) {
        _containerView = [[UIView alloc] initWithFrame:CGRectMake(80, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
//        _containerView.backgroundColor = [UIColor yellowColor];
    }
    return _containerView;
}


- (UIView *)menuView {
    
    if (!_menuView) {
        _menuView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, leftWidth, SCREEN_HEIGHT)];
    }
    return _menuView;
}


- (UIButton *)leftBtn {
    
    if (!_leftBtn) {
        _leftBtn  = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftBtn setImage:[UIImage imageNamed:@"menu"] forState:UIControlStateNormal];
        _leftBtn.frame =CGRectMake(0, 0, 20, 20);
        [_leftBtn addTarget:self action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}

- (void)showMenu {
    
    [self showMenu:!self.show animation:YES];
}

#pragma mark --UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    _menuView.layer.anchorPoint = CGPointMake(1, 0.5);
    
    CGFloat offsetX = scrollView.contentOffset.x;
    CGFloat angle = - M_PI_2 * offsetX / leftWidth;
    self.menuView.alpha = 1 - offsetX / leftWidth;
    self.menuView.layer.transform = [self transformRotationWithAngle:angle];
    self.show = scrollView.contentOffset.x == leftWidth ? NO : YES;

    self.leftBtn.imageView.transform = CGAffineTransformMakeRotation(angle);
}




#pragma mark
- (CATransform3D)transformRotationWithAngle:(CGFloat)angle {
    
    CATransform3D rotation3DIdentity = CATransform3DIdentity;
    rotation3DIdentity.m34 = - 1.0 / 500;
    CATransform3D rotateTransform = CATransform3DRotate(rotation3DIdentity, angle, 0, 1, 0);
    CATransform3D transform = CATransform3DMakeTranslation(leftWidth / 2, 0, 0);
    return CATransform3DConcat(rotateTransform, transform);
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
