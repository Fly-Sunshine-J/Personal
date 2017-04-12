//
//  ViewController.m
//  TableView联动效果
//
//  Created by vcyber on 16/6/8.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "ViewController.h"
#import "LeftViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (IBAction)click:(id)sender {
    
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

@end
