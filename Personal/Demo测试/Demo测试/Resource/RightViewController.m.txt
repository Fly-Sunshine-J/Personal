//
//  RightViewController.m
//  TableView联动效果
//
//  Created by vcyber on 16/6/8.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "RightViewController.h"

@interface RightViewController ()<UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UITableView *rightTableView;
@property (nonatomic, assign) BOOL isScrollUp; //是否向上滚动
@property (nonatomic, assign) CGFloat lastOffsetY; //滚动结束的时候记录offset.y

@end

@implementation RightViewController

- (void)viewDidLoad {
    self.view.backgroundColor = [UIColor whiteColor];
    [super viewDidLoad];
    [self createTableView];
}

- (void)createTableView {
    
    self.view = [[UIView alloc] initWithFrame:CGRectMake(JFYWIDTH * 0.3 , 0, JFYWIDTH * 0.7, JFYHEIGHT)];
    _rightTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, JFYWIDTH * 0.7, JFYHEIGHT - 64) style:UITableViewStylePlain];
    _rightTableView.delegate = self;
    _rightTableView.dataSource = self;
    _rightTableView.rowHeight = 64;
    _rightTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:_rightTableView];
}

- (void)setRightDataArray:(NSArray *)rightDataArray {
    
    _rightDataArray = rightDataArray;
    [_rightTableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return _sectionTitleArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_rightDataArray[section] count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    return _sectionTitleArray[section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RIGHT"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"RIGHT"];
    }
    cell.textLabel.text = _rightDataArray[indexPath.section][indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(willDisplayHeaderView:)] && !_isScrollUp && tableView.isDecelerating) {
        
        [self.delegate willDisplayHeaderView:section];
    }
    
}

- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(didEndDisplayHeaderView:)] && _isScrollUp && tableView.isDecelerating) {
        
        [self.delegate didEndDisplayHeaderView:section];
    }
    
}

#pragma mark ---UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    _isScrollUp = _lastOffsetY < scrollView.contentOffset.y;
    _lastOffsetY = scrollView.contentOffset.y;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark ---公开方法  实现左边滚动 右边的联动
- (void)scrollToSelectedIndexPath:(NSIndexPath *)indexPath {
    
    [_rightTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.row] animated:YES scrollPosition:UITableViewScrollPositionTop];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
