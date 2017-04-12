//
//  FKViewController.m
//  ComicAndPicture
//
//  Created by MS on 16/3/3.
//  Copyright © 2016年 JFY. All rights reserved.
//

#import "FKViewController.h"
#import "NSString+URLCode.h"
#import "FKCell.h"
#import "FKPicViewController.h"
#import <MMProgressHUD.h>

@interface FKViewController (){
    
    BOOL _flag;
    
}

@end

@implementation FKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    [self createDataWithURL:[NSString stringWithFormat:self.url, @"%E4%BA%8C%E6%AC%A1%E5%85%83", self.page_num]];
    
    [self createCollectionViewWithReuseIdentifier:@"ID1" AndClass:[FKCell class]];
    
    [self createRefreshWith:30];
    
}

- (void)createRefreshWith:(int)page {
    
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        
        self.page_num = 0;
        
        self.isPulling = YES;
        
        [self createDataWithURL:[NSString stringWithFormat:self.url, @"%E4%BA%8C%E6%AC%A1%E5%85%83", self.page_num]];
        
    }];
    
    NSArray *images = @[[UIImage imageNamed:@"common_loading_anne_0"], [UIImage imageNamed:@"common_loading_anne_1"]];
    
    [header setImages:@[[UIImage imageNamed:@"common_loading_anne_0"]] forState:MJRefreshStateIdle];
    
    [header setImages:images forState:MJRefreshStateRefreshing];
    
    [header setImages:@[[UIImage imageNamed:@"common_loading_anne_1"]] forState:MJRefreshStatePulling];
    
    self.collectionView.mj_header = header;
    
    
    MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
        
        self.page_num += page;
        
        self.isPulling = NO;
        
       [self createDataWithURL:[NSString stringWithFormat:self.url, @"%E4%BA%8C%E6%AC%A1%E5%85%83", self.page_num]];
        
    }];
    
    [footer setImages:@[[UIImage imageNamed:@"common_loading_anne_0"]] forState:MJRefreshStateIdle];
    
    [footer setImages:images forState:MJRefreshStateRefreshing];
    
    [footer setImages:@[[UIImage imageNamed:@"common_loading_anne_1"]] forState:MJRefreshStatePulling];
    
    self.collectionView.mj_footer = footer;
    
}

- (void)createDataWithURL:(NSString *)urlString {
    
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
                
                [model setValuesForKeysWithDictionary:dict];
                
                [self.dataArray addObject:model];
                
            }
            
            if (self.isPulling) {
                
                [self.collectionView.mj_header endRefreshing];
                
            }else {
                
                [self.collectionView.mj_footer  endRefreshing];
                
            }
            
            [self.collectionView reloadData];
            
            [MMProgressHUD dismissWithSuccess:@"加载完成"];
            
        }else {
            
            [self.collectionView.mj_footer endRefreshing];
            
            [MMProgressHUD dismissWithError:@"没有更多数据"];
            
        }
        
        
        
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
        _flag = YES;
        
        [MMProgressHUD dismissWithError:error.localizedDescription afterDelay:2];
        
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
    
    FKCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ID1" forIndexPath:indexPath];
    
    PictureModel *model = self.dataArray[indexPath.row];
    
    [cell.picView sd_setImageWithURL:[NSURL URLWithString:model.icon[@"url"]] placeholderImage:nil];
    
    cell.nameLabel.text = model.name;
    
    return cell;
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    FKPicViewController *fkPic = [[FKPicViewController alloc] init];
    
    fkPic.fkId = [self.dataArray[indexPath.row] valueForKey:@"pic_id"];
    
    fkPic.url = FKPIC_URL;
    
    fkPic.title = [self.dataArray[indexPath.row] valueForKey:@"name"];
    
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
