//
//  CenterViewController.m
//  自定义抽屉
//
//  Created by vcyber on 17/2/6.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import "CenterViewController.h"

#define kWidth [UIScreen mainScreen].bounds.size.width
#define maxOpenRatio 0.7

typedef NS_ENUM(NSInteger, MoveMethod) {
    BothMove,
    MenuMove,
};

@interface CenterViewController ()

@property (nonatomic, strong) UIViewController *rightVC;
@property (nonatomic, assign, getter=isOpen) BOOL open;
@property (nonatomic, strong) UIView *snapView;
@property (nonatomic, strong) UITapGestureRecognizer *tap;

@end

@implementation CenterViewController

- (instancetype)initWithRightVC:(UIViewController *)rightVc {
    self = [super init];
    if (self) {
        self.rightVC = rightVc;
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"侧滑" style:UIBarButtonItemStylePlain target:self action:@selector(open)];
        CGRect frame = CGRectOffset(self.view.frame, kWidth, 0);
        self.rightVC.view.frame = frame;
        [self.view addSubview:self.rightVC.view];
    }
    return self;
}

- (void)open {
    CGRect centerFrame = self.view.frame;
    CGRect rightFrame = self.rightVC.view.frame;
    self.navigationItem.rightBarButtonItem.action = NULL;
    if (self.open) {
        centerFrame.origin.x = 0;
        [UIView animateWithDuration:0.35 animations:^{
            self.snapView.frame = centerFrame;
            self.snapView.subviews.firstObject.alpha = 1.0;
            self.rightVC.view.frame = CGRectOffset(rightFrame, maxOpenRatio * kWidth, 0);
        } completion:^(BOOL finished) {
            if (finished) {
                self.navigationItem.rightBarButtonItem.action = @selector(open);
                [self.snapView removeFromSuperview];
            }
        }];
    }else {
       
        self.snapView = [self.view snapshotViewAfterScreenUpdates:NO];
        self.snapView.frame = centerFrame;
        
        centerFrame.origin.x = -kWidth * maxOpenRatio;
        rightFrame.origin.x = (1 - maxOpenRatio) * kWidth;
        
        UIView *blackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, centerFrame.size.width, centerFrame.size.height)];
        blackView.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.6];
        [self.snapView addSubview:blackView];
        
        [UIView animateWithDuration:0.35 animations:^{
            [self.view addSubview:self.snapView];
            self.snapView.frame = centerFrame;
            self.rightVC.view.frame = rightFrame;
        } completion:^(BOOL finished) {
            if (finished) {
                self.navigationItem.rightBarButtonItem.action = @selector(open);
                self.snapView.userInteractionEnabled = YES;
                [self.snapView addGestureRecognizer:self.tap];
            }
        }];
    }
    self.open = !self.open;
}

- (UITapGestureRecognizer *)tap {
    if (!_tap) {
        _tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(open)];
    }
    return _tap;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(200, 100, 100, 100)];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(log) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)log {
    NSLog(@"aaa");
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
