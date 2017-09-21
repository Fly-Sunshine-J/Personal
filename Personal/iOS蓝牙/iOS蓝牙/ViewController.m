//
//  ViewController.m
//  iOS蓝牙
//
//  Created by vcyber on 2017/9/18.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import "ViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface ViewController ()<CBCentralManagerDelegate,
                            CBPeripheralDelegate,
                            UITableViewDelegate,
                            UITableViewDataSource,
                            UITableViewDragDelegate,
                            UITableViewDropDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) CBCentralManager *manager;
@property (nonatomic, strong) CBPeripheral *peripheral;

@property (nonatomic, strong) CBCharacteristic *writeCharacteristic;

@property (nonatomic, strong) NSMutableArray *nDevices;
@property (nonatomic, strong) NSMutableArray *nServices;
@property (nonatomic, strong) NSMutableArray *nCharacteristics;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationController.navigationBarHidden = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, -20, self.view.bounds.size.width, self.view.bounds.size.height) style:UITableViewStylePlain];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.dragDelegate = self;
    _tableView.dropDelegate = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:NSStringFromClass([UITableViewCell class])];
    [self.view addSubview:_tableView];
    
    _nDevices = [NSMutableArray array];
    _nServices = [NSMutableArray array];
    _nCharacteristics = [NSMutableArray array];
    
    _manager = [[CBCentralManager alloc] initWithDelegate:self queue:nil];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"开始扫描" style:UIBarButtonItemStylePlain target:self action:@selector(beginScan)];
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (void)beginScan {
    [_nDevices removeAllObjects];
    [_tableView reloadData];
    [_manager scanForPeripheralsWithServices:nil options:nil];
}

#pragma mark ---CBCentralManagerDelegate
//查看蓝牙是否开启
- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    switch (central.state) {
        case CBManagerStatePoweredOn:
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"蓝牙已经打开" message:@"是否开始扫描" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *scan = [UIAlertAction actionWithTitle:@"开始扫描" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [_manager scanForPeripheralsWithServices:nil options:nil];
            }];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alert addAction:scan];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
        }
            break;
        case CBManagerStatePoweredOff:
        {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"蓝牙未打开" message:@"是否去打开" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *open = [UIAlertAction actionWithTitle:@"打开" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            }];
            UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            [alert addAction:open];
            [alert addAction:cancel];
            [self presentViewController:alert animated:YES completion:nil];
        }
            break;
        default:
            break;
    }
}

- (void)centralManager:(CBCentralManager *)central willRestoreState:(NSDictionary<NSString *,id> *)dict {
    
}

- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    
}

- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    
}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *,id> *)advertisementData RSSI:(NSNumber *)RSSI {
    NSLog(@"%@", peripheral);
    if (peripheral.name) {
        [_nDevices addObject:peripheral.name];
    }else {
        [_nDevices addObject:peripheral.identifier.UUIDString];
    }
    [_tableView reloadData];
}

#pragma mark --CBPeripheralDelegate

#pragma mark --UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([UITableViewCell class]) forIndexPath:indexPath];
    cell.textLabel.text = @"aaa";//_nDevices[indexPath.row];
    cell.backgroundColor = [UIColor greenColor];
    return cell;
    
}

#pragma mark --UITableViewDragDelegate
- (NSArray<UIDragItem *> *)tableView:(UITableView *)tableView itemsForBeginningDragSession:(id<UIDragSession>)session atIndexPath:(NSIndexPath *)indexPath {
    
    return nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
