//
//  ChartBarView.m
//  Record
//
//  Created by vcyber on 16/12/29.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "ChartBarView.h"
#import "MyLayout.h"
#import "Masonry.h"
#import "MJRefresh.h"

#define DEFAULT_WIDTH 20
#define TEXT_HEIGHT 20
#define CELL_WIDTH 30

#define REFRSHCONTROL_WIDTH 60

@interface ChartBarView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UIScrollViewDelegate>{
    NSThread *checkShowThread;
    UIView *headerView;
}

@property (nonatomic, strong) UICollectionView *collectionView;

@property (nonatomic, strong) CustomCollectionCell *recodeCell;

@property (nonatomic, strong) NSIndexPath *selectIndexPath;

@property (nonatomic, assign) BOOL isRefresh;

@end

@implementation ChartBarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 0.0;
        self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        self.collectionView.backgroundColor = [UIColor purpleColor];
        self.collectionView.showsHorizontalScrollIndicator = NO;
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        [self.collectionView registerClass:[CustomCollectionCell class] forCellWithReuseIdentifier:@"CELL"];
        [self addSubview:self.collectionView];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.right.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
        }];
        
//        headerView = nil;
        headerView = [[UIView alloc] initWithFrame:CGRectZero];
        headerView.backgroundColor = [UIColor yellowColor];
        [self.collectionView addSubview:headerView];
        [headerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(-REFRSHCONTROL_WIDTH);
            make.top.mas_equalTo(0);
            make.width.mas_equalTo(REFRSHCONTROL_WIDTH);
            make.height.mas_equalTo(self.collectionView);
        }];
        _dateLabel = [[UILabel alloc] init];
        _dateLabel.text = @"2016/12/12";
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        _dateLabel.hidden = NO;
        _dateLabel.textColor = [UIColor whiteColor];
        _dateLabel.font = [UIFont systemFontOfSize:12];
        [self addSubview:_dateLabel];
        [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.width.mas_equalTo(80);
            make.height.mas_equalTo(TEXT_HEIGHT);
            make.bottom.mas_equalTo(0);
        }];

        checkShowThread = [[NSThread alloc] initWithTarget:self selector:@selector(checkViewShow) object:nil];
        [checkShowThread start];
        
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
}

- (void)checkViewShow{
    while (1) {
        if (self.window != nil) {
            break;
        }
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self scrollToEnd];
    });
    [checkShowThread cancel];
    checkShowThread = nil;
}


- (void)scrollToEnd {
    [self.collectionView setContentOffset:CGPointMake(self.collectionView.contentSize.width - self.frame.size.width, 0)];
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.ItemArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    CustomCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CELL" forIndexPath:indexPath];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    CustomCollectionCell *customCell = (CustomCollectionCell *)cell;
    ChartsModel *model = self.ItemArray[indexPath.row];
    if (indexPath.row == self.ItemArray.count - 1) {
        self.selectIndexPath = indexPath;
    }
    ChartsModel *nextModel = nil;
    ChartsModel *lastModel = nil;
    if (indexPath.row < self.ItemArray.count - 1) {
        nextModel = self.ItemArray[indexPath.row + 1];
    }
    if(indexPath.row != 0){
        lastModel = self.ItemArray[indexPath.row - 1];
    }
    [customCell configCellWithLastModel:lastModel Model:model NextModel:nextModel];
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(CELL_WIDTH, collectionView.frame.size.height);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, self.frame.size.width / 2  - CELL_WIDTH / 2, 0, self.frame.size.width / 2  - CELL_WIDTH / 2);
}




- (void)setItemArray:(NSArray *)ItemArray {
    _ItemArray = ItemArray;
    [self.collectionView reloadData];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat width = self.frame.size.width / 2.0 + scrollView.contentOffset.x;
    CGPoint point = CGPointMake(width, 10);
    NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:point];
    if (indexPath == nil) {
        return;
    }
    if (indexPath.row != self.selectIndexPath.row || self.selectIndexPath == nil) {
        ChartsModel *selectModel = self.ItemArray[indexPath.row];
        selectModel.isRed = YES;
        if (self.selectIndexPath == nil) {
            [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
        }else {
            ChartsModel *model = self.ItemArray[self.selectIndexPath.row];
            model.isRed = NO;
            _dateLabel.text = model.date;
            [self.collectionView reloadItemsAtIndexPaths:@[self.selectIndexPath, indexPath]];
        }
        
        self.selectIndexPath = indexPath;
    }
    
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {

    if (scrollView.contentOffset.x <= -REFRSHCONTROL_WIDTH && !self.isRefresh && !scrollView.isDragging) {
        self.isRefresh = YES;
        dispatch_async(dispatch_get_main_queue(), ^{
            [UIView animateWithDuration:0.25 animations:^{
                UIEdgeInsets inset = scrollView.contentInset;
                inset.left += REFRSHCONTROL_WIDTH;
                scrollView.contentInset = inset;
            } completion:^(BOOL finished) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if (self.getMore) {
                        if (self.selectIndexPath) {
                            ChartsModel *model = self.ItemArray[self.selectIndexPath.row];
                            model.isRed = NO;
                        }
                        self.getMore();
                    }
                });
            }];
            
        });
    }
}




- (void)endRefresh {
    [UIView animateWithDuration:0.25 animations:^{
        UIEdgeInsets inset = self.collectionView.contentInset;
        inset.left -= REFRSHCONTROL_WIDTH;
        self.collectionView.contentInset = inset;
    }];
    self.isRefresh = NO;
}




/*// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
   
}
*/

@end


@interface CustomCollectionCell ()

@property (nonatomic, strong) ColorfulLabel *heightLabel;
@property (nonatomic, strong) UILabel *countLabel;

@property (nonatomic, strong) CAShapeLayer *lineLayer;
@property (nonatomic, assign) CGPoint startPoint;
@property (nonatomic, assign) CGPoint centerPoint;
@property (nonatomic, assign) CGPoint endPoint;


@property (nonatomic, strong) ChartsModel *model;
@property (nonatomic, strong) ChartsModel *nextModel;

@end

@implementation CustomCollectionCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.heightLabel = [[ColorfulLabel alloc] initWithFrame:CGRectMake((self.frame.size.width - DEFAULT_WIDTH) / 2, TEXT_HEIGHT, DEFAULT_WIDTH, self.frame.size.height - TEXT_HEIGHT * 2)];
        self.heightLabel.layer.cornerRadius = DEFAULT_WIDTH / 2;
        self.heightLabel.layer.masksToBounds = YES;
        self.heightLabel.backgroundColor = [UIColor greenColor];
        [self.contentView addSubview:self.heightLabel];
        
        self.countLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.heightLabel.frame.origin.y - TEXT_HEIGHT, self.frame.size.width, TEXT_HEIGHT)];
        self.countLabel.text = @"9999";
        self.countLabel.hidden = YES;
        self.countLabel.textAlignment= NSTextAlignmentCenter;
        self.countLabel.textColor = [UIColor whiteColor];
        self.countLabel.font = [UIFont systemFontOfSize:10];
        self.lineLayer = [CAShapeLayer layer];
        self.lineLayer.lineWidth = 1;
        self.lineLayer.strokeColor = [UIColor yellowColor].CGColor;
        self.lineLayer.fillColor = [UIColor clearColor].CGColor;
        [self.contentView addSubview:self.countLabel];
    }
    return self;
}


- (void)configCellWithLastModel:(ChartsModel *)lastModel Model:(ChartsModel *)model NextModel:(ChartsModel *)nextModel {
    
    if (model.isRed) {
        self.heightLabel.backgroundColor = [UIColor redColor];
    }else {
        self.heightLabel.backgroundColor = [UIColor greenColor];
    }
    self.countLabel.hidden = !model.isRed;
    self.countLabel.text = model.num;
    
    CGFloat labelHeight = model.numH;
    self.heightLabel.frame = CGRectMake(self.heightLabel.frame.origin.x, self.frame.size.height - labelHeight - TEXT_HEIGHT, DEFAULT_WIDTH, labelHeight);
    self.countLabel.frame = CGRectMake(self.countLabel.frame.origin.x, self.heightLabel.frame.origin.y - TEXT_HEIGHT, self.countLabel.frame.size.width, self.countLabel.frame.size.height);
    
    
    CGFloat lastheight = lastModel.avgH;
    CGFloat height = model.avgH;
    CGFloat nextHeigth = nextModel.avgH;
    CGFloat centerX = self.frame.size.width / 2;
    CGFloat endX = self.frame.size.width;
    
    CGFloat cur_last_Y = height- lastheight;
    CGFloat next_cur_Y = nextHeigth - height;
    
    self.centerPoint = CGPointMake(centerX, height);
    if (lastModel) {
        self.startPoint = CGPointMake(0, height - cur_last_Y / 2);
    }else {
        self.startPoint = self.centerPoint;
    }
    
    if (nextModel) {
        self.endPoint = CGPointMake(endX, height + next_cur_Y / 2);
    }else {
        self.endPoint = self.centerPoint;
    }

    UIBezierPath *linePath = [UIBezierPath bezierPath];
    // 起点
    [linePath moveToPoint:self.startPoint];
    //中间点
    [linePath addLineToPoint:self.centerPoint];
    // 中点
    [linePath addLineToPoint:self.endPoint];
    self.lineLayer.path = linePath.CGPath;
    [self.contentView.layer addSublayer:self.lineLayer];
}


@end
