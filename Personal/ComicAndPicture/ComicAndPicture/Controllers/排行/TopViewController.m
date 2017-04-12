//
//  TopViewController.m
//  ComicAndPicture
//
//  Created by MS on 16/3/3.
//  Copyright © 2016年 JFY. All rights reserved.
//

#import "TopViewController.h"
#import "TopCell.h"
#import <UIImageView+WebCache.h>
#import "TopItemViewController.h"
#import <MMProgressHUD.h>

@interface TopViewController (){
    
    BOOL _flag;
}

@end

@implementation TopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.tableView.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
    
    self.title = @"排行榜";
    
    [self createData];
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:143 / 255.0 green:119 / 255.0 blue:181 / 255.0 alpha:1];
    
    self.navigationController.navigationBarHidden = NO;
    
}

- (void)createData {
    
    [MMProgressHUD showWithTitle:@"努力加载中" status:@"努力加载中" images:@[[UIImage imageNamed:@"loading_teemo_1"], [UIImage imageNamed:@"loading_teemo_2"]]];
    
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleShrink];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:TOP_URL parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        _flag = YES;
        
        NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSArray *array = rootDic[@"results"];
        
        for (NSDictionary *dict in array) {
                
            [self.dataArray addObject:dict];
                
        }
            
        [self.tableView reloadData];
        
        [MMProgressHUD dismissWithSuccess:@"加载完成"];

    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
        _flag = YES;
        
        [MMProgressHUD dismissWithError:error.localizedDescription afterDelay:2];
        
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (!_flag) {
            
            
            if (self.isPulling) {
                
                [self.tableView.mj_header endRefreshing];
                
            }else {
                
                [self.tableView.mj_footer endRefreshing];
                
            }
            
            [MMProgressHUD dismissWithError:@"网络较慢,请耐心等待一会"];
            
        }
    });
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TopCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ID"];
    
    if (!cell) {
        
        cell = [[TopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ID"];
        
    }
    
    [cell.imagesView sd_setImageWithURL:[NSURL URLWithString:self.dataArray[indexPath.row][@"images"]]];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TopItemViewController *topItem = [[TopItemViewController alloc] init];
    
    topItem.urlString = RQB_URL;
    
    topItem.item_id = self.dataArray[indexPath.row][@"id"];
    
    topItem.navigationItem.title = self.dataArray[indexPath.row][@"name"];
    
    [self.navigationController pushViewController:topItem animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 666 * WIDTH / 1600;
    
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
