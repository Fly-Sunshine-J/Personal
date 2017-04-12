//
//  MenuViewController.m
//  Demo测试
//
//  Created by vcyber on 16/7/7.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "MenuViewController.h"
#import "global.h"
#import "MenuItemCell.h"
#import "ContainerViewController.h"

@interface MenuViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *menuItems;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, leftWidth, SCREEN_HEIGHT)];
//    self.view.backgroundColor = [UIColor yellowColor];
    
    [self.view addSubview:self.tableView];
    
    NSDictionary *item = self.menuItems[0];
    ContainerViewController *containerVC = (ContainerViewController *)self.parentViewController;
    containerVC.item = item;
    containerVC.show = YES;
}



- (NSArray *)menuItems {
    
    if (!_menuItems) {
        _menuItems = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"MenuItems" ofType:@"plist"]];
    }
    return _menuItems;
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, leftWidth, SCREEN_HEIGHT - 64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.bounces = NO;
    }
    return _tableView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.menuItems.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    MenuItemCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MenuItemCell"];
    if (!cell) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MenuItemCell" owner:self options:nil] firstObject];
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [(MenuItemCell *)cell configCellWithDictionary:self.menuItems[indexPath.row]];
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSDictionary *item = self.menuItems[indexPath.row];
    ContainerViewController *containerVC = (ContainerViewController *)self.parentViewController;
    containerVC.item = item;
    [containerVC showMenu:NO animation:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return MAX(80,(CGRectGetHeight(self.view.bounds)/(CGFloat)self.menuItems.count));
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
