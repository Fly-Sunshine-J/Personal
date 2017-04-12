//
//  PicDetailViewController.m
//  ComicAndPicture
//
//  Created by MS on 16/3/12.
//  Copyright © 2016年 JFY. All rights reserved.
//

#import "PicDetailViewController.h"
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import "PictureModel.h"
#import <MMProgressHUD.h>
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

@interface PicDetailViewController ()<UIScrollViewDelegate>{
    
    UIScrollView *_scrollView;
    
    NSMutableArray *_dataArray;
    
    NSInteger _num;
    
    BOOL _flag;
    
    NSMutableArray *_imageArray;
    
}

@end

@implementation PicDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    [self createNavBar];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
    
    self.navigationController.navigationBarHidden = NO;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    
}


- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    self.tabBarController.tabBar.hidden = NO;
    
    self.navigationController.navigationBarHidden = YES;
    
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    
}

- (void)createNavBar {
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    leftBtn.frame = CGRectMake(0, 0, 30, 30);
    
    [leftBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    
    [leftBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    rightBtn.frame = CGRectMake(0, 0, 30, 30);
    
    [rightBtn setImage:[UIImage imageNamed:@"fengxiang"] forState:UIControlStateNormal];
    
    [rightBtn addTarget:self action:@selector(share:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    self.navigationItem.rightBarButtonItem = rightItem;
    
}

- (void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)share:(UIButton *)btn {
    
    //分享
    
    NSArray *imageArray = @[[_dataArray[_num] valueForKey:@"qhimg_url"]];
    
    if (imageArray) {
        
        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                         images:imageArray
                                            url:[NSURL URLWithString:[_dataArray[_num] valueForKey:@"qhimg_url"]]
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
    
    NSArray *btnImageArray = @[@"last", @"next", @"baocun"];
    
    CGFloat xSpace = (WIDTH - btnImageArray.count * 62) / (btnImageArray.count + 1);
    
    for (int i = 0; i < btnImageArray.count; i++) {
        
        UIButton *btn = [UIButton buttonWithType: UIButtonTypeCustom];
        
        [btn setImage:[UIImage imageNamed:btnImageArray[i]] forState:UIControlStateNormal];
        
        btn.frame = CGRectMake(xSpace + (xSpace + 62) * i , HEIGHT - 49 - 60, 62, 48);
        
        btn.tag = 500 + i;
        
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:btn];
        
    }
    
}


- (void)clickBtn:(UIButton *)btn {
    
    
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake(WIDTH / 2 - 70, HEIGHT / 2 - 15, 150, 30)];
    
    tipLabel.font = [UIFont systemFontOfSize:14];
    
    tipLabel.textAlignment = NSTextAlignmentCenter;
    
    tipLabel.backgroundColor = [UIColor grayColor];
    
    tipLabel.textColor = [UIColor whiteColor];
    
    switch (btn.tag) {
        case 500:
        {
            //上一图
            
            if (_scrollView.contentOffset.x == 0) {
                
                tipLabel.text = @"已经是第一张";
                
                [self.view addSubview:tipLabel];
                
                [UIView animateWithDuration:1 animations:^{
                    
                    tipLabel.alpha = 0;
                    
                    
                } completion:^(BOOL finished) {
                    
                    [tipLabel removeFromSuperview];
                    
                }];
                
                break;
            }
            
            _scrollView.contentOffset = CGPointMake(_scrollView.contentOffset.x - WIDTH, 0);
            
        }
            break;
            
        case 501:
        {
            
            //下一图
            
            if (_scrollView.contentOffset.x == WIDTH * (_dataArray.count - 1)) {
                
                tipLabel.text = @"已经是最后一张";
                
                [self.view addSubview:tipLabel];
                
                [UIView animateWithDuration:1 animations:^{
                    
                    tipLabel.alpha = 0;
                    
                    
                } completion:^(BOOL finished) {
                    
                    [tipLabel removeFromSuperview];
                    
                }];
                
                break;
            }
            
            _scrollView.contentOffset = CGPointMake(_scrollView.contentOffset.x + WIDTH, 0);
            
        }
            break;
            
        case 502:
        {
            
            //保存图片
            UIImageView *imageView = _imageArray[_num];
            
            UIImageWriteToSavedPhotosAlbum(imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
            
        }
            break;
            
        default:
            break;
    }
    
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


- (void)createData {
    
    _dataArray = [NSMutableArray array];
    
    [MMProgressHUD showWithTitle:@"努力加载中" status:@"努力加载中" images:@[[UIImage imageNamed:@"loading_teemo_1"], [UIImage imageNamed:@"loading_teemo_2"]]];
    
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleShrink];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:[NSString stringWithFormat:PICTURE_URL, self.category, self.group_id] parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSArray *array = rootDic[@"list"];
        
        for (NSDictionary *dict in array) {
            
            PictureModel *model = [[PictureModel alloc] init];
            
            [model setValuesForKeysWithDictionary:dict];
            
            [_dataArray addObject:model];
            
        }
        
        _flag = YES;
        
        [self createScrollView];
        
        [MMProgressHUD dismissWithSuccess:@"加载完成"];
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
        [MMProgressHUD dismissWithError:error.localizedDescription afterDelay:2];
        
    }];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (!_flag) {
            [MMProgressHUD dismissWithError:@"网络较慢,请耐心等待一会"];
            
        }
        
        
    });
    
}


- (void)createScrollView {
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT - 50 - 48)];
    
    _imageArray = [NSMutableArray array];
    
    for (int i = 0; i < _dataArray.count; i++) {
        
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * WIDTH, (HEIGHT - WIDTH * 1200 / 1900) / 2, WIDTH, WIDTH * 1200 / 1900)];
        
        imageView.backgroundColor = [UIColor redColor];
        
        PictureModel *model = _dataArray[i];
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:model.qhimg_url] placeholderImage:nil];
        
        [_scrollView addSubview:imageView];
        
        [_imageArray addObject:imageView];
    
    }
    
    _scrollView.contentSize = CGSizeMake(WIDTH * _dataArray.count, WIDTH / 1440 * HEIGHT);
    
    _scrollView.contentOffset = CGPointZero;
    
    _scrollView.delegate = self;
    
    _scrollView.pagingEnabled = YES;
    
    [self.view addSubview:_scrollView];
    
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    _num = scrollView.contentOffset.x / scrollView.frame.size.width;
    
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
