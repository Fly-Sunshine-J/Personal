//
//  SelectDealerView.m
//  Record
//
//  Created by vcyber on 17/1/18.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import "FSExpandTableView.h"
#import "FSTreeTableViewCell.h"

#define RGBColor(r, g, b) [UIColor colorWithRed:r green:g blue:b alpha:1]

@interface FSExpandTableView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic,strong) NSMutableArray *displayArray; //需要显示的数据;

@property (nonatomic, assign) BOOL arrowViewEnable;

@end

@implementation FSExpandTableView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.arrowViewEnable = YES;
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.tableView];
        

    }
    return self;
}

- (void)setDataArray:(NSArray<FSTreeViewNode *> *)dataArray {
    _dataArray = dataArray;
    self.displayArray = [NSMutableArray arrayWithArray:dataArray];
    [self reloadDataForDisplayArray];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.tableFooterView = [UIView new]; //[self createFooterView];
        _tableView.separatorStyle= UITableViewCellSeparatorStyleNone;
        
    }
    return _tableView;
}


#pragma mark --UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.displayArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FSTreeViewNode *node = self.displayArray[indexPath.row];
    FSTreeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (!cell) {
        cell = [[FSTreeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell configCellWithNode:node IndexPath:indexPath];
    __weak typeof(self) wself = self;
    [cell setExpandBlock:^(NSIndexPath *expandPath) {
        [wself reloadDataForDisplayArrayChange:expandPath.row];
    }];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    FSTreeViewNode *node = self.displayArray[indexPath.row];
    if (self.selectCell) {
        self.selectCell(node);
    }
}


/**
 递归算法3
 */

- (void)selectDealerWithNode:(FSTreeViewNode *)node ResultArray:(NSMutableArray *)array {
    if (node.sonNodes) {
        for (FSTreeViewNode *node1 in node.sonNodes) {
            [self selectDealerWithNode:node1 ResultArray:array];
        }
    }
}


/**
 递归算法1
 */
- (void)dealerNode:(FSTreeViewNode *)node Array:(NSMutableArray *)array {
    [array addObject:node];
    if (node.isExpanded && node.sonNodes) {
        for (FSTreeViewNode *node1 in node.sonNodes) {
            [self dealerNode:node1 Array:array];
        }
    }
}



-(void) reloadDataForDisplayArray{
    NSMutableArray *tmp = [[NSMutableArray alloc]init];
    for (FSTreeViewNode *node1 in self.dataArray) {
        [self dealerNode:node1 Array:tmp];
    }
    _displayArray = [NSMutableArray arrayWithArray:tmp];
    [self.tableView reloadData];
}

/**
 递归算法2
 **/

- (void)changeStatuForNode:(FSTreeViewNode *)node ChangeRow:(NSInteger)row SelectRow:(NSInteger *)selectRow Array:(NSMutableArray *)array {
    [array addObject:node];
    if (*selectRow == row) {
        node.isExpanded = !node.isExpanded;
    }
    (*selectRow)++;
    if (node.isExpanded && node.sonNodes) {
        for (FSTreeViewNode *node1 in node.sonNodes) {
            [self changeStatuForNode:node1 ChangeRow:row SelectRow:selectRow Array:array];
        }
    }
}

/**
 修改某一个row的状态（展开/关闭）
 */


- (void)reloadDataForDisplayArrayChange:(NSInteger)row {
    
    
    NSMutableArray *temArray = [NSMutableArray array];
    NSInteger selectRow = 0;
    for (FSTreeViewNode *node0 in self.dataArray) {
        [self changeStatuForNode:node0 ChangeRow:row SelectRow:&selectRow Array:temArray];
    }
    self.displayArray = temArray;
    [self.tableView reloadData];
}


- (void)dealloc {
    NSLog(@"SelectDealerView 销毁");
}

@end


