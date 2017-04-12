//
//  ViewController.m
//  SQLiteTest
//
//  Created by vcyber on 16/10/25.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "ViewController.h"
#import "DataBaseManager.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([[DataBaseManager shareManager] openDataBaseWithName:@"database.sqlite"]) {
        [[DataBaseManager shareManager] createTableWithName:@"mytable"];
    }
    
}
- (IBAction)add:(UIButton *)sender {
    NSLog(@"save start");
    for (int i = 0; i < 10000; i++) {
        NSString *sql = [NSString stringWithFormat:@"insert into mytable(name, age) values('张三%d', '%d')", i, 20];
        [[DataBaseManager shareManager] insertDataWithSQL:sql];
    }
    NSLog(@"save end");
}
- (IBAction)read:(UIButton *)sender {
    NSLog(@"read start");
    NSArray *arr = [[DataBaseManager shareManager] selectDataWithSQL:@"select * from mytable"];
    NSLog(@"read end");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
