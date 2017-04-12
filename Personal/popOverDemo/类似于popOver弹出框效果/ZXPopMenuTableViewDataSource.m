//
//  ZXPopMenuTableViewDataSource.m
//  类似于popOver弹出框效果
//
//  Created by ZouXu on 16/6/16.
//  Copyright © 2016年 ZouXu. All rights reserved.
//

#import "ZXPopMenuTableViewDataSource.h"
#import "ZXPopOverTableViewCell.h"

@interface ZXPopMenuTableViewDataSource ()

@property (nonatomic, copy) TableViewCellConfigureBlock configureCellBlock;
@property (nonatomic, strong) Class Cellclass;
@property (nonatomic, strong) NSArray * modelArray;

@end

@implementation ZXPopMenuTableViewDataSource



- (instancetype) initWithItems:(NSArray *)anItems
                     cellClass:(Class)cellClass
            configureCellBlock:(TableViewCellConfigureBlock)aConfigureCellBlock {
    
    if (self = [super init]) {
        
        self.modelArray = anItems;
        self.configureCellBlock = [aConfigureCellBlock copy];
        self.Cellclass = cellClass;
    }
    return self;
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.modelArray.count;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZXPopOverTableViewCell * cell = [[self.Cellclass class]cellAllocWithTableView:tableView];
    self.configureCellBlock(cell,self.modelArray[indexPath.row]);
    return cell;
}


@end
