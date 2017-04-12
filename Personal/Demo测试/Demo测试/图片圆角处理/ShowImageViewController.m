//
//  ShowImageViewController.m
//  Demo测试
//
//  Created by vcyber on 16/6/28.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "ShowImageViewController.h"
#import "CustomImageView.h"
#import "UIImage+RoundRectImage.h"

@interface ShowImageViewController ()

@end

@implementation ShowImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CustomImageView *imageView = [[CustomImageView alloc] initWithImage:[UIImage imageNamed:@"1"]];
    imageView.frame = CGRectMake(100, 100, 100, 100);
    [imageView clipImageRoundRectWithRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(20, 20)];
    [self.view addSubview:imageView];
    
    CustomImageView *imageView1 = [[CustomImageView alloc] initWithImage:[UIImage imageNamed:@"1"]];
    imageView1.frame = CGRectMake(10, 250, 100, 100);
    [imageView1 clipImageRoundRectWithRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomRight cornerRadii:CGSizeMake(20, 20)];
    [self.view addSubview:imageView1];
    
    CustomImageView *imageView2 = [[CustomImageView alloc] initWithImage:[UIImage imageNamed:@"1"]];
    imageView2.frame = CGRectMake(200, 250, 100, 100);
    [imageView2 clipImageInnerRoundRectWithRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(20, 20)];
    [self.view addSubview:imageView2];
    
    //radisu  是图片尺寸 不是imageView的尺寸
    UIImage *image = [[UIImage imageNamed:@"1"] imageByRoundCornerRadius:250 corners:UIRectCornerAllCorners borderWidth:0 borderColor:[UIColor redColor] borderLineJoin:kCGLineJoinRound];
    CustomImageView *imageView3 = [[CustomImageView alloc] initWithImage:image];
    imageView3.frame = CGRectMake(200, 450, 100, 100);
    [self.view addSubview:imageView3];
    
    
    self.SourceArray = [NSMutableArray arrayWithObjects:@[@"CustomImageView.h", @"DemoSourceViewController"], @[@"CustomImageView.m", @"DemoSourceViewController"], @[@"ShowImageViewController.h", @"DemoSourceViewController"], @[@"ShowImageViewController.m", @"DemoSourceViewController"], @[@"UIImage+RoundRectImage.h", @"DemoSourceViewController"], @[@"UIImage+RoundRectImage.m", @"DemoSourceViewController"], nil];
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
