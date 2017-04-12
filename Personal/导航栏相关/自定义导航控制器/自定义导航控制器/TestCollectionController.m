//
//  TestCollectionController.m
//  自定义导航控制器
//
//  Created by HelloYeah on 16/3/12.
//  Copyright © 2016年 HelloYeah. All rights reserved.
//

#import "TestCollectionController.h"
#import "UIViewController+NavBarHidden.h"

@interface TestCollectionController ()<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,weak) UICollectionView * collectionView;

@end

@implementation TestCollectionController

-(void)viewDidLoad{
    
    [super viewDidLoad];

    //1.设置当有导航栏自动添加64的高度的属性为NO
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    //2.设置导航条内容
    [self setUpNavBar];
    
    [self setUpCollectionView];
    
    [self setKeyScrollView:self.collectionView scrolOffsetY:600 options:HYHidenControlOptionTitle | HYHidenControlOptionLeft];
    
}



#pragma mark - UI设置

- (void)setUpNavBar{

    UIButton * addBtn = [UIButton buttonWithType:UIButtonTypeContactAdd];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:addBtn];
    UILabel * titleLabel =[[UILabel alloc]init];
    titleLabel.text = @"HelloYeah";
    [titleLabel sizeToFit];
    titleLabel.textColor = [UIColor redColor];
    self.navigationItem.titleView = titleLabel;
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"2.jpg"] forBarMetrics:UIBarMetricsDefault];
}


//初始化CollectionView
- (void)setUpCollectionView{
    
    //创建CollectionView
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc]init];
    UICollectionView * collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];;
    
    //设置item属性
    layout.itemSize = CGSizeMake(self.view.bounds.size.width * 0.4, 200);
    layout.minimumInteritemSpacing = 20;
    layout.sectionInset = UIEdgeInsetsMake(270, 20, 20, 20);
    
    collectionView.backgroundColor = [UIColor whiteColor];
   
    //添加到控制器上
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    
    [self setHeaderView];
    
    
    collectionView.dataSource = self;
    //成为collectionView代理,监听滚动.
    collectionView.delegate = self;
    //注册cell
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"test"];
        
}



//设置头部视图
- (void)setHeaderView{

    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"1.jpg" ofType:nil];
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfFile:filePath]];
    UIImageView * imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.collectionView.frame.size.width, 250)];
    imageView.image = image;
    
    imageView.backgroundColor = [UIColor redColor];

    [self.collectionView addSubview:imageView];
}


#pragma mark - 数据源方法

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    return 20;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"test" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor orangeColor];
    
    return cell;
    
}

@end
