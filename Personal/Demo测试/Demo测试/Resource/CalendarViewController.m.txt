//
//  CalendarViewController.m
//  Demo测试
//
//  Created by vcyber on 16/7/1.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "CalendarViewController.h"
#import "CalendarMonthLayout.h"
#import "CalendarDayModel.h"
#import "CalendarLogic.h"
#import "CalendarDayCell.h"
#import "CalendarMonthHeaderView.h"
#import "NSDate+CalendarLogic.h"

@interface CalendarViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSTimer *timer;

@end

NSString *const MonthHeader = @"HeaderView";
NSString *const DayCell = @"DayCell";

@implementation CalendarViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initView];
        [self initDate];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}


- (void)initView {
    
    [self setTitle:@"日期选择"];
    
    CalendarMonthLayout *layout = [[CalendarMonthLayout alloc] init];
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    
    [self.collectionView registerClass:[CalendarDayCell class] forCellWithReuseIdentifier:DayCell];
    [self.collectionView registerClass:[CalendarMonthHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:MonthHeader];
    
    [self.view addSubview:self.collectionView];
}


- (void)initDate {
    self.calendarMonths = [NSMutableArray array];
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return self.calendarMonths.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSMutableArray *monthArray = [self.calendarMonths objectAtIndex:section];
    
    return monthArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CalendarDayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:DayCell forIndexPath:indexPath];
    NSMutableArray *monthArray = self.calendarMonths[indexPath.section];
    CalendarDayModel *model = monthArray[indexPath.row];
    cell.model = model;
    return cell;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    UICollectionReusableView *reusableView = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        NSMutableArray *month_array = [self.calendarMonths objectAtIndex:indexPath.section];
        CalendarDayModel *model = [month_array objectAtIndex:15];
        CalendarMonthHeaderView *monthView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:MonthHeader forIndexPath:indexPath];
        monthView.masterLabel.text = [NSString stringWithFormat:@"%zd年 %zd月", model.year, model.month];
        monthView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
        reusableView = monthView;
    }
    return reusableView;
}


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSMutableArray *month_Array = self.calendarMonths[indexPath.section];
    CalendarDayModel *model = month_Array[indexPath.row];
    
    if (model.type == CellDayTypeFuture || model.type == CellDayTypeWeek || model.type == CellDayTypeSelected) {
        [self.logic selectLogic:model];
        if (self.calendarBlock) {
            self.calendarBlock(model);
            [self.navigationController popViewControllerAnimated:YES];
        }
        [collectionView reloadData];
    }
    
}


- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
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
