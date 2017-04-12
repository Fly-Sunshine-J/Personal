//
//  SelectDealerView.m
//  Record
//
//  Created by vcyber on 17/1/18.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import "SelectDealerView.h"
#import "Masonry.h"
#import "TreeTableViewCell.h"

@interface SelectDealerView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray; //保存全部数据
@property (nonatomic,strong) NSMutableArray *displayArray; //需要显示的数据;

@end

@implementation SelectDealerView


- (instancetype)initWithFrame:(CGRect)frame DataArray:(NSArray <TreeViewNode *>*)dataArray
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        self.dataArray = [NSMutableArray arrayWithArray:dataArray];
        self.displayArray = self.dataArray;
        [self addSubview:self.tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
        [self reloadDataForDisplayArray];
    }
    return self;
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.tableFooterView = [UIView new];
    }
    return _tableView;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.displayArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TreeViewNode *node = self.displayArray[indexPath.row];
    TreeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (!cell) {
        cell = [[TreeTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    [cell configCellWithNode:node];
  
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self reloadDataForDisplayArrayChange:indexPath.row];
    
}


/*---------------------------------------
 初始化将要显示的cell的数据
 --------------------------------------- */
-(void) reloadDataForDisplayArray{
    NSMutableArray *tmp = [[NSMutableArray alloc]init];
    for (TreeViewNode *node in _dataArray) {
        [tmp addObject:node];
        if(node.isExpanded){
            for(TreeViewNode *node2 in node.sonNodes){
                [tmp addObject:node2];
                if(node2.isExpanded){
                    for(TreeViewNode *node3 in node2.sonNodes){
                        [tmp addObject:node3];
                        if (node3.isExpanded) {
                            [tmp addObject:node3];
                        }
                    }
                }
            }
        }
    }
    _displayArray = [NSMutableArray arrayWithArray:tmp];
    [self.tableView reloadData];
}


- (void)reloadDataForDisplayArrayChange:(NSInteger)row {
    TreeViewNode *node = self.displayArray[row];
    if (!node.sonNodes) {
        
        return;
    }
    NSMutableArray *temArray = [NSMutableArray array];
    NSInteger selectRow = 0;
    for (TreeViewNode *node0 in self.dataArray) {
        [temArray addObject:node0];
        if (selectRow == row) {
            node0.isExpanded = !node0.isExpanded;
        }
         selectRow++;
        if (node0.isExpanded) {
            for (TreeViewNode *node1 in node0.sonNodes) {
                [temArray addObject:node1];
                if (selectRow == row) {
                    node1.isExpanded = !node1.isExpanded;
                }
                selectRow++;
                if (node1.isExpanded) {
                    for (TreeViewNode *node2 in node1.sonNodes) {
                        [temArray addObject:node2];
                        if (selectRow == row) {
                            node2.isExpanded = !node2.isExpanded;
                        }
                        selectRow++;
                        if (node2.isExpanded) {
                            for (TreeViewNode *node3 in node2.sonNodes) {
                                [temArray addObject:node3];
                                selectRow ++;
                            }
                        }
                    }
                }
            }
        }
    }
    
    self.displayArray = temArray;
    [self.tableView reloadData];
}

/*---------------------------------------
 旋转箭头图标
 --------------------------------------- */
-(void) rotateArrow:(TreeTableViewCell*) cell with:(double)degree{
    [UIView animateWithDuration:0.35 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        cell.arrowView.layer.transform = CATransform3DMakeRotation(degree, 0, 0, 1);
    } completion:NULL];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
