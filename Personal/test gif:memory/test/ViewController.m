//
//  ViewController.m
//  test
//
//  Created by dengweihao on 2017/3/14.
//  Copyright © 2017年 dengweihao. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Frame.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "LBPhotoBrowseManager.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView1;
@property (weak, nonatomic) IBOutlet UIImageView *imageView2;
@property (weak, nonatomic) IBOutlet UIImageView *imageView3;
@property (weak, nonatomic) IBOutlet UIImageView *imageView4;
@property (weak, nonatomic) IBOutlet UIImageView *imageView5;
@property (weak, nonatomic) IBOutlet UIImageView *imageView6;

@property (nonatomic , strong)NSArray *urls;

@property (nonatomic , strong)NSArray *imageViews;

@property (nonatomic , strong)NSArray *titles;

@end


@implementation ViewController

- (NSArray *)urls {
    if (!_urls) {
        _urls = @[
                  @"http://pic49.nipic.com/file/20140927/19617624_230415502002_2.jpg",
                  
                  @"https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=100334575,2106529211&fm=117&gp=0.jpg",
                  
                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1503555021950&di=17c2df6a4e00eb9cd903ca4b242420e6&imgtype=0&src=http%3A%2F%2Fpic.92to.com%2Fanv%2F201606%2F27%2Feo5n02tvqa5.gif",
                  
                  @"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1503555108956&di=c3be37163986b3d05badb269b0a10c4f&imgtype=0&src=http%3A%2F%2Fpic27.nipic.com%2F20130323%2F12013739_171719485183_2.gif",
                  
                  @"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=1929354940,3549861327&fm=117&gp=0.jpg",
                  
                  @"http://ww4.sinaimg.cn/bmiddle/406ef017jw1ec40av2nscj20ip4p0b29.jpg"
                  ];
    }
    return _urls;
}


- (void)viewDidLoad {
    [super viewDidLoad];

    _imageViews = @[ _imageView1,_imageView2,_imageView3,_imageView4,_imageView5 ,_imageView6];
    _titles = @[ @"发送朋友",@"收藏",@"保存图片",@"识别二维码",@"编辑",@"取消" ];
    for (int i = 0; i < _imageViews.count; i++) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imageViewClick:)];
        UIImageView *imageView = _imageViews[i];
        imageView.tag = i;
        [imageView addGestureRecognizer:tap];
        NSURL *url = [NSURL URLWithString:self.urls[i]];
        [imageView sd_setImageWithURL:url];
    }
 
}

- (void)imageViewClick:(UITapGestureRecognizer *)tap {
   [[LBPhotoBrowseManager defaultManager] showImageWithURLArray:_urls fromImageViews: _imageViews andSelectedIndex:(int)tap.view.tag andImageViewSuperView:self.view];

    [[[LBPhotoBrowseManager defaultManager] addLongPressShowTitles:self.titles] addTitleClickCallbackBlock:^(UIImage *image, NSIndexPath *indexPath, NSString *title) {
        NSLog(@"%@ %@ %@",image,indexPath,title);
    }];
    
    [[LBPhotoBrowseManager defaultManager] addPlaceHoldImageCallBackBlock:^UIImage *(NSIndexPath *indexPath) {
        NSLog(@"%@",indexPath);
        return [UIImage imageNamed:@"LBLoading.png"];
    }].lowGifMemory = YES;

}
@end
