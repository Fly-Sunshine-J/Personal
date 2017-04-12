//
//  LeftViewController.m
//  TableView联动效果
//
//  Created by vcyber on 16/6/8.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "LeftViewController.h"
#import "RightViewController.h"

@interface LeftViewController ()<RightViewControllerDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) RightViewController *right;

@property (nonatomic, strong) UITableView *leftTableView;

@end

@implementation LeftViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createTableView];
    [self createRightViewController];
}



- (void)createTableView {
    
    _leftTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, JFYWIDTH * 0.3, JFYHEIGHT) style:UITableViewStylePlain];
    _leftTableView.delegate = self;
    _leftTableView.dataSource = self;
    _leftTableView.showsVerticalScrollIndicator = NO;
    _leftTableView.rowHeight = 44;
    [self.view addSubview:_leftTableView];
}


- (void)createRightViewController {
    
    _right = [[RightViewController alloc] init];
    _right.delegate = self;
    _right.sectionTitleArray = _leftDataArray;
    _right.rightDataArray = _rightDataArray;
    [self addChildViewController:_right];
    [self.view addSubview:_right.view];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _leftDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LEFT"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LEFT"];
    }
    cell.textLabel.text = _leftDataArray[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_right) {
        [_right scrollToSelectedIndexPath:indexPath];
    }
}


#pragma mark---RightViewControllerDelegate
- (void)willDisplayHeaderView:(NSInteger)section {
    
    [_leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:section inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}


- (void)didEndDisplayHeaderView:(NSInteger)section {
    
    [_leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:section + 1 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
