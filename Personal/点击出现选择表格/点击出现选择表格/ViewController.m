//
//  ViewController.m
//  点击出现选择表格
//
//  Created by vcyber on 16/6/8.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "ViewController.h"
#import <DOPDropDownMenu.h>
@interface ViewController ()<DOPDropDownMenuDelegate, DOPDropDownMenuDataSource>

@property (nonatomic, strong) DOPDropDownMenu *menu;

@property (nonatomic, strong) NSArray *classifys;
@property (nonatomic, strong) NSArray *cates;
@property (nonatomic, strong) NSArray *movices;
@property (nonatomic, strong) NSArray *hostels;
@property (nonatomic, strong) NSArray *areas;

@property (nonatomic, strong) NSArray *sorts;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.classifys = @[@"美食", @"今日新单", @"电影", @"酒店"];
    _cates = @[@"自助餐", @"快餐", @"火锅", @"日韩料理", @"西餐", @"烧烤小吃"];
    _movices = @[@"内地剧", @"港台剧", @"英美剧"];
    _hostels = @[@"经济酒店",@"商务酒店",@"连锁酒店",@"度假酒店",@"公寓酒店"];
    self.areas = @[@"全城",@"芙蓉区",@"雨花区",@"天心区",@"开福区",@"岳麓区"];
    self.sorts = @[@"默认排序",@"离我最近",@"好评优先",@"人气优先",@"最新发布"];
    
    _menu = [[DOPDropDownMenu alloc] initWithOrigin:CGPointMake(0, 64) andHeight:44];
    _menu.delegate = self;
    _menu.dataSource = self;
    [self.view addSubview:_menu];
    
    _menu.separatorColor = [UIColor redColor];
//    _menu.textColor = [UIColor yellowColor];
//    _menu.textSelectedColor = [UIColor cyanColor];
    
    //第一次显示  不会调用代理  并且默认选择要放在数据源之后
    [_menu selectDefalutIndexPath];
}

/**
 *  列数代理
 */
- (NSInteger)numberOfColumnsInMenu:(DOPDropDownMenu *)menu {
    
    return 3;
}

/**
 *  列对应的行数
 *
 */
- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfRowsInColumn:(NSInteger)column {
    
    if (column == 0) {
        return self.classifys.count;
    }else if (column == 1) {
        
        return self.areas.count;
    }else {
        
        return self.sorts.count;
    }
}

/**
 *  文字显示
 *
 */
- (NSString *)menu:(DOPDropDownMenu *)menu titleForRowAtIndexPath:(DOPIndexPath *)indexPath {
    
    if (indexPath.column == 0) {
        
        return self.classifys[indexPath.row];
    }else if(indexPath.column == 1){
        return self.areas[indexPath.row];
        
    }else {
        return self.sorts[indexPath.row];
        
    }
}

/**
 *  返回 menu 第column列 每行image
 *
 */
- (NSString *)menu:(DOPDropDownMenu *)menu imageNameForRowAtIndexPath:(DOPIndexPath *)indexPath {
    
    if (indexPath.column == 1 || indexPath.column == 0) {
        return [NSString stringWithFormat:@"ic_filter_category_%ld", indexPath.row];
    }else {
        return nil;
    }
}


//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\两个表格的情况会有一个item属性\\\\\\\\\\\\\\\\\\\\\\\\\\\\

/**
 *  当有column列 row 行 item项 image
 *
 */
- (NSString *)menu:(DOPDropDownMenu *)menu imageNameForItemsInRowAtIndexPath:(DOPIndexPath *)indexPath {
    
    if (indexPath.column == 0 && indexPath.item >= 0) {
        return [NSString stringWithFormat:@"ic_filter_category_%ld", indexPath.row];
    }
    return nil;
}


/**
 *  第二个表格item的数量
 *
 */
- (NSInteger)menu:(DOPDropDownMenu *)menu numberOfItemsInRow:(NSInteger)row column:(NSInteger)column {
    
    if (column == 0) {
        if (row == 0) {
            return _cates.count;
        }else if (row == 2) {
            return _movices.count;
        }else if (row == 3) {
            return _hostels.count;
        }
    }
    return 0;
}


/**
 *  第二个表格item的文字
 *
 */
- (NSString *)menu:(DOPDropDownMenu *)menu titleForItemsInRowAtIndexPath:(DOPIndexPath *)indexPath {
    
    if (indexPath.column == 0) {
        if (indexPath.row == 0) {
            return _cates[indexPath.item];
        }else if (indexPath.row == 2) {
            return _movices[indexPath.item];
        }else if (indexPath.row == 3) {
            return _hostels[indexPath.item];
        }
    }
    return nil;
}



//\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\点击事件\\\\\\\\\\\\\\\\\\\\\\\\\\\//
- (void)menu:(DOPDropDownMenu *)menu didSelectRowAtIndexPath:(DOPIndexPath *)indexPath {
    
    //可以根据indexPath的item属性判断是否有两个表格
    if (indexPath.item >= 0) {
        NSLog(@"点击了%ld - %ld - %ld",indexPath.column, indexPath.row, indexPath.item);
    }else {
        NSLog(@"点击了%ld - %ld",indexPath.column, indexPath.row);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
