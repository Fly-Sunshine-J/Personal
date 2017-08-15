//
//  ViewController.m
//  CoreDataTest
//
//  Created by vcyber on 16/10/24.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "Book+CoreDataClass.h"
#import "Student+CoreDataClass.h"

@interface ViewController ()

@property (nonatomic, strong) AppDelegate *appDelegate;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.w3school.com.cn/example/xmle/simple.xml"]];
    [NSURLConnection sendAsynchronousRequest:request queue:nil completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        NSLog(@"%@", data);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)save:(UIButton *)sender {
    
    NSManagedObjectContext *context = self.appDelegate.managedObjectContext;
    NSLog(@"save start");
    for (int i = 0; i < 100; i++) {
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Student" inManagedObjectContext:context];
        //创建学生对象
        Student *stu = [[Student alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
        stu.name = [NSString stringWithFormat:@"张三%d", i];
        NSEntityDescription *bEntity = [NSEntityDescription entityForName:@"Book" inManagedObjectContext:context];
        //创建Book对象
        Book *book = [[Book alloc] initWithEntity:bEntity insertIntoManagedObjectContext:context];
        book.title = @"红楼梦";
        book.author = @"曹雪芹";
        //添加Book对象
        [stu addBooksObject:book];
        
        //保存Student对象
        [_appDelegate saveContext];
    }
    NSLog(@"save end");
}

- (IBAction)read:(UIButton *)sender {
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Student"];
    NSArray *arr = [self.appDelegate.managedObjectContext executeFetchRequest:request error:nil];
    NSLog(@"read start");
    for (Student *stu in arr) {
        for (Book *b in stu.books) {
            if ([b.author isEqualToString:@"曹雪芹"]) {
                NSLog(@"%@", @"曹雪芹");
            }
        }
    }
    NSLog(@"read end");
}


- (AppDelegate *)appDelegate {
    if (!_appDelegate) {
        _appDelegate = [UIApplication sharedApplication].delegate;
    }
    return _appDelegate;
}

@end
