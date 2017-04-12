//
//  LookComicViewController.m
//  ComicAndPicture
//
//  Created by MS on 16/3/12.
//  Copyright © 2016年 JFY. All rights reserved.
//

#import "LookComicViewController.h"
#import "LookComicCell.h"
#import <UIImageView+WebCache.h>
#import <MMProgressHUD.h>

@interface LookComicViewController (){
    
    NSMutableArray *_widthArray;
    
    NSMutableArray *_heightArray;
    
    BOOL _isHiddenNav;
    
    BOOL _flag;
    
}

@end

@implementation LookComicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    _widthArray = [NSMutableArray array];
    
    _heightArray = [NSMutableArray array];

    [self createNavBar];
    
    [self configTableView];
    
}

- (void)configTableView {
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];

    self.tableView.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self createRefresh];
    
    if (self.downloaded) {
        
        [self createDataWithURL:nil];
        
    }else {
        
        [self createDataWithURL:[NSString stringWithFormat:LOOK_URL, self.comicArray[self.tag][@"id"]]];
    }
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
    
}


- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    self.tabBarController.tabBar.hidden = NO;
    
    self.navigationController.navigationBarHidden = YES;
    
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    
}

- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
}

- (void)createNavBar {
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    leftBtn.frame = CGRectMake(0, 0, 30, 30);
    
    [leftBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    
    [leftBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    
}


- (void)back {
    
    [self.delegate recordItemWithTag:self.tag];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)refresh {
    
    self.tag --;
    
    self.isPulling = YES;
    
    if (self.tag < 0) {
        
        [MMProgressHUD showWithStatus:@"已经是第一话了"];
        
        [MMProgressHUD dismissWithSuccess:nil title:nil afterDelay:0.6];
        
        [self.tableView.mj_header endRefreshing];
        
        self.tag ++;
        
    }else {
        
        if (self.downloaded) {
            
            [self createDataWithURL:nil];
            
        }else {
        
        [self createDataWithURL:[NSString stringWithFormat:LOOK_URL, self.comicArray[self.tag][@"id"]]];
            
        }
        
    }
    
}

- (void)getMore {
    
    self.tag++;
    
    self.isPulling = NO;
   
    if (self.tag < self.comicArray.count) {
        
        if (self.downloaded) {
            
            [self createDataWithURL:nil];
            
        }else {
        
        [self createDataWithURL:[NSString stringWithFormat:LOOK_URL, self.comicArray[self.tag][@"id"]]];
            
        }
        
    }else {

        [MMProgressHUD showWithStatus:@"已经是最后一话了"];
        
        [MMProgressHUD dismissWithSuccess:nil title:nil afterDelay:0.6];
        
        [self.tableView.mj_footer endRefreshing];
        
        self.tag--;
    }
   
}


- (void)createDataWithURL:(NSString *)urlString {
    
    if (self.downloaded) {
        
        if (self.isPulling) {
            
            [self.dataArray removeAllObjects];
            
            [_widthArray removeAllObjects];
            
            [_heightArray removeAllObjects];
            
        }
        
        for (NSDictionary *dict in self.comicArray[self.tag]) {
            
            [_widthArray addObject:dict[@"imgWidth"]];
            
            [_heightArray addObject:dict[@"imgHeight"]];
            
            [self.dataArray addObject:dict[@"images"]];
            
        }
        
        [self.tableView reloadData];
            
        if (self.isPulling) {
                
            [self.tableView.mj_header endRefreshing];
                
        }else {
                
            [self.tableView.mj_footer endRefreshing];
                
        }
    
    }else {
        
        [MMProgressHUD showWithTitle:@"努力加载中" status:@"努力加载中" images:@[[UIImage imageNamed:@"loading_teemo_1"], [UIImage imageNamed:@"loading_teemo_2"]]];
        
        [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleShrink];
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            
            _flag = YES;
            
            NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            
            NSArray *array = rootDic[@"results"];
            
            if (self.isPulling) {
                
                [self.dataArray removeAllObjects];
                
                [_widthArray removeAllObjects];
                
                [_heightArray removeAllObjects];
                
            }
            
            if (array.count > 0) {
                
                for (NSDictionary *dict in array) {
                    
                    [self.dataArray addObject:dict[@"images"]];
                    
                    [_widthArray addObject:dict[@"imgWidth"]];
                    
                    [_heightArray addObject:dict[@"imgHeight"]];
                    
                }
                
                [self.tableView reloadData];
                
                if (self.isPulling) {
                    
                    [self.tableView.mj_header endRefreshing];
                    
                }else {
                    
                    [self.tableView.mj_footer endRefreshing];
                    
                }
                
            }else {
                
                [self.tableView.mj_footer endRefreshingWithNoMoreData];
                
            }
            
            [MMProgressHUD dismissWithSuccess:@"加载成功"];
            
        } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
            
            if (self.isPulling) {
                
                [self.tableView.mj_header endRefreshing];
                
            }else {
                
                [self.tableView.mj_footer endRefreshing];
                
            }
            
        }];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            if (!_flag) {
                
                if (self.isPulling) {
                    
                    [self.tableView.mj_header endRefreshing];
                    
                }else {
                    
                    [self.tableView.mj_footer endRefreshing];
                    
                }
                
            }
            
        });
    }
    
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataArray.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LookComicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LOOK"];
    
    if (!cell) {
        
        cell = [[LookComicCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"LOOK"];
        
    }
    
    return cell;
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    LookComicCell *celll = (LookComicCell *)cell;
    CGFloat width = [_widthArray[indexPath.row] floatValue];
    
    CGFloat height = [_heightArray[indexPath.row] floatValue];
    
    celll.comicView.frame = CGRectMake(0, 0, WIDTH, WIDTH * height / width);
    
    if (self.downloaded) {
        
        celll.comicView.image = [UIImage imageWithData:self.dataArray[indexPath.row]];
        
    }else {
        
        [celll.comicView sd_setImageWithURL:[NSURL URLWithString:self.dataArray[indexPath.row]] placeholderImage:[UIImage imageNamed:@"default_image"]];
        
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CGFloat width = [_widthArray[indexPath.row] floatValue];
    
    CGFloat height = [_heightArray[indexPath.row] floatValue];
    
    return WIDTH * height / width;
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.navigationController.navigationBarHidden = _isHiddenNav ? YES : NO;
    
    _isHiddenNav = !_isHiddenNav;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (BOOL)prefersStatusBarHidden {
    
    return _isHiddenNav;
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
