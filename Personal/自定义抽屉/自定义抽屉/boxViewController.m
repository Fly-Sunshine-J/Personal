//
//  boxViewController.m
//  自定义抽屉
//
//  Created by vcyber on 16/6/7.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "boxViewController.h"

@interface boxViewController ()<UINavigationControllerDelegate> {
    UINavigationController *navCtrl;
    UIView *anotherView;
}

@end

@implementation boxViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.leftEnabled = YES;
        self.sideAnimationTime = 0.3f;
        self.sideWith = 80.0f;
    }
    return self;
}

- (void)viewDidLoad {
    
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.edgesForExtendedLayout = UIRectEdgeAll;//允许上下扩从
        self.extendedLayoutIncludesOpaqueBars = YES;//允许扩展到透明的导航栏下面
        self.modalPresentationCapturesStatusBarAppearance = NO;
    }
    
    self.view.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.2];
    self.contentView = [[UIView alloc] init];
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    anotherView = [[UIView alloc] init];
    anotherView.backgroundColor = [UIColor clearColor];
    anotherView.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissSelf:)];
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(dismissSelf:)];
    
    CGRect selfViewFrame = self.view.bounds;
    if (self.comeFromType == ModalViewControlComeFromLeft) {
        selfViewFrame.size.width = CGRectGetWidth(selfViewFrame) - self.sideWith;
        self.contentView.frame = selfViewFrame;
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin;
        anotherView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
        
        selfViewFrame.size.width = self.sideWith;
        selfViewFrame.origin.x = CGRectGetMaxX(self.contentView.frame);
        anotherView.frame = selfViewFrame;
        
        swipe.direction = UISwipeGestureRecognizerDirectionLeft;
        
    }else if (self.comeFromType == ModalViewControlComeFromRight) {
        selfViewFrame.size.width = CGRectGetWidth(selfViewFrame) - self.sideWith;
        selfViewFrame.origin.x = self.sideWith;
        self.contentView.frame = selfViewFrame;
        self.contentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin;
        
        
        selfViewFrame.origin.x = CGRectGetMinX(self.view.bounds);
        selfViewFrame.size.width = self.sideWith;
        anotherView.frame = selfViewFrame;
        
        swipe.direction = UISwipeGestureRecognizerDirectionRight;
    }
    
    [self.view addSubview:self.contentView];
    [self.view addSubview:anotherView];
    [anotherView addGestureRecognizer:tap];
    [self.view addGestureRecognizer:swipe];
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    UIView *status = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.contentView.frame),0, CGRectGetWidth(self.contentView.frame), 20)];
    status.backgroundColor = [UIColor cyanColor];
    [self.view addSubview:status];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)showWithComeFromType:(ModalViewControlComeFromType)FromType {
    self.comeFromType = FromType;
    UIViewController *controller = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (controller.presentedViewController != nil) {
        controller = controller.presentedViewController;
    }
    CGRect selfFrame = controller.view.bounds;
    switch (FromType) {
        case ModalViewControlComeFromRight:
            selfFrame.origin.x += selfFrame.size.width;
            break;
        case ModalViewControlComeFromLeft:
            selfFrame.origin.x -= selfFrame.size.width;
            break;
    }
    self.view.frame = selfFrame;
    navCtrl = [[UINavigationController alloc] initWithRootViewController:self];
    navCtrl.delegate = self;
    navCtrl.view.backgroundColor = [UIColor clearColor];
    [controller.view addSubview:navCtrl.view];
    [controller addChildViewController:navCtrl];
    [self willMoveToParentViewController:navCtrl];
    
}

- (void)dismissSelf:(id)sender {
    if (self.leftEnabled) {
        [self willMoveToParentViewController:nil];
        CGRect pareViewRect = self.parentViewController.view.bounds;
        CGFloat originX = 0;
        
        switch (self.comeFromType) {
            case ModalViewControlComeFromLeft:
                originX -= CGRectGetWidth(pareViewRect);
                break;
            case ModalViewControlComeFromRight:
                originX += CGRectGetWidth(pareViewRect);
        }
        
        [UIView animateWithDuration:self.sideAnimationTime animations:^{
            self.view.frame = CGRectMake(originX, CGRectGetMinY(pareViewRect), CGRectGetWidth(pareViewRect), CGRectGetHeight(pareViewRect));
        } completion:^(BOOL finished) {
            [navCtrl.view removeFromSuperview];
        }];
        [navCtrl removeFromParentViewController];
    }else{
    
    }
}

- (void)willMoveToParentViewController:(UIViewController *)parent {
    [UIView animateWithDuration:self.sideAnimationTime animations:^{
        CGRect selfViewFrame = self.view.frame;
        selfViewFrame.origin.x = 0.0f;
        self.view.frame = selfViewFrame;
    } completion:^(BOOL finished) {
        [super willMoveToParentViewController:parent];
    }];
}

#pragma mark UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
        [navigationController setNavigationBarHidden:YES animated:animated];
}

@end
