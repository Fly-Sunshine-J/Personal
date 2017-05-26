//
//  RSAViewController.m
//  加密算法
//
//  Created by vcyber on 17/5/24.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import "RSAViewController.h"
#import "JFYRSATool.h"

@interface RSAViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *encryptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *decryptionLabel;

@property (weak, nonatomic) IBOutlet UILabel *signAfterLabel;
@property (weak, nonatomic) IBOutlet UILabel *vertifyResult;
@end

@implementation RSAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[JFYRSATool shareInstance] loadPublicKeyFromFile:[[NSBundle mainBundle] pathForResource:@"public_key" ofType:@"der"]];
    [[JFYRSATool shareInstance] loadPrivateKeyFromFile:[[NSBundle mainBundle] pathForResource:@"pkcs" ofType:@"p12"] password:@"jiafeiyao@vcyber"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)encryptString:(id)sender {
    NSString *encryptionString = [[JFYRSATool shareInstance] rsaEncryptString:_textField.text];
    _encryptionLabel.text = encryptionString;
    
}
- (IBAction)decryptString:(id)sender {
    NSString *decryptionString = [[JFYRSATool shareInstance] rsaDecryptString:_encryptionLabel.text];
    _decryptionLabel.text = decryptionString;
}

- (IBAction)qianming:(id)sender {
    NSData *data = [[NSData alloc] initWithBase64EncodedString:_encryptionLabel.text options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSData *signData = [[JFYRSATool shareInstance] rsaSHA256SignData:data];
    _signAfterLabel.text = [signData base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
}


- (IBAction)yanqian:(id)sender {
    NSData *signData = [[NSData alloc] initWithBase64EncodedString:_signAfterLabel.text options:NSDataBase64DecodingIgnoreUnknownCharacters];
    NSData *encriptyData = [[NSData alloc] initWithBase64EncodedString:_encryptionLabel.text options:NSDataBase64DecodingIgnoreUnknownCharacters];
    BOOL result = [[JFYRSATool shareInstance] rsaSHA256VerifyData:encriptyData Signature:signData];
    _vertifyResult.text = @(result).stringValue;
    if (result) {
        [_vertifyResult setBackgroundColor:[UIColor greenColor]];
    }else {
        [_vertifyResult setBackgroundColor:[UIColor redColor]];
    }
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
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
