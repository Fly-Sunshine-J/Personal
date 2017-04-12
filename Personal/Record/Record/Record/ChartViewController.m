//
//  ChartViewController.m
//  Record
//
//  Created by vcyber on 16/12/29.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "ChartViewController.h"
#import "ChartBarView.h"
#import "Masonry.h"
#import "MJRefresh.h"
#import "XZMRefresh.h"
#import "Record-Bridging-Header.h"
#import "ChartsModel.h"

@interface ChartViewController ()<ChartViewDelegate>{
    ChartBarView *barView;
}

@property (nonatomic, strong)  BarChartView *chartView;

@end

@implementation ChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];

    
    [self customCharts];
}


- (void)charts {
    _chartView = [[BarChartView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    [self.view addSubview:_chartView];
    _chartView.descriptionText = @"天";
    _chartView.noDataText = @"暂无数据";
//    _chartView.drawGridBackgroundEnabled = NO;
    _chartView.doubleTapToZoomEnabled = NO;
    _chartView.dragEnabled = YES;
    _chartView.drawBarShadowEnabled = NO;
    _chartView.drawValueAboveBarEnabled = YES;
    
    _chartView.maxVisibleCount = 10;
//    _chartView.drawValueAboveBarEnabled = YES;
    _chartView.delegate = self;
    
    
    ChartXAxis *xAxis = _chartView.xAxis;
    xAxis.labelPosition = XAxisLabelPositionBottom;
    xAxis.labelFont = [UIFont systemFontOfSize:10];
    xAxis.drawGridLinesEnabled = NO;
//    xAxis.valueFormatter = [[DayAxisValueFormatter alloc] initForChart:_chartView];
    
    
    NSMutableArray *yValues = [NSMutableArray array];
    for (int i = 0; i < 40; i++) {
        double mult = 100;
        double val = (double)(arc4random_uniform(mult));
        [yValues addObject:[[BarChartDataEntry alloc] initWithX:(double)i y:val]];
    }
    BarChartDataSet *set = nil;
    if (_chartView.data.dataSetCount > 0) {
        set = (BarChartDataSet *)_chartView.data.dataSets[0];
        set.values = yValues;
        [_chartView.data notifyDataChanged];
        [_chartView notifyDataSetChanged];
    }else {
        set = [[BarChartDataSet alloc] initWithValues:yValues label:nil];
        [set setColors:@[[UIColor redColor]]];
        NSMutableArray *dataSets = [NSMutableArray array];
        [dataSets addObject:set];
        BarChartData *data = [[BarChartData alloc] initWithDataSets:dataSets];
        [data setValueFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:10.f]];
        data.barWidth = 0.9;
        _chartView.data = data;
    }
    
}



- (void)customCharts {
    barView = [[ChartBarView alloc] initWithFrame:CGRectZero];
    NSMutableArray *array = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Charts" ofType:@"plist"]];
    NSMutableArray *dataArray = [NSMutableArray array];
    for (NSDictionary *dict in array) {
        ChartsModel *model = [ChartsModel modelWithDictionary:dict];
        [dataArray addObject:model];
    }
    barView.ItemArray = dataArray;
    [self.view addSubview:barView];
    [barView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(0);
        make.height.mas_equalTo(200);
    }];
    
    __weak typeof(barView)headerView = barView;
    barView.getMore = ^() {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            for (int i =0; i < 6; i++) {
                NSDictionary *dict = [NSDictionary dictionaryWithObjects:@[[NSString stringWithFormat:@"2017/07/%d", arc4random() % 31 + 1], [NSString stringWithFormat:@"%d", arc4random() % 100 + 1], [NSString stringWithFormat:@"%d", arc4random() % 80 + 1]] forKeys:@[@"date", @"num", @"avg"]];
                ChartsModel *model = [ChartsModel modelWithDictionary:dict];
                [dataArray insertObject:model atIndex:0];
            }
            ChartsModel *model = dataArray.firstObject;
            model.isRed = YES;
            headerView.dateLabel.text = model.date;
            headerView.ItemArray = dataArray;
            [headerView endRefresh];
        });
    };
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
