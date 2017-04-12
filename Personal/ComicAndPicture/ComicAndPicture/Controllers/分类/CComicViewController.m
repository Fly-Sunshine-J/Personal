//
//  CComicViewController.m
//  ComicAndPicture
//
//  Created by MS on 16/3/3.
//  Copyright © 2016年 JFY. All rights reserved.
//

#import "CComicViewController.h"
#import "CategoryModel.h"
#import "CategoryCell.h"
#import <MMProgressHUD.h>
#import "ComicCategoryVC.h"

@interface CComicViewController (){
    
    BOOL _flag;
    
}

@end

@implementation CComicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
     self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createDataWithURL:CATEGORY_URL];
    
    [self createCollectionViewWithReuseIdentifier:@"COMIC" AndClass:[CategoryCell class]];
    
}

- (void)createDataWithURL:(NSString *)url {
    
    [MMProgressHUD showWithTitle:@"努力加载中" status:@"努力加载中" images:@[[UIImage imageNamed:@"loading_teemo_1"], [UIImage imageNamed:@"loading_teemo_2"]]];
    
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleShrink];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        _flag = YES;
        
        NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSArray *array = rootDic[@"results"];
        
        for (NSDictionary *dict in array) {
            
            CategoryModel *model = [[CategoryModel alloc] init];
            
            [model setValuesForKeysWithDictionary:dict];
            
            [self.dataArray addObject:model];
            
        }
        
        [self.collectionView reloadData];
        
        [MMProgressHUD dismissWithSuccess:@"加载完成"];
        
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
    
    CategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"COMIC" forIndexPath:indexPath];
    
    CategoryModel *model = self.dataArray[indexPath.row];
    
    [cell.coverView sd_setImageWithURL:[NSURL URLWithString:model.images] placeholderImage:[UIImage imageNamed:@"default_image"]];
    
    cell.nameLabel.text = model.name;
    
    return cell;
    
    
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake((WIDTH - 60) / 3, (WIDTH - 60) / 3 + 20);
    
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    
    return UIEdgeInsetsMake(5, 10, 5, 10);
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 20;
    
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 20;
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ComicCategoryVC *comicCategory = [[ComicCategoryVC alloc] init];
    
    comicCategory.categoryId = [self.dataArray[indexPath.row] valueForKey:@"categoryId"];
    
    comicCategory.title = [self.dataArray[indexPath.row] valueForKey:@"name"];
    
    [self.navigationController pushViewController:comicCategory animated:YES];
    
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
