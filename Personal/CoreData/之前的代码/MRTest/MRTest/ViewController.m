//
//  ViewController.m
//  MRTest
//
//  Created by vcyber on 16/5/30.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "ViewController.h"
#import <MagicalRecord/MagicalRecord.h>
#import "Beer.h"
#import "BeerDetails.h"
#import "MRTestHeader.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    Beer *whiteBeer = [Beer MR_createEntity];
    whiteBeer.name = @"白酒";
    whiteBeer.beerDetails = [BeerDetails MR_createEntity];
    whiteBeer.beerDetails.image = @"image";
    whiteBeer.beerDetails.note = @"note";
    whiteBeer.beerDetails.rating = @2;
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    VcyberLog(@"%@", NSHomeDirectory());
    
    NSArray *array = [BeerDetails MR_findAll];
    for (BeerDetails *de in array) {
        NSLog(@"%@", de.note);
    }
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
