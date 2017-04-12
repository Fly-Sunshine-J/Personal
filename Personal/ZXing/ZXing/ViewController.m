//
//  ViewController.m
//  ZXing
//
//  Created by vcyber on 16/5/20.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "ViewController.h"
#import "ZXingWidgetController.h"
#import "QRCodeReader.h"
@interface ViewController ()<ZXingDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}
- (IBAction)clickBtn:(id)sender {
    
    ZXingWidgetController *widController = [[ZXingWidgetController alloc] initWithDelegate:self showCancel:NO OneDMode:NO];
    NSMutableSet *readers = [[NSMutableSet alloc] init];
    QRCodeReader *qrcodeReader = [[QRCodeReader alloc] init];
    [readers addObject:qrcodeReader];
    widController.readers = readers;
    [self presentViewController:widController animated:YES completion:^{}];
}

- (void)zxingController:(ZXingWidgetController *)controller didScanResult:(NSString *)result {
    
    NSLog(@"%@", result);
}


- (void)zxingControllerDidCancel:(ZXingWidgetController *)controller {
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
