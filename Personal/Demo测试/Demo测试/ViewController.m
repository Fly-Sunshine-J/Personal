//
//  ViewController.m
//  Demo测试
//
//  Created by vcyber on 16/6/27.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Demo测试";
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    view.backgroundColor = [UIColor redColor];
    [self.navigationController.view addSubview:view];
    self.dataArray = [NSMutableArray arrayWithObjects:@[@"1.BezierPath动画", @"BezierPathViewController"],
                                                        @[@"2.三张图片轮播图", @"RollViewController"],
                                                        @[@"3.圆形计时器", @"CircleTimerViewController"],
                                                        @[@"4.TableView联动", @"TableViewLinkageViewController"],
                                                        @[@"5.图片圆角处理", @"ShowImageViewController"],
                                                        @[@"6.CollectionView瀑布流", @"WaterFlowViewController"],
                                                        @[@"7.颜色转图片", @"ColorToImageViewController"],
                                                        @[@"8.日历", @"ShowCalendarViewController"],
                                                        @[@"9.时钟", @"ShowTimerViewController"],
                                                        @[@"10.JS交互", @"JSInteractionViewController"],
                                                        @[@"11.刮奖", @"ScratchCardViewController"],
                                                        @[@"12.侧滑3D旋转", @"ContainerViewController"],
                                                        
                      
                      nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
