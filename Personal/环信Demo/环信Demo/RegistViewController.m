//
//  RegistViewController.m
//  环信Demo
//
//  Created by vcyber on 16/5/31.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "RegistViewController.h"
#import "UIViewController+HUD.h"
#import "NSString+Valid.h"
#import "EMSDK.h"
#import <MBProgressHUD.h>
#import "EaseSDKHelper.h"


#define WS(weakSelf) __weak typeof(self) weakSelf = self

@interface RegistViewController()

@property (weak, nonatomic) IBOutlet UITextField *username;

@property (weak, nonatomic) IBOutlet UITextField *password;

@end

@implementation RegistViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        NSLog(@"%d", [self isKindOfClass:[UIViewController class]]);
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor cyanColor];
    _username.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"account"]];
    _username.leftViewMode = UITextFieldViewModeAlways;
    _password.leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"password"]];
    _password.leftViewMode = UITextFieldViewModeAlways;
    
}

- (IBAction)registers:(UIButton *)sender {
    if(![self isEmpty]){
    
        [self.view endEditing:YES];
        if([_username.text isChinese]){
            
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
                
            }];
            NSMutableArray *array = [NSMutableArray arrayWithObject:action];
            [self showAlertViewWithTitle:@"" AndMessage:@"用户名不能是中文!" prefrredStyle:UIAlertControllerStyleAlert ActionArray:array completion:nil];
            return;
        }
        
        [self showHUDInView:self.view WithMesssage:@"Is to register..."];
        WS(weakSelf);
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            EMError *error = [[EMClient sharedClient] registerWithUsername:_username.text password:_password.text];
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf hideHUD];
                if(!error) {
                    [weakSelf showAlertViewWithTitle:@"" AndMessage:@"注册成功!" prefrredStyle:UIAlertControllerStyleAlert ActionArray:nil completion:^{
                        [weakSelf dismiss];
                    }];
                }else {
                    
                    switch (error.code) {
                        case EMErrorServerNotReachable:{
                            [weakSelf showAlertViewWithTitle:@"" AndMessage:@"服务器未连接!" prefrredStyle:UIAlertControllerStyleAlert ActionArray:nil completion:^{
                                [weakSelf dismiss];
                            }];
                            break;
                        }
                        case EMErrorUserAlreadyExist:{
                            [weakSelf showAlertViewWithTitle:@"" AndMessage:@"用户已存在!" prefrredStyle:UIAlertControllerStyleAlert ActionArray:nil completion:^{
                                [weakSelf dismiss];
                            }];
                            break;
                        }
                        case EMErrorNetworkUnavailable:{
                            [weakSelf showAlertViewWithTitle:@"" AndMessage:@"网络不可用!" prefrredStyle:UIAlertControllerStyleAlert ActionArray:nil completion:^{
                                [weakSelf dismiss];
                            }];
                            break;
                        }
                        case EMErrorServerTimeout:{
                            [weakSelf showAlertViewWithTitle:@"" AndMessage:@"服务器超时!" prefrredStyle:UIAlertControllerStyleAlert ActionArray:nil completion:^{
                                [weakSelf dismiss];
                            }];
                            break;
                        }
                        default:
                            [weakSelf showAlertViewWithTitle:@"" AndMessage:@"注册失败!" prefrredStyle:UIAlertControllerStyleAlert ActionArray:nil completion:^{
                                [weakSelf dismiss];
                            }];
                            break;
                            
                    }
                }
                
            });
           
        });
        
    }
    
}


- (IBAction)login:(UIButton *)sender {
    
    if(![self isEmpty]){
        
        [self.view endEditing:YES];
        if([_username.text isChinese]){
            
            UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
                
            }];
            NSMutableArray *array = [NSMutableArray arrayWithObject:action];
            [self showAlertViewWithTitle:@"" AndMessage:@"用户名不能是中文!" prefrredStyle:UIAlertControllerStyleAlert ActionArray:array completion:nil];
            return;
        }
    }
    
    [self loginWithUsername:_username.text AndPassword:_password.text];
}


- (void)loginWithUsername:(NSString *)username AndPassword:(NSString *)password {
    
    [self showHUDInView:self.view WithMesssage:@"正在登陆...."];
    WS(weakSelf);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        EMError *error = [[EMClient sharedClient] loginWithUsername:username password:password];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self hideHUD];
            if (!error) {
                //设置是否自动登录
                [[EMClient sharedClient].options setIsAutoLogin:YES];
                //发送自动登陆状态通知
                [[NSNotificationCenter defaultCenter] postNotificationName:KNOTIFICATION_LOGINCHANGE object:@([[EMClient sharedClient] isLoggedIn])];
                //保存最近一次登录用户名
                [weakSelf saveLastLoginUsername];
              
            }else {
                
                switch (error.code)
                {

                    case EMErrorNetworkUnavailable:{
                        [weakSelf showAlertViewWithTitle:@"" AndMessage:@"网络不可用!" prefrredStyle:UIAlertControllerStyleAlert ActionArray:nil completion:^{
                            [weakSelf dismiss];
                        }];
                        break;
                    }
                    case EMErrorServerNotReachable:{
                        [weakSelf showAlertViewWithTitle:@"" AndMessage:@"服务器未连接!" prefrredStyle:UIAlertControllerStyleAlert ActionArray:nil completion:^{
                            [weakSelf dismiss];
                        }];
                        break;
                    }
                    case EMErrorUserAuthenticationFailed:{
                        [weakSelf showAlertViewWithTitle:@"" AndMessage:@"密码验证失败!" prefrredStyle:UIAlertControllerStyleAlert ActionArray:nil completion:^{
                            [weakSelf dismiss];
                        }];
                        break;
                    }
                    case EMErrorServerTimeout:{
                        [weakSelf showAlertViewWithTitle:@"" AndMessage:@"服务器超时!" prefrredStyle:UIAlertControllerStyleAlert ActionArray:nil completion:^{
                            [weakSelf dismiss];
                        }];
                        break;
                    }
                    default:
                        [weakSelf showAlertViewWithTitle:@"" AndMessage:@"登录失败!" prefrredStyle:UIAlertControllerStyleAlert ActionArray:nil completion:^{
                            [weakSelf dismiss];
                        }];
                        break;
                }
            }
        });
        
        
    });
}


- (void)saveLastLoginUsername {
    
    NSString *lastname = [[EMClient sharedClient] currentUsername];
    if (lastname && lastname.length > 0) {
        [[NSUserDefaults standardUserDefaults] setValue:lastname forKey:@"lastname"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
}

- (void)dismiss {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self dismissViewControllerAnimated:YES completion:nil];
    });
}


- (BOOL)isEmpty {
    
    NSString *pwd = _password.text;
    NSString *username = _username.text;
    if (pwd.length == 0 || username.length == 0) {
        
        [self showAlertViewWithTitle:@"" AndMessage:@"用户名或者密码不能为空!" prefrredStyle:UIAlertControllerStyleAlert ActionArray:nil completion:^{
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self dismissViewControllerAnimated:YES completion:nil];
            });
            
        }];
        return YES;
    }
    return NO;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
