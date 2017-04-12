//
//  CPictureViewController.m
//  ComicAndPicture
//
//  Created by MS on 16/3/3.
//  Copyright © 2016年 JFY. All rights reserved.
//

#import "CPictureViewController.h"
#import "CategoryModel.h"
#import "CategoryCell.h"
#import <UIImageView+WebCache.h>
#import "PictureCategoryVC.h"

@interface CPictureViewController ()

@end

@implementation CPictureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createDataWithURL:@""];
    
    [self createCollectionViewWithReuseIdentifier:@"PICTURE" AndClass:[CategoryCell class]];
    
}

- (void)createDataWithURL:(NSString *)url {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"PictureCategory.plist" ofType:nil];
    
    NSDictionary *rootDic = [NSDictionary dictionaryWithContentsOfFile:path];
    
    NSArray *array = rootDic[@"results"];
    
    for (NSDictionary *dict in array) {
        
        CategoryModel *model = [[CategoryModel alloc] init];
        
        [model setValuesForKeysWithDictionary:dict];
        
        [self.dataArray addObject:model];
        
    }
    
    [self.collectionView reloadData];
    
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataArray.count;
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    [collectionView registerClass:[CategoryCell class] forCellWithReuseIdentifier:@"PICTURE"];
    
    CategoryCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PICTURE" forIndexPath:indexPath];
    
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
    
    PictureCategoryVC *pcvc = [[PictureCategoryVC alloc] init];
    
    pcvc.categoryId = [self.dataArray[indexPath.row] valueForKey:@"categoryId"];
    
    pcvc.title = [self.dataArray[indexPath.row] valueForKey:@"name"];
    
    [self.navigationController pushViewController:pcvc animated:YES];
    
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
