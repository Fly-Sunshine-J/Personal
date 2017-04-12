//
//  ViewController.m
//  音频相关
//
//  Created by vcyber on 16/12/6.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "ViewController.h"
#import "AudioToolboxViewController.h"
#import "LocalMusicViewController.h"
#import "NetWorkViewController.h"
@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.dataArray addObjectsFromArray:@[@"音效播放", @"本地音乐播放", @"网络音乐播放", @"音频服务队列"]];
    [self.tableView reloadData];
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        
    }
    return _tableView;
}


- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
    }
    cell.textLabel.text = self.dataArray[indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    switch (indexPath.row) {
        case 0:
        {
            AudioToolboxViewController *tool = [storyboard instantiateViewControllerWithIdentifier:@"AudioToolboxViewController"];
            [self.navigationController pushViewController:tool animated:YES];
        }

            break;
        case 1: {
            LocalMusicViewController *local = [storyboard instantiateViewControllerWithIdentifier:@"LocalMusicViewController"];
            [self.navigationController pushViewController:local animated:YES];
        }
            break;
        case 2: {
            NetWorkViewController *net = [storyboard instantiateViewControllerWithIdentifier:@"NetWorkViewController"];
            [self.navigationController pushViewController:net animated:YES];
        }
            break;
            
        default:
            break;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
