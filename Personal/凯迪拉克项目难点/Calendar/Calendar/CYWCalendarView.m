//
//  CalendarView.m
//  Calendar
//
//  Created by vcyber on 17/5/16.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import "CYWCalendarView.h"
#import "Masonry.h"
#import "CYWCalendarCollectionViewCell.h"
#import "CYWCalendarCollectionViewFlowLayout.h"


@interface CYWCalendarView ()<UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray<CYWCalendarHeaderModel *> *dataArray;

@property (nonatomic, strong) UILabel *headerLabel;

@property (nonatomic, assign) CYWCalendarType type;

@end


@implementation CYWCalendarView


- (instancetype)initWithFrame:(CGRect)frame CalendarType:(CYWCalendarType)type
{
    self = [super initWithFrame:frame];
    if (self) {
        _type = type;
        [self createUI];
        [self initDataSourceWithType:type];
    }
    return self;
}


- (void)initDataSourceWithType:(CYWCalendarType)type
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        CYWCalendarManager *manager = [[CYWCalendarManager alloc] init];
        _dataArray = [manager getCalendarDataSourceWithType:type];
        dispatch_async(dispatch_get_main_queue(), ^{
            [_collectionView reloadData];
            _headerLabel.text = _dataArray[_dataArray.count - 1].headerText;
            if (type != CYWCalendarTypeOfYear) {
                [_collectionView setContentOffset:CGPointMake((_dataArray.count - 1) * _collectionView.frame.size.width, 0) animated:NO];
            }
        });
    });
}


- (void)createUI {
    
    _headerLabel = [[UILabel alloc] init];
    _headerLabel.font = [UIFont systemFontOfSize:15];
    _headerLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_headerLabel];
    [_headerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.top.mas_equalTo(self);
        make.height.mas_equalTo(_type == CYWCalendarTypeOfDay ? 40 : 80);
    }];
    
    NSInteger column = 7;
    NSInteger row = 6;
    if (_type == CYWCalendarTypeOfMonth) {
        column = 4;
        row = 4;
    }else if (_type == CYWCalendarTypeOfYear) {
        column = 2;
        row = 2;
    }
    
    CYWCalendarCollectionViewFlowLayout *layout = [[CYWCalendarCollectionViewFlowLayout alloc] init];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.column = column;
    CGFloat cellWidth = floor(self.frame.size.width / column);
    CGFloat cellHeight = floor((self.frame.size.height - 80) / row);
    layout.itemSize = CGSizeMake(cellWidth, cellHeight);
    CGFloat collectionViewWidth = column * cellWidth;
    CGFloat collectionViewHeight = row * cellHeight;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 80, collectionViewWidth, collectionViewHeight) collectionViewLayout:layout];
    _collectionView.pagingEnabled = YES;
    _collectionView.showsVerticalScrollIndicator = NO;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.bounces = NO;
    _collectionView.backgroundColor = [UIColor blackColor];
    _collectionView.layer.borderWidth = 1 / [UIScreen mainScreen].scale;
    [_collectionView registerClass:[CYWCalendarCollectionViewCell class] forCellWithReuseIdentifier:@"CELL"];
    [self addSubview:_collectionView];
    
    if (_type == CYWCalendarTypeOfDay) {
        [self addWeakView];
    }
    self.frame = CGRectMake(self.frame.origin.x + (self.frame.size.width - self.collectionView.frame.size.width) / 2, self.frame.origin.y, self.collectionView.frame.size.width, self.collectionView.frame.size.height + 80);
}


- (void)addWeakView
{
    UIView *weekView = [[UIView alloc]initWithFrame:CGRectZero];
    weekView.backgroundColor = [UIColor yellowColor];
    [self addSubview:weekView];
    [weekView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.collectionView);
        make.right.mas_equalTo(self.collectionView);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(40);
    }];
    
    NSArray *weekArray = @[@"一",@"二",@"三",@"四",@"五",@"六", @"日"];
    CGFloat width = floor(self.frame.size.width / 7);
    
    for(int i = 0; i < 7;i++)
    {
        UILabel *weekLabel = [[UILabel alloc]initWithFrame:CGRectMake(i * width, 0, width, 40)];
        weekLabel.backgroundColor = [UIColor clearColor];
        weekLabel.text = weekArray[i];
        weekLabel.font = [UIFont boldSystemFontOfSize:16.0f];
        weekLabel.textAlignment = NSTextAlignmentCenter;
        if(i == 5 || i == 6)
        {
            weekLabel.textColor = [UIColor redColor];
        }
        else
        {
            weekLabel.textColor = [UIColor blackColor];
        }
        [weekView addSubview:weekLabel];
    }
}



#pragma mark --UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _dataArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [_dataArray[section].calendarItemArray count];
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CYWCalendarCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    __weak typeof(self)weakSelf = self;
    cell.selectDateCallBack = ^(CYWCalendarModel *model) {
        if (weakSelf.selectDateModelCallBack) {
            weakSelf.selectDateModelCallBack(model);
        }
    };
    CYWCalendarModel *model = self.dataArray[indexPath.section].calendarItemArray[indexPath.row];
    cell.model = model;
    return cell;
}


- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    CGFloat offsetX = scrollView.contentOffset.x;
    int index = (int)(offsetX / scrollView.frame.size.width);
    _headerLabel.text = _dataArray[index].headerText;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
