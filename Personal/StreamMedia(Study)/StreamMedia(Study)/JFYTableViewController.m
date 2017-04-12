//
//  JFYTableViewController.m
//  StreamMedia(Study)
//
//  Created by vcyber on 16/5/18.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "JFYTableViewController.h"

@implementation JFYTableViewController

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%d", indexPath.row];
    return cell;
}



- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)aTableView {
    
    return @[@""
             ,
             @"A",
             @"B",
             @"C",
             @"D",
             @"E",
             @"F",
             @"G",
             @"H",
             @"I",
             @"J",
             @"K",
             @"L",
             @"M",
             @"N",
             @"O",
             @"P",
             @"Q",
             @"R",
             @"S",
             @"T",
             @"U",
             @"V",
             @"W",
             @"X",
             @"Y",
             @"Z",
             @"#"
             ];
}

@end
