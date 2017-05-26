//
//  ViewController.m
//  加密算法
//
//  Created by vcyber on 17/5/23.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import "ViewController.h"
#import "JFYMD5Tool.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *encryptionLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

- (IBAction)md5:(id)sender {
    NSString *encryption = [JFYMD5Tool encryptMD5ForUpper32Bate:_textField.text];
    _encryptionLabel.text = encryption;
}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
