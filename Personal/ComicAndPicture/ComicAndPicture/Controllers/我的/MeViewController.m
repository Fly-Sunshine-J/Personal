//
//  MeViewController.m
//  ComicAndPicture
//
//  Created by MS on 16/3/14.
//  Copyright © 2016年 JFY. All rights reserved.
//

#import "MeViewController.h"
#import "ViewController.h"
#import <SDImageCache.h>
#import "RecordManager.h"

@interface MeViewController ()

@end

@implementation MeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"我的";
    
    self.view.backgroundColor = [UIColor colorWithRed:178 / 255.0 green:127 / 255.0 blue:255 / 255.0 alpha:1];
    
    [self createButtons];
    
//    NSLog(@"%@", NSHomeDirectory());
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:143 / 255.0 green:119 / 255.0 blue:181 / 255.0 alpha:1];
    
    self.navigationController.navigationBarHidden = NO;
    
    
}


- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    
}

- (void)createButtons {
    
    NSArray *imageArray = @[@"我的收藏", @"清除缓存", @"已下载", @"已阅读"];
    
    for (int i = 0; i < imageArray.count; i++) {
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        
        button.frame = CGRectMake(50, (HEIGHT - imageArray.count * 53) / 2 + i * 53, WIDTH - 100, 53);
        
        [button setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
        
        button.tag = 500 + i;
        
        if (button.tag == 500) {
            
            [button setBackgroundImage:[UIImage imageNamed:@"上底_1"] forState:UIControlStateNormal];
            
        }else if (button.tag == 500 + imageArray.count - 1) {
            
            [button setBackgroundImage:[UIImage imageNamed:@"下底_1"] forState:UIControlStateNormal];
            
        }else {
            
            [button setBackgroundImage:[UIImage imageNamed:@"中底_1"] forState:UIControlStateNormal];
            
        }
        
        [button setTitle:imageArray[i] forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        button.imageEdgeInsets = UIEdgeInsetsMake(0, 20, 0, 0);
        
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 70, 0, 0);
        
        [self.view addSubview:button];
        
    }
    
    
}


- (void)click:(UIButton *)button {
    
    ViewController *vc;
    
    switch (button.tag) {
        case 500:
        {
            
            //收藏
            vc = [[ViewController alloc] init];
            
            vc.collection = @1;
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }
            break;
            
        case 501:
        {
            //清缓
            
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"清除缓存" message:[NSString stringWithFormat:@"缓存大小%0.2fM,确定要清除缓存?", [[SDImageCache sharedImageCache] getSize] / 1024.0 / 1024.0] preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *delete = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                
                [[SDImageCache sharedImageCache] clearDisk];
                
            }];
            
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
                
            }];
            
            
            [alert addAction:delete];
            
            [alert addAction:cancel];
            
            [self presentViewController:alert animated:YES completion:nil];
            
        }
            break;
            
        case 502:
        {
            //已下载
            vc = [[ViewController alloc] init];
            
            vc.download = @1;
            
            vc.downloading = @1;
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }
            break;
            
        case 503:
        {
            
            //已阅读
            vc = [[ViewController alloc] init];
            
            vc.read = @1;
            
            [self.navigationController pushViewController:vc animated:YES];
            
        }
            
            break;
            
        default:
            break;
    }
    
    vc.navigationItem.title = button.titleLabel.text;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
