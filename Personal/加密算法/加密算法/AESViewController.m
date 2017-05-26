//
//  AESViewController.m
//  加密算法
//
//  Created by vcyber on 17/5/23.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import "AESViewController.h"
#import "JFYAESTool.h"

@interface AESViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *encryptLabel;
@property (weak, nonatomic) IBOutlet UILabel *decryptLabel;

@end

@implementation AESViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)encrpty:(id)sender {
    NSString *encrptionString = [JFYAESTool encryptUseAES:_textField.text key:@"SUNSHINE"];
    _encryptLabel.text = encrptionString;
}
- (IBAction)decrypt:(id)sender {
    NSString *decrytpionString = [JFYAESTool decryptUseAES:_encryptLabel.text key:@"SUNSHINE"];
    _decryptLabel.text = decrytpionString;
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
