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
//    NSLog(@"%@", [RLMRealm defaultRealm].configuration.fileURL);
}


- (IBAction)add:(UIButton *)sender {
    NSLog(@"save start");
    for (int i = 0; i < 100; i++) {
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
    
//    RLMResults *results = [Student allObjects];
//    for (int i = 0; i < 50; i++) {
//        Student *stu = results[i];
//        NSLog(@"%@", stu.name);
//    }
    [self excuteMigration];
}

- (void)excuteMigration {
    RLMMigrationBlock migratiobBlock = ^(RLMMigration *migration, uint64_t oldSchemaVersion) {
//        你修改那个表就对那个进行枚举
        if (oldSchemaVersion < 1) {
            [migration enumerateObjects:Student.className  block:^(RLMObject * _Nullable oldObject, RLMObject * _Nullable newObject) {
//                删除一个属性值  我们不需要任何操作 只需要修改模型即可
            }];
            
        }
        
        //              在前面的基础上新增一个字段，如果不需要默认值，可不加这句话，如果一个字段需要其他字段的协助，需要自行进行操作
        if (oldSchemaVersion < 2) {
            [migration enumerateObjects:Student.className  block:^(RLMObject * _Nullable oldObject, RLMObject * _Nullable newObject) {
                //这里给新增的字段添加一个默认值
                newObject[@"sex"] = @"男";
            }];
        }
        
        if (oldSchemaVersion < 3) {
            [migration enumerateObjects:Student.className  block:^(RLMObject * _Nullable oldObject, RLMObject * _Nullable newObject) {
                if (oldObject && oldObject.objectSchema[@"sex"].type == RLMPropertyTypeString) {
                    newObject[@"sex"] = @([Student sexTypeForString:oldObject[@"sex"]]);
                }
            }];
        }
    
    };
    //    获取默认配置
    RLMRealmConfiguration *config = [RLMRealmConfiguration defaultConfiguration];
    //    修改默认配置版本和迁移block 注意版本号的变化
    config.schemaVersion = 3;
    config.migrationBlock = migratiobBlock;
    [RLMRealmConfiguration setDefaultConfiguration:config];
    //    执行打开realm，完成迁移
    [RLMRealm defaultRealm];
}

- (void)didReceiveMemoryWarning { 
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
