//
//  FKPicViewController.m
//  ComicAndPicture
//
//  Created by MS on 16/3/12.
//  Copyright © 2016年 JFY. All rights reserved.
//

#import "FKPicViewController.h"
#import "FKPicCell.h"
#import <UIImageView+WebCache.h>
#import "PictureModel.h"
#import "FkPicDetailViewController.h"
#import <MMProgressHUD.h>

@interface FKPicViewController (){
    
    BOOL _flag;
    
}

@end

@implementation FKPicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createNavBar];

    [self createDataWithURL:[NSString stringWithFormat:self.url, self.fkId, self.page_num]];
    
    [self createCollectionViewWithReuseIdentifier:@"ID2" AndClass:[FKPicCell class]];
    
    [self createRefreshWith:30];
    
    self.collectionView.frame = CGRectMake(0, 64, WIDTH, HEIGHT - 64);
    
    [self createBackButton];
    
}


- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
    self.tabBarController.tabBar.hidden = YES;
    
}


- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    
    self.tabBarController.tabBar.hidden = NO;
    
}


- (void)createNavBar {
    
    self.navigationController.navigationBar.barTintColor = [UIColor brownColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    
    label.textAlignment = NSTextAlignmentCenter;
    
    label.textColor = [UIColor whiteColor];
    
    label.text = self.title;
    
    self.navigationItem.titleView = label;
    
}


- (void)createRefreshWith:(int)page {
    
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        
        self.page_num = 0;
        
        self.isPulling = YES;
        
        [self createDataWithURL:[NSString stringWithFormat:self.url, self.fkId, self.page_num]];
        
    }];
    
    NSArray *images = @[[UIImage imageNamed:@"common_loading_anne_0"], [UIImage imageNamed:@"common_loading_anne_1"]];
    
    [header setImages:@[[UIImage imageNamed:@"common_loading_anne_0"]] forState:MJRefreshStateIdle];
    
    [header setImages:images forState:MJRefreshStateRefreshing];
    
    [header setImages:@[[UIImage imageNamed:@"common_loading_anne_1"]] forState:MJRefreshStatePulling];
    
    self.collectionView.mj_header = header;
    
    
    MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
        
        self.page_num += page;
        
        self.isPulling = NO;
        
        [self createDataWithURL:[NSString stringWithFormat:self.url, self.fkId, self.page_num]];
        
    }];
    
    [footer setImages:@[[UIImage imageNamed:@"common_loading_anne_0"]] forState:MJRefreshStateIdle];
    
    [footer setImages:images forState:MJRefreshStateRefreshing];
    
    [footer setImages:@[[UIImage imageNamed:@"common_loading_anne_1"]] forState:MJRefreshStatePulling];
    
    self.collectionView.mj_footer = footer;
    
}


- (void)createDataWithURL:(NSString *)urlString{
    
    [MMProgressHUD showWithTitle:@"努力加载中" status:@"努力加载中" images:@[[UIImage imageNamed:@"loading_teemo_1"], [UIImage imageNamed:@"loading_teemo_2"]]];
    
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleShrink];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        _flag = YES;
        
        NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSArray *array = rootDic[@"item"];
        
        if (array.count > 0) {
            
            if (self.isPulling) {
                
                [self.dataArray removeAllObjects];
                
            }
            
            for (NSDictionary *dict in array) {
                
                
                
                PictureModel *model = [[PictureModel alloc] init];
                
                [model setValuesForKeysWithDictionary:dict[@"icon"]];
                
                [self.dataArray addObject:model];
                
            }
            
            [self.collectionView reloadData];
            
            if (self.isPulling) {
                
                [self.collectionView.mj_header endRefreshing];
                
            }else {
                
                [self.collectionView.mj_footer  endRefreshing];
                
            }
            
            [MMProgressHUD dismissWithSuccess:@"加载完成"];
            
        }else {
            
            [self.collectionView.mj_footer endRefreshing];
            
            [MMProgressHUD dismissWithSuccess:@"没有更多数据"];
            
        }
        
        
        
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
        [MMProgressHUD dismissWithError:error.localizedDescription afterDelay:2];
        
        _flag = YES;
        
        if (self.isPulling) {
            
            [self.collectionView.mj_header endRefreshing];
            
        }else {
            
            [self.collectionView.mj_footer endRefreshing];
            
        }
        
    }];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (!_flag) {
            
            if (self.isPulling) {
                
                [self.collectionView.mj_header endRefreshing];
                
            }else {
                
                [self.collectionView.mj_footer endRefreshing];
                
            }
            
            [MMProgressHUD dismissWithError:@"网络较慢,请耐心等待一会"];
            
        }
        
    });
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    FKPicCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ID2" forIndexPath:indexPath];
    
    PictureModel *model = self.dataArray[indexPath.row];
   
    [cell.picView sd_setImageWithURL:[NSURL URLWithString:model.url_l] placeholderImage:[UIImage imageNamed:@"default_image"]];
    
    return cell;
    
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(WIDTH / 3 - 1, WIDTH / 3 - 1);
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    FkPicDetailViewController *fkPic = [[FkPicDetailViewController alloc] init];
    
    PictureModel *model = self.dataArray[indexPath.row];
    
    fkPic.url_l = model.url_l;
    
    fkPic.l_height = model.l_height;
    
    fkPic.l_width = model.l_width;
    
    [self.navigationController pushViewController:fkPic animated:YES];
    
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
