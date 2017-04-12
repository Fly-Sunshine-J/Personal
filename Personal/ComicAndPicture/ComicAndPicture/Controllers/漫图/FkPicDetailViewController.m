//
//  FkPicDetailViewController.m
//  ComicAndPicture
//
//  Created by MS on 16/3/12.
//  Copyright © 2016年 JFY. All rights reserved.
//

#import "FkPicDetailViewController.h"
#import <UIImageView+WebCache.h>
#import <MMProgressHUD.h>
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

@interface FkPicDetailViewController (){
    
    UIImageView *_imageView;
}

@end

@implementation FkPicDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    [self createData];
    
    [self createControls];
    
}


- (void)createData {
    
    CGFloat width = [self.l_width floatValue];
    
    CGFloat height = [self.l_height floatValue];
    
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, (HEIGHT - WIDTH * height / width) / 2, WIDTH, WIDTH * height / width)];
    
    [_imageView sd_setImageWithURL:[NSURL URLWithString:self.url_l] placeholderImage:[UIImage imageNamed:@"default_image"]];
    
    [self.view addSubview:_imageView];
    
}


- (void)share:(UIButton *)btn {
    
    NSArray *imageArray = @[_imageView.image];
    
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                         images:imageArray
                                            url:[NSURL URLWithString:@"http://mob.com"]
                                          title:@"分享标题"
                                           type:SSDKContentTypeAuto];
        //2、分享（可以弹出我们的分享菜单和编辑界面）
        [ShareSDK showShareActionSheet:nil //要显示菜单的视图, iPad版中此参数作为弹出菜单的参照视图，只有传这个才可以弹出我们的分享菜单，可以传分享的按钮对象或者自己创建小的view 对象，iPhone可以传nil不会影响
                                 items:nil
                           shareParams:shareParams
                   onShareStateChanged:^(SSDKResponseState state, SSDKPlatformType platformType, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error, BOOL end) {
                       
                       switch (state) {
                           case SSDKResponseStateSuccess:
                           {
                               UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                                   message:nil
                                                                                  delegate:nil
                                                                         cancelButtonTitle:@"确定"
                                                                         otherButtonTitles:nil];
                               [alertView show];
                               break;
                           }
                           case SSDKResponseStateFail:
                           {
                               UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                               message:[NSString stringWithFormat:@"%@",error]
                                                                              delegate:nil
                                                                     cancelButtonTitle:@"OK"
                                                                     otherButtonTitles:nil, nil];
                               [alert show];
                               break;
                           }
                           default:
                               break;
                       }
                   }
         ];}
    
    
}


- (void)createControls {
    
    UIButton *btn = [UIButton buttonWithType: UIButtonTypeCustom];
    
    [btn setImage:[UIImage imageNamed:@"download"] forState:UIControlStateNormal];
    [btn setTitle:@"下载" forState:UIControlStateNormal];
    
    btn.backgroundColor = [UIColor brownColor];
    
    btn.frame = CGRectMake(0, HEIGHT - 49, WIDTH, 49);
    
    [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
    
}

- (void)clickBtn:(UIButton *)btn {
    
    //保存
    
    UIImageWriteToSavedPhotosAlbum(_imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    
}

-(void)image:(UIImage*)image didFinishSavingWithError:(NSError*)error contextInfo:(void*)contextInfo
{
    if(!error){
        
        [MMProgressHUD showWithTitle:@"保存中"];
        
        [MMProgressHUD dismissWithSuccess:@"保存完成" title:@"" afterDelay:0.5];
        
        
    }else{
        
        [MMProgressHUD showWithTitle:@"保存中"];
        
        [MMProgressHUD dismissWithSuccess:error.localizedDescription title:@"保存失败" afterDelay:0.5];
    }
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
