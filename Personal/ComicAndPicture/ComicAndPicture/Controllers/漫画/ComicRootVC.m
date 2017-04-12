//
//  ComicRootVC.m
//  ComicAndPicture
//
//  Created by MS on 16/3/3.
//  Copyright © 2016年 JFY. All rights reserved.
//

#import "ComicRootVC.h"
#import "ComicModel.h"
#import "ComicCell.h"
#import "DetailViewController.h"
#import <MMProgressHUD.h>

@interface ComicRootVC () {
    
    BOOL _flag;
}

@end

@implementation ComicRootVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.dataArray = [NSMutableArray array];
    
    _page = 1;
    
    [self createTableView];
    
}

- (void)createRefresh {
    
    
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingTarget:self refreshingAction:@selector(refresh)];
    
    [header setImages:@[[UIImage imageNamed:@"common_loading_anne_0"], [UIImage imageNamed:@"common_loading_anne_1"]] forState:MJRefreshStateRefreshing];
    
    [header setImages:@[[UIImage imageNamed:@"common_loading_anne_0"]] forState:MJRefreshStateIdle];
    
    [header setImages:@[[UIImage imageNamed:@"common_loading_anne_1"]] forState:MJRefreshStatePulling];
    
    self.tableView.mj_header = header;
    
    
    MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingTarget:self refreshingAction:@selector(getMore)];
    
    [footer setImages:@[[UIImage imageNamed:@"common_loading_anne_0"], [UIImage imageNamed:@"common_loading_anne_1"]] forState:MJRefreshStateRefreshing];
    
    [footer setImages:@[[UIImage imageNamed:@"common_loading_anne_0"]] forState:MJRefreshStateIdle];
    
    [footer setImages:@[[UIImage imageNamed:@"common_loading_anne_1"]] forState:MJRefreshStatePulling];
    
    self.tableView.mj_footer = footer;
    
}

- (void)refresh {
    
    _page = 1;
    
    _isPulling = YES;
    
    [self createDataWithURL:[NSString stringWithFormat:self.urlString, _page]];
    
}


- (void)getMore {
    
    _page++;
    
    _isPulling = NO;
    
    [self createDataWithURL:[NSString stringWithFormat:self.urlString, _page]];
    
}


- (void)createTableView {
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64 - 44) style:UITableViewStylePlain];
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    self.tableView.showsVerticalScrollIndicator = NO;
    
    [self.view addSubview:self.tableView];
    
}


- (void)createDataWithURL:(NSString *)urlString {
    
    [MMProgressHUD showWithTitle:@"努力加载中" status:@"努力加载中" images:@[[UIImage imageNamed:@"loading_teemo_1"], [UIImage imageNamed:@"loading_teemo_2"]]];
    
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleShrink];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {

        _flag = YES;
        
        NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSArray *array = rootDic[@"results"];
        
        if (_isPulling) {
            
            [self.dataArray removeAllObjects];
            
        }
        
        if (array.count > 0) {
            
            for (NSDictionary *dict in array) {
                
                ComicModel *model = [[ComicModel alloc] init];
                
                [model setValuesForKeysWithDictionary:dict];
                
                [self.dataArray addObject:model];
                
            }
            
            [MMProgressHUD dismissWithSuccess:@"加载完成"];
            
            [self.tableView reloadData];
            
            if (_isPulling) {
                
                [self.tableView.mj_header endRefreshing];
                
            }else {
                
                [self.tableView.mj_footer endRefreshing];
                
            }
            
        }else {
            
            [self.tableView.mj_footer endRefreshing];
            
            [MMProgressHUD dismissWithError:@"没有更多数据"];
            
        }
        
        
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
        _flag = YES;
        
        [MMProgressHUD dismissWithError:error.localizedDescription afterDelay:2];

        if (_isPulling) {
            
            [self.tableView.mj_header endRefreshing];
            
        }else {
            
            [self.tableView.mj_footer endRefreshing];
            
        }
        
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (!_flag) {
            [MMProgressHUD dismissWithError:@"网络较慢,请耐心等待一会"];
            
            if (_isPulling) {
                
                [self.tableView.mj_header endRefreshing];
                
            }else {
                
                [self.tableView.mj_footer endRefreshing];
                
            }
        }
        
    
    });
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ComicCell *cell = [ComicCell cellWithTableView:tableView];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell configCellWithModel:self.dataArray[indexPath.row]];
    
    return cell;
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 160;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    DetailViewController *detail = [[DetailViewController alloc] init];
    
    detail.model = self.dataArray[indexPath.row];
    
    [self.navigationController pushViewController:detail animated:YES];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
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
