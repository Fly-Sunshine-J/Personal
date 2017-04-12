//
//  ViewController.m
//  test
//
//  Created by dengweihao on 2017/3/14.
//  Copyright © 2017年 dengweihao. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Frame.h"
#import "LBZoomScrollView.h"
@interface ViewController ()<UIScrollViewDelegate>

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 80, 80)];
    imageView.image = [UIImage imageNamed:@"test.jpg"];
    [self.view addSubview:imageView];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.clipsToBounds = YES;
    imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewClicK:)];
    [imageView addGestureRecognizer:tap];
}

- (void)imageViewClicK:(UITapGestureRecognizer *)tap {
    LBZoomScrollView *sc =[[LBZoomScrollView alloc]init];
    [self.view addSubview:sc];
    [sc showImageWithURL:nil andPlaceHoldImage:nil andFrom:(UIImageView *)tap.view andFromViewLocationView:self.view];

}
@end
