//
//  ViewController.m
//  CoreDataTest
//
//  Created by vcyber on 16/5/30.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"
#import "AppDelegate.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    AppDelegate *delegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *conext = delegate.context;
    
    Person *person = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:conext];
    [person setName:@"JFY"];
    [person setAge:@"23"];
    
    NSError *error = nil;
    if ([conext save:&error]) {
        NSLog(@"save success");
    }else {
        
        NSLog(@"%@", error.localizedDescription);
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
