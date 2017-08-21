//
//  ViewController.m
//  FSExtendTableView
//
//  Created by vcyber on 17/8/21.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import "ViewController.h"
#import "FSExpandTableView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    FSExpandTableView *expandTableView = [[FSExpandTableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:expandTableView];
    
    NSMutableArray *dataArray = [NSMutableArray array];
    for (int i = 0; i < 2; i++) {
        FSTreeViewNode *node0 = [[FSTreeViewNode alloc] init];
        node0.nodeLevel = 0;
        node0.nodeData = [NSString stringWithFormat:@"node%d", i];
        NSMutableArray *sonNodes = [NSMutableArray array];
        for (int j = 0; j < 12; j++) {
            FSTreeViewNode *node00 = [[FSTreeViewNode alloc] init];
            node00.nodeLevel = 1;
            node00.nodeData = [NSString stringWithFormat:@"node%02d", j];
            [sonNodes addObject:node00];
        }
        node0.sonNodes = sonNodes;
        [dataArray addObject:node0];
    }
    expandTableView.dataArray = dataArray;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
