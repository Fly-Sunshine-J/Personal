//
//  CircleTimerViewController.m
//  Demo测试
//
//  Created by vcyber on 16/6/27.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "CircleTimerViewController.h"
#import "CicleProgressView.h"
#import "DemoSourceViewController.h"

@interface CircleTimerViewController ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) CicleProgressView *progress;
@property (nonatomic, strong) UIPickerView *pickView;

@property (nonatomic, strong) NSMutableArray *timerArray;

@property (nonatomic, assign) NSInteger totalTime;

@property (nonatomic, assign) int RecordH;
@property (nonatomic, assign) int RecordM;
@property (nonatomic, assign) int RecordS;

@end

@implementation CircleTimerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initDataArray];
    [self initSubViews];
//    [self addRightItem];
    
    self.navigationController.interactivePopGestureRecognizer.enabled = NO;
    
    self.SourceArray = [NSMutableArray arrayWithObjects:@[@"CicleProgressView.h", @"DemoSourceViewController"], @[@"CicleProgressView.m", @"DemoSourceViewController"], @[@"CircleTimerViewController.h", @"DemoSourceViewController"], @[@"CircleTimerViewController.m", @"DemoSourceViewController"], nil];
}

- (void)initSubViews {
    
    [self.view addSubview:self.progress];
    [self.view addSubview:self.pickView];
    
    NSArray *titleArray = @[@"开始", @"暂停", @"停止"];
    CGFloat btnWidth = 70;
    CGFloat padding = (self.view.frame.size.width - titleArray.count * btnWidth) / (titleArray.count + 1);
    for (int i = 0; i < titleArray.count; i ++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake(padding + (btnWidth + padding) * i, CGRectGetMaxY(self.pickView.frame) + 10, btnWidth, 40);
        [btn setTitle:titleArray[i] forState:UIControlStateNormal];
        if (i == 1) {
            [btn setTitle:@"继续" forState:UIControlStateSelected];
        }
        btn.tag = 100 + i;
        [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
}

- (void)clickBtn:(UIButton *)btn {
    
    switch (btn.tag) {
        case 100:
        {
            [self.progress setTotalSecondTime:self.RecordH * 60 * 60 + self.RecordM * 60 + self.RecordS];
            [self.progress startTimer];
        }
            break;

        case 101:
        {
            if (!btn.selected) {
                [self.progress pauseTimer];
            }else {
                [self.progress startTimer];
            }
            btn.selected = !btn.selected;
        }
            break;

        case 102:
            [self.progress stopTimer];
            break;

        default:
            break;
    }
}

- (void)initDataArray {
    
    _timerArray = [NSMutableArray array];
    for (int i = 0; i < 3; i++) {
        NSMutableArray *array = [NSMutableArray array];
        if (i == 0) {
            for (int j = 0; j < 24; j++) {
                [array addObject:[NSNumber numberWithInt:j]];
            }
        }else {
            for (int k = 0; k < 60; k++) {
                [array addObject:@(k)];
            }
        }
        [_timerArray addObject:array];
    }
}


- (CicleProgressView *)progress {
    
    if (!_progress) {
        _progress = [[CicleProgressView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 200) andCicleRadius:100];
    }
    return _progress;
}

- (UIPickerView *)pickView {
    
    if (!_pickView) {
        _pickView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.progress.frame), self.view.frame.size.width, 100)];
        _pickView.dataSource = self;
        _pickView.delegate = self;
    }
    return _pickView;
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return _timerArray.count;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return [_timerArray[component] count];
}

//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
//    
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
//    label.text = [NSString stringWithFormat:@"%@", _timerArray[component][row]];
//    label.textAlignment = NSTextAlignmentCenter;
//    return label;
//}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    if (component == 0) {
        return [NSString stringWithFormat:@"%@时",_timerArray[component][row]];
    }else if (component == 1){
        return [NSString stringWithFormat:@"%@分",_timerArray[component][row]];
    }else {
        return [NSString stringWithFormat:@"%@秒",_timerArray[component][row]];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (component == 0) {
        self.RecordH = [_timerArray[component][row] intValue];
        
    }else if (component == 1){
        self.RecordM = [_timerArray[component][row] intValue];
        
    }else if (component == 2) {
        self.RecordS = [_timerArray[component][row] intValue];
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
