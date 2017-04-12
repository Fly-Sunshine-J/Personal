//
//  TableViewLinkageViewController.m
//  Demo测试
//
//  Created by vcyber on 16/6/28.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "TableViewLinkageViewController.h"
#import "LeftViewController.h"

@interface TableViewLinkageViewController ()

@end

@implementation TableViewLinkageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.SourceArray = [NSMutableArray arrayWithObjects:@[@"LeftViewController.h", @"DemoSourceViewController"], @[@"LeftViewController.m", @"DemoSourceViewController"], @[@"RightViewController.h", @"DemoSourceViewController"], @[@"RightViewController.m", @"DemoSourceViewController"], @[@"TableViewLinkageViewController.h", @"DemoSourceViewController"], @[@"TableViewLinkageViewController.m", @"DemoSourceViewController"],
                                                                                                nil];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    NSMutableArray *leftArray = [NSMutableArray array];
    for (int i = 0; i < 20; i++) {
        NSString *str = [NSString stringWithFormat:@"第%d类", i + 1];
        [leftArray addObject:str];
    }
    
    NSMutableArray *rightArray = [NSMutableArray array];
    for (int i = 0; i < 20; i++) {
        
        NSMutableArray *arr = [NSMutableArray array];
        int k = arc4random() % 10 + 1;
        for (int j = 0; j < k; j++) {
            NSString *str = [NSString stringWithFormat:@"第%d类%d子类", i + 1, j];
            [arr addObject:str];
        }
        [rightArray addObject:arr];
    }
    
    LeftViewController *left = [[LeftViewController alloc] init];
    left.leftDataArray = leftArray;
    left.rightDataArray = rightArray;
    
    [self.navigationController pushViewController:left animated:YES];
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
