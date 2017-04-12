//
//  ViewController.m
//  Charts
//
//  Created by vcyber on 17/1/5.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import "ViewController.h"
#import "Charts-Bridging-Header.h"
#import "DayAxisValueFormatter.h"



@interface ViewController ()<IChartAxisValueFormatter, ChartViewDelegate, IChartHighlighter>

@property (nonatomic, strong) BarChartView *chartView;

@property (nonatomic, strong) NSArray *months;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _months = @[@"Jan", @"Feb", @"Mar", @"Apr", @"May", @"Jun", @"Jul", @"Aug", @"Sep", @"Oct", @"Nov", @"Dec"];
    
    [self charts];
}


- (void)charts {
    _chartView = [[BarChartView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    //_chartView.drawValueAboveBarEnabled = NO;
    _chartView.highlightFullBarEnabled = NO;
    _chartView.drawGridBackgroundEnabled = NO;
    _chartView.chartDescription.enabled = NO;
    _chartView.maxVisibleCount = 10;
    _chartView.drawBarShadowEnabled = NO;
    _chartView.scaleYEnabled = NO;
    _chartView.doubleTapToZoomEnabled = NO;
    _chartView.delegate = self;
    
    
    [self.view addSubview:_chartView];
    
    ChartXAxis *xAxis = _chartView.xAxis;
    xAxis.valueFormatter = self;
    xAxis.labelPosition = XAxisLabelPositionBottom;
    xAxis.drawGridLinesEnabled = NO;
    
    ChartLegend *legend = _chartView.legend;
    legend.enabled = NO;
    
    ChartYAxis *rightAxis = _chartView.rightAxis;
    rightAxis.enabled = NO;
    
    ChartYAxis *leftAxis = _chartView.leftAxis;
    leftAxis.enabled = NO;
    
    
    
    
    
    NSArray *tsSold = @[@20.0, @4.0, @6.0, @3.0, @12.0, @16.0, @4.0, @18.0, @2.0, @4.0, @5.0, @4.0, @20.0, @4.0, @6.0, @3.0, @12.0, @16.0, @4.0, @18.0, @2.0, @4.0, @5.0, @4.0, @20.0, @4.0, @6.0, @3.0, @12.0, @16.0];
    [self setChartWithDataPoints:_months Values:tsSold];
}


- (void)setChartWithDataPoints:(NSArray <NSString *> *)dataPoints Values:(NSArray <NSNumber *> *)values {
    NSMutableArray *dataEntries = [NSMutableArray array];
    for (int i = 0; i < values.count; i++) {
        BarChartDataEntry *entry = [[BarChartDataEntry alloc] initWithX:i y:[values[i] doubleValue]];
        [dataEntries addObject:entry];
    }
    
    BarChartDataSet *dataSet = [[BarChartDataSet alloc] initWithValues:dataEntries label:@""];
    dataSet.drawValuesEnabled = NO;
    BarChartData *data = [[BarChartData alloc] initWithDataSet:dataSet];
    _chartView.data = data;
    
}


- (NSString *)stringForValue:(double)value axis:(ChartAxisBase *)axis {
    return _months[(int)value % _months.count];
}

#pragma mark --ChartViewDelegate
- (void)chartValueSelected:(ChartViewBase * _Nonnull)chartView entry:(ChartDataEntry * _Nonnull)entry highlight:(ChartHighlight * _Nonnull)highlight {
    NSLog(@"%f, %@", entry.y, highlight);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
