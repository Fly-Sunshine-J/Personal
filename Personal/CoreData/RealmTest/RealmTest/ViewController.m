//
//  ViewController.m
//  RealmTest
//
//  Created by vcyber on 16/10/25.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "ViewController.h"
#import <Realm/Realm.h>
#import "Student.h"
#import "Book.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%@", [RLMRealm defaultRealm].configuration.fileURL);
}


- (IBAction)add:(UIButton *)sender {
    NSLog(@"save start");
    for (int i = 0; i < 10000; i++) {
        Student *stu = [[Student alloc] initWithValue:@{@"num": @(i), @"name": [NSString stringWithFormat:@"张三%d", i], @"age":@20}];
        for (int j = 0; j < 2; j ++) {
            Book *book = [[Book alloc] initWithValue:@[[NSString stringWithFormat:@"红楼梦%d", j], @19.8, stu]];
            [[RLMRealm defaultRealm] transactionWithBlock:^{
                [stu.books addObject:book];
            } error:nil];
        }
        
        [[RLMRealm defaultRealm] transactionWithBlock:^{
            [[RLMRealm defaultRealm] addObject:stu];
        } error:nil];
    }
    NSLog(@"save end");
}

- (IBAction)read:(id)sender {
    
    RLMResults *results = [Student allObjects];
    for (int i = 0; i < 50; i++) {
        Student *stu = results[i];
        NSLog(@"%@", stu.name);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
