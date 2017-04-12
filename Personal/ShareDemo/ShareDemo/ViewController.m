//
//  ViewController.m
//  ShareDemo
//
//  Created by vcyber on 16/11/16.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "ViewController.h"
#import <UMSocialCore/UMSocialCore.h>
#import "UMSocialUIManager.h"

@interface ViewController ()



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

}

- (void)getUserInfoForPlatform:(UMSocialPlatformType)platformType {
    [[UMSocialManager defaultManager]getUserInfoWithPlatform:platformType currentViewController:self completion:^(id result, NSError *error) {
        UMSocialUserInfoResponse *userinfo =result;
        NSString *message = [NSString stringWithFormat:@"name: %@\n icon: %@\n gender: %@\n",userinfo.name,userinfo.iconurl,userinfo.gender];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"UserInfo"
                                                        message:message
                                                       delegate:nil
                                              cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                              otherButtonTitles:nil];
        [alert show];
    }];
}

- (IBAction)share:(id)sender {
    __weak typeof(self) weakSelf = self;
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(320, 568), YES, 0);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *imageView = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGImageRef imageRef = imageView.CGImage;
    CGRect rect = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    CGImageRef imageRefRect = CGImageCreateWithImageInRect(imageRef, rect);
    UIImage *image = [[UIImage alloc] initWithCGImage:imageRefRect];

    //显示分享面板
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMShareMenuSelectionView *shareSelectionView, UMSocialPlatformType platformType) {
        
        UMSocialMessageObject *messageOb = [UMSocialMessageObject messageObject];
        UMShareImageObject *shareOb = [[UMShareImageObject alloc] init];
        shareOb.thumbImage = [UIImage imageNamed:@"yong01.png"];
        shareOb.shareImage = imageView;
        messageOb.shareObject = shareOb;
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageOb currentViewController:self completion:^(id result, NSError *error) {
            if (error) {
                NSLog(@"分享失败");
            }else {
                NSLog(@"%@",result);
            }
        }];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
