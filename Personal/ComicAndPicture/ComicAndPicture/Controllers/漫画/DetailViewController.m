//
//  DetailViewController.m
//  ComicAndPicture
//
//  Created by MS on 16/3/9.
//  Copyright © 2016年 JFY. All rights reserved.
//

#import "DetailViewController.h"
#import <SDImageCache.h>
#import "ComicModel.h"
#import "ComicItemView.h"
#import <AFNetworking.h>
#import "LookComicViewController.h"
#import <MMProgressHUD.h>
#import "RecordManager.h"

@interface DetailViewController ()<ComicItemViewDelegate, LookComicViewController>{
    
    UIView *_whiteView;
    
    UILabel *_recentLabel;
    
    UILabel *_detailLabel;
    
    ComicItemView *_itemView;
    
    NSMutableArray *_dataArray;
    
    UIButton *_readBtn;
    
    NSInteger _tag;
    
    BOOL _flag;
    
    NSString *_nextChapterId;
    
    NSMutableArray *_data;
    
    NSInteger num;
    
    NSMutableArray *_dataDownload;
    
    NSInteger dataSize;
}

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    _tag = [[[RecordManager defaultManager] searchTagWithModelId:self.model.comicId IsRead:YES] integerValue];
    
    [self createNavBar];
    
    [self createUI];
    
    [self createData];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.hidden = YES;
    
    self.navigationController.navigationBarHidden = NO;
    
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;

    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    
}


- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    self.tabBarController.tabBar.hidden = NO;
    
    self.navigationController.navigationBarHidden = YES;
    
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    
}

- (void)createData {
    
    _dataArray = [NSMutableArray array];
    
    if (self.downloaded) {
        
        _dataArray = [NSKeyedUnarchiver unarchiveObjectWithData:self.model.data];
        
        [self createItemViewWithItems:_dataArray.count];
        
        
    }else {
        
        [MMProgressHUD showWithTitle:@"努力加载中" status:@"努力加载中" images:@[[UIImage imageNamed:@"loading_teemo_1"], [UIImage imageNamed:@"loading_teemo_2"]]];
        
        [MMProgressHUD setPresentationStyle:MMProgressHUDPresentationStyleShrink];
        
        
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
        [manager GET:[NSString stringWithFormat:DETAIL_URL, self.model.comicId] parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            
            _flag = YES;
            
            NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            
            NSDictionary *resultDict = rootDic[@"results"];
            
            NSArray *listArray = resultDict[@"cartoonChapterList"];
            
            self.model.totalCartoonSize = resultDict[@"totalCartoonSize"];
            
            for (NSDictionary *dict in listArray) {
                
                [_dataArray addObject:dict];
                
            }
            
            _recentLabel.text = [NSString stringWithFormat:@"最近更新时间: %@", resultDict[@"recentUpdateTime"]];
            
            [self createItemViewWithItems:[resultDict[@"cartoonChapterCount"] integerValue]];
            
            [MMProgressHUD dismissWithSuccess:@"加载完成"];
            
        } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
            
            _flag = YES;
            
            [MMProgressHUD dismissWithError:error.localizedDescription afterDelay:2];
            
        }];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            if (!_flag) {
                
                [MMProgressHUD dismissWithError:@"网络较慢,请耐心等待一会"];
            }
            
        });
        
    }
    
}


- (void)createItemViewWithItems:(NSInteger)items {
    
    _itemView = [[ComicItemView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_detailLabel.frame) + 10, WIDTH, _whiteView.frame.size.height - CGRectGetMaxY(_detailLabel.frame) - 15) AndWithItems:items];
    
    _itemView.contentSize = CGSizeMake(WIDTH, items / 4 * 45 + 50);
    
    _itemView.showsHorizontalScrollIndicator = NO;
    
    _itemView.myDelegate = self;
    
    [_whiteView addSubview:_itemView];
    
    if (self.model.tag) {
        
        [self recordItemWithTag:[[[RecordManager defaultManager] searchTagWithModelId:self.model.comicId IsRead:YES] integerValue]];
        
    }
    
}

- (void)clickComicItemWithTag:(NSInteger)tag {
    
    LookComicViewController *look = [[LookComicViewController alloc] init];
    
    look.tag = tag;
    
    UIButton *btn = [self.view viewWithTag:1000 + _tag];
    
    btn.selected = NO;
    
    _tag = tag;
    
    look.comicArray = _dataArray;
    
    look.downloaded = self.downloaded;
    
    look.delegate = self;
    
    [self.navigationController pushViewController:look animated:YES];
    
    self.model.tag = tag;
    
    self.model.read = YES;
    
    self.model.collection = NO;
    
    self.model.download = NO;
    
    self.model.data = nil;
    
    if ([[RecordManager defaultManager] searchDataWithModelId:self.model.comicId IsRead:YES]) {
        
        [[RecordManager defaultManager] modifyModelByModelId:self.model.comicId Model:self.model IsRead:YES];
        
    }else {
        
        [[RecordManager defaultManager] insertDataWithModel:self.model];
        
    }
}


- (void)createNavBar {
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    leftBtn.frame = CGRectMake(0, 0, 30, 30);
    
    [leftBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    
    [leftBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    rightBtn.frame = CGRectMake(0, 0, 30, 30);
    
    [rightBtn setImage:[UIImage imageNamed:@"download"] forState:UIControlStateNormal];
    
    [rightBtn addTarget:self action:@selector(download:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
    
    self.navigationItem.rightBarButtonItem = rightItem;

    self.navigationItem.rightBarButtonItem.enabled = ![[RecordManager defaultManager] searchDataWithModelId:self.model.comicId IsDownload:YES];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 400)];
    
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    imageView.clipsToBounds = YES;
    
    imageView.image = [[SDImageCache sharedImageCache] imageFromMemoryCacheForKey:self.model.comicId];
    
    imageView.alpha = 0.2;
    
    [self.view addSubview:imageView];
    
}


- (void)download:(UIButton *)btn {
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
    
    self.model.collection = NO;
    
    self.model.read = NO;
    
    self.model.download = NO;
    
    self.model.downloading = YES;
    
    [[RecordManager defaultManager] insertDataWithModel:self.model];

    NSString *url = [NSString stringWithFormat:DOWNLOAD_URL, _dataArray[0][@"id"]];
    
    _dataDownload = [NSMutableArray array];
    
    [self getNextChapterId:url];
    
    [MMProgressHUD showWithStatus:[NSString stringWithFormat:@"%@开始下载", self.model.name]];
    
    [MMProgressHUD dismissWithSuccess:nil title:nil afterDelay:1];

}

- (void)getNextChapterId:(NSString *)url {

    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
        
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
            
        NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil];
            
        NSArray *array = rootDic[@"results"];
        
        _nextChapterId = rootDic[@"extraInfo"][@"nextChapterId"];
        
        num = 0;
        
        _data = [NSMutableArray array];
       
        for (NSDictionary *dict in array) {
            
            NSMutableDictionary *dataDict = [NSMutableDictionary dictionaryWithObjects:@[dict[@"images"], dict[@"imgWidth"], dict[@"imgHeight"]] forKeys:@[@"images", @"imgWidth", @"imgHeight"]];
            
            [_data addObject:dataDict];
            
        }
            
        [self downloadData];
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
            
            
    }];
}


- (void)downloadData {
    
    NSString *url = _data[num][@"images"];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation * _Nonnull operation, id  _Nonnull responseObject) {
        
        [_data[num] setValue:responseObject forKey:@"images"];
        
        num++;
        
        dataSize += [responseObject length];
        
        float progress = dataSize / [self.model.totalCartoonSize floatValue];
        
        self.model.progress = progress;
        
        [[NSNotificationCenter defaultCenter] postNotificationName:self.model.comicId object:self.model];
        
        if (num == _data.count) {
            
            [_dataDownload addObject:_data];
            
            if ([_nextChapterId isKindOfClass:[NSNull class]]) {
                
                NSData *data = [NSKeyedArchiver archivedDataWithRootObject:_dataDownload];
                
                self.model.collection = NO;
                
                self.model.read = NO;
                
                self.model.download = YES;
                
                self.model.downloading = NO;
                
                self.model.data = data;
                
                if ([[RecordManager defaultManager] searchDataWithModelId:self.model.comicId Downloading:YES]) {
                    
                    [[RecordManager defaultManager] deleteDataWithModelId:self.model.comicId Downloading:YES];
                }
                
                [[RecordManager defaultManager] insertDataWithModel:self.model];
                
                [MMProgressHUD showWithStatus:[NSString stringWithFormat:@"%@下载完成,可在已下载中阅读", self.model.name]];
                
                [MMProgressHUD dismissWithSuccess:nil title:nil afterDelay:1];
                
                return;
            }
            
            [self getNextChapterId:[NSString stringWithFormat:DOWNLOAD_URL, _nextChapterId]];

            return;
            
        }

        [self downloadData];
        
    } failure:^(AFHTTPRequestOperation * _Nullable operation, NSError * _Nonnull error) {
        
        
    }];
    
}


- (void)back {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


- (void)createUI {
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 80, 105, 138)];
    
    imageView.layer.cornerRadius = 5;
    
    imageView.layer.masksToBounds = YES;
    
    imageView.image = [[SDImageCache sharedImageCache] imageFromMemoryCacheForKey:self.model.comicId];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame) + 5, 80, WIDTH - CGRectGetMaxX(imageView.frame) - 5, 20)];
    
    titleLabel.text = self.model.name;
    
    titleLabel.textColor = [UIColor whiteColor];
    
    UILabel *authorLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame) + 5, CGRectGetMaxY(titleLabel.frame) + 10, WIDTH - CGRectGetMaxX(imageView.frame) - 5, 20)];
    
    authorLabel.text = [NSString stringWithFormat:@"作者: %@", self.model.author];
    
    authorLabel.font = [UIFont systemFontOfSize:14];
    
    authorLabel.textColor = [UIColor colorWithWhite:0.7 alpha:1];
    
     _recentLabel= [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame) + 5, CGRectGetMaxY(authorLabel.frame) + 20, WIDTH - CGRectGetMaxX(imageView.frame) - 5, 20)];
    
    _recentLabel.text = @"最近更新时间: ";
    
    _recentLabel.font = [UIFont systemFontOfSize:12];
    
    _recentLabel.textColor = [UIColor redColor];
    
    _whiteView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_recentLabel.frame) + 15, WIDTH, HEIGHT - CGRectGetMaxY(_recentLabel.frame) - 5)];
    
    _whiteView.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:_whiteView];
    
    [self.view addSubview:imageView];
    
    [self.view addSubview:titleLabel];
    
    [self.view addSubview:authorLabel];
    
    [self.view addSubview:_recentLabel];
    
    UIButton *collectionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    collectionBtn.frame = CGRectMake(CGRectGetMaxX(imageView.frame) + 5, 5, (WIDTH - CGRectGetMaxX(imageView.frame) - 15) / 2, 30);
    
    [collectionBtn setImage:[UIImage imageNamed:@"star2_Gray"] forState:UIControlStateNormal];
    
    [collectionBtn setImage:[UIImage imageNamed:@"star_icon"] forState:UIControlStateSelected];
    
    [collectionBtn setTitle:@"加入收藏" forState:UIControlStateNormal];
    
    [collectionBtn setTitle:@"取消收藏" forState:UIControlStateSelected];
    
    [collectionBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    collectionBtn.selected = [[RecordManager defaultManager] searchDataWithModelId:self.model.comicId IsCollection:YES];
    
    collectionBtn.layer.borderWidth = 1;
    
    collectionBtn.layer.cornerRadius = 5;
    
    collectionBtn.layer.masksToBounds = YES;
    
    [collectionBtn addTarget:self action:@selector(collected:) forControlEvents:UIControlEventTouchUpInside];
    
    [_whiteView addSubview:collectionBtn];
    
    
    _readBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    _readBtn.frame = CGRectMake(CGRectGetMaxX(collectionBtn.frame) + 5, 5, (WIDTH - CGRectGetMaxX(imageView.frame) - 15) / 2, 30);
    
    [_readBtn setTitle:@"开始阅读" forState:UIControlStateNormal];
    
    [_readBtn setTitle:@"继续阅读" forState:UIControlStateSelected];
    
     _readBtn.selected = [[RecordManager defaultManager] searchDataWithModelId:self.model.comicId IsRead:YES];
    
    [_readBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    _readBtn.backgroundColor = [UIColor colorWithRed:1 green:0 blue:127 / 255.0 alpha:1];
    
    _readBtn.layer.cornerRadius = 5;
    
    _readBtn.layer.masksToBounds = YES;
    
    [_readBtn addTarget:self action:@selector(read:) forControlEvents:UIControlEventTouchUpInside];
    
    [_whiteView addSubview:_readBtn];
    
    _detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, CGRectGetMaxY(collectionBtn.frame) + 5, WIDTH - 10, 35)];
    
    _detailLabel.text = self.model.introduction;
    
    _detailLabel.font = [UIFont systemFontOfSize:14];
    
    _detailLabel.numberOfLines = 0;
    
    [_whiteView addSubview:_detailLabel];
    
    UIButton *expandBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    expandBtn.frame = CGRectMake(WIDTH - 20, CGRectGetMaxY(_detailLabel.frame), 15, 8);
    
    [expandBtn setImage:[UIImage imageNamed:@"xialaDetail"] forState:UIControlStateNormal];
    
    [expandBtn setImage:[UIImage imageNamed:@"shouqiDetail"] forState:UIControlStateSelected];
    
    [expandBtn addTarget:self action:@selector(expand:) forControlEvents:UIControlEventTouchUpInside];
    
    [_whiteView addSubview:expandBtn];
}

- (void)expand:(UIButton *)btn {
    
    CGFloat y = _detailLabel.frame.origin.y;
    
    if (btn.selected == NO) {
        
        btn.selected = YES;
        
        CGRect rect = [self.model.introduction boundingRectWithSize:CGSizeMake(WIDTH - 10, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil];

        _detailLabel.frame = CGRectMake(5, y, WIDTH - 10, rect.size.height);
        
    }else {
        
        btn.selected = NO;
        
        _detailLabel.frame = CGRectMake(5, y, WIDTH - 10, 35);
        
    }
    
    btn.frame = CGRectMake(WIDTH - 20, CGRectGetMaxY(_detailLabel.frame), 15, 8);
    
    _itemView.frame = CGRectMake(0, CGRectGetMaxY(btn.frame) + 10, WIDTH, HEIGHT - CGRectGetMaxY(btn.frame) - 10);
    
}



- (void)collected:(UIButton *)btn {
    
    if (btn.selected) {
        
        //取消收藏
        
        btn.selected = NO;
        
        [[RecordManager defaultManager] deleteDataWithModelId:self.model.comicId IsCollection:YES];
        
    }else {
        
        //收藏
        
        btn.selected = YES;
        
        self.model.collection = YES;
        
        self.model.read = NO;
        
        self.model.download = NO;
        
        self.model.data = nil;
        
        [[RecordManager defaultManager] insertDataWithModel:self.model];

    }
    
}


- (void)read:(UIButton *)btn {
    
    LookComicViewController *look = [[LookComicViewController alloc] init];
    
    btn.selected = [[RecordManager defaultManager] searchDataWithModelId:self.model.comicId IsRead:YES];
    
    look.tag = _tag;
    
    self.model.tag = _tag;
    
    self.model.read = YES;
    
    self.model.collection = NO;
    
    self.model.download = NO;
    
    self.model.data = nil;
    
    look.comicArray = _dataArray;
    
    look.downloaded = self.downloaded;

    look.delegate = self;
    
    [self.navigationController pushViewController:look animated:YES];
    
    if ([[RecordManager defaultManager] searchDataWithModelId:self.model.comicId IsRead:YES]) {
        
        [[RecordManager defaultManager] modifyModelByModelId:self.model.comicId Model:self.model IsRead:YES];
        
    }else {
        
        [[RecordManager defaultManager] insertDataWithModel:self.model];
        
    }

}


- (void)recordItemWithTag:(NSInteger)tag {

    UIButton *button = (UIButton *)[self.view viewWithTag:1000 + _tag];
    
    button.selected = NO;
    
    _tag = tag;
    
    UIButton *btn = (UIButton *)[self.view viewWithTag:1000 + tag];
    
    btn.selected = YES;
    
    _readBtn.selected = YES;
    
    self.model.tag = _tag;
    
    self.model.collection = NO;
    
    self.model.read = YES;
    
    self.model.download = NO;
    
    self.model.data = nil;
    
    if ([[RecordManager defaultManager] searchDataWithModelId:self.model.comicId IsRead:YES]) {
        
        [[RecordManager defaultManager] modifyModelByModelId:self.model.comicId Model:self.model IsRead:YES];
        
    }else {
        
        [[RecordManager defaultManager] insertDataWithModel:self.model];
        
    }
    
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
