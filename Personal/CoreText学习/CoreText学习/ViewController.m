//
//  ViewController.m
//  CoreText学习
//
//  Created by vcyber on 17/8/30.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import "ViewController.h"
#import "FSCoreText.h"
#import "ContentLabel.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet FSLabel *fsLabel;
@property (weak, nonatomic) IBOutlet ContentLabel *contentLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    CTFrameConfig *config = [[CTFrameConfig alloc] init];
//    config.textColor = [UIColor whiteColor];
//    config.width = _fsLabel.width;
//    
//    CoreTextData *data = [CTFrameParse parseContent:@"按照以上原则，安徽省打好了哎说多了开始的爱上的拉升爱仕达拉空数据阿莎卡死了啊是北大绿卡" config:config];
//    _fsLabel.data = data;
//    _fsLabel.height = data.height;

    
    
    
    CTFrameConfig *config = [[CTFrameConfig alloc] init];
    config.width = self.contentLabel.width;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"content" ofType:@"json"];
    CoreTextData *data = [CTFrameParse parseTemplateFile:path config:config];
    self.contentLabel.data = data;
    self.contentLabel.height = data.height;
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
