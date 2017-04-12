//
//  PictureRootVC.m
//  ComicAndPicture
//
//  Created by MS on 16/3/8.
//  Copyright © 2016年 JFY. All rights reserved.
//

#import "PictureRootVC.h"
#import "PictureModel.h"
#import "PictureCell.h"
#import "ShowViewController.h"
#import <MMProgressHUD.h>
#import "NSString+URLCode.h"

@interface PictureRootVC (){
    
    BOOL _flag;
    
}

@end

@implementation PictureRootVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.page_num = 0;
    
    self.dataArray = [NSMutableArray array];
    
    [self createCollectionViewWithReuseIdentifier:@"ID" AndClass:[PictureCell class]];
    
    [self createRefreshWith:20];
    
}

- (void)createRefreshWith:(int)page {
    
    MJRefreshGifHeader *header = [MJRefreshGifHeader headerWithRefreshingBlock:^{
        
        self.page_num = 0;
        
        self.isPulling = YES;
        
        [self createDataWithURL:[NSString stringWithFormat:self.url, self.categoryId, self.page_num]];
        
    }];
    
    NSArray *images = @[[UIImage imageNamed:@"common_loading_anne_0"], [UIImage imageNamed:@"common_loading_anne_1"]];
    
    [header setImages:@[[UIImage imageNamed:@"common_loading_anne_0"]] forState:MJRefreshStateIdle];
    
    [header setImages:images forState:MJRefreshStateRefreshing];
    
    [header setImages:@[[UIImage imageNamed:@"common_loading_anne_1"]] forState:MJRefreshStatePulling];
    
    self.collectionView.mj_header = header;
    
    
    MJRefreshAutoGifFooter *footer = [MJRefreshAutoGifFooter footerWithRefreshingBlock:^{
        
        self.page_num += page;
        
        self.isPulling = NO;
        
        [self createDataWithURL:[NSString stringWithFormat:self.url, self.categoryId, self.page_num]];
        
    }];
    
    [footer setImages:@[[UIImage imageNamed:@"common_loading_anne_0"]] forState:MJRefreshStateIdle];
    
    [footer setImages:images forState:MJRefreshStateRefreshing];
    
    [footer setImages:@[[UIImage imageNamed:@"common_loading_anne_1"]] forState:MJRefreshStatePulling];
    
    self.collectionView.mj_footer = footer;
    
}

- (void)createCollectionViewWithReuseIdentifier:(NSString *)identifier AndClass:(__unsafe_unretained Class)registeClass {
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 64 - 44) collectionViewLayout:layout];
    
   self.collectionView.delegate = self;
    
    self.collectionView.dataSource = self;
    
    self.collectionView.showsVerticalScrollIndicator = NO;
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.collectionView registerClass:registeClass forCellWithReuseIdentifier:identifier];
    
    [self.view addSubview:self.collectionView];
    
}


- (void)createDataWithURL:(NSString *)urlString{
    
    [MMProgressHUD showWithTitle:@"努力加载中" status:@"努力加载中" images:@[[UIImage imageNamed:@"loading_teemo_1"], [UIImage imageNamed:@"loading_teemo_2"]]];
    
    [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleShrink];
    
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:urlString parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        _flag = YES;
        
        NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
        
        NSArray *array = rootDic[@"list"];
        
        if (array.count > 0) {
        
        if (self.isPulling) {
            
            [self.dataArray removeAllObjects];
            
        }
        
        for (NSDictionary *dict in array) {
            
            PictureModel *model = [[PictureModel alloc] init];
            
            [model setValuesForKeysWithDictionary:dict];
            
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
        
        _flag = YES;
        
        [MMProgressHUD dismissWithError:error.localizedDescription afterDelay:2];
        
        [self.collectionView.mj_footer endRefreshing];
        
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


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.dataArray.count;
    
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    PictureCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ID" forIndexPath:indexPath];
    
    PictureModel *model = self.dataArray[indexPath.row];
    
    [cell.picView sd_setImageWithURL:[NSURL URLWithString:model.qhimg_thumb_url] placeholderImage:[UIImage imageNamed:@"default_image"]];
    
    cell.countLabel.text = [NSString stringWithFormat:@"【%@】", model.total_count];
    
    return cell;
    
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    return CGSizeMake(WIDTH / 2 - 0.5, WIDTH / 2 - 0.5);
    
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 1;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    
    return 1;
    
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ShowViewController *show = [[ShowViewController alloc] init];
    
    show.group_id = [self.dataArray[indexPath.row] valueForKey:@"pic_id"];
    
    if ([self.title isEqualToString:@"最新"]) {
        show.category = @"new";
    }else {
        
        show.category = @"hot";
        
    }
    
    [self.navigationController pushViewController:show animated:YES];
    
}


- (void)createBackButton {
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    leftBtn.frame = CGRectMake(0, 0, 30, 30);
    
    [leftBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    
    [leftBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    
}


- (void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
    
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
