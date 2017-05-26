//
//  DES3ViewController.m
//  加密算法
//
//  Created by vcyber on 17/5/23.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import "DES3ViewController.h"
#import "JFYDES3Tool.h"

@interface DES3ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textfield;
@property (weak, nonatomic) IBOutlet UILabel *encryotionLabel;
@property (weak, nonatomic) IBOutlet UILabel *decryptionLabel;

@end

@implementation DES3ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)encrypt:(id)sender {
    NSString *encryptionString = [JFYDES3Tool encryptUseDES:_textfield.text key:@"SUNSHINE"];
    _encryotionLabel.text = encryptionString;
}
- (IBAction)decrypt:(id)sender {
    NSString *decryptionString = [JFYDES3Tool decryptUseDES:_encryotionLabel.text key:@"SUNSHINE"];
    _decryptionLabel.text = decryptionString;
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
