//
//  ZXPopMenuView.m
//  类似于popOver弹出框效果
//
//  Created by ZouXu on 16/6/16.
//  Copyright © 2016年 ZouXu. All rights reserved.
//

#import "ZXPopMenuView.h"
#import "ZXPopMenuTableViewDataSource.h"
#import "ZXPopTableViewDelegate.h"
#import "ZXPopOverTableViewCell.h"
#import "ZXPopMenuDataModel.h"
#import "ZXPopMenuOptions.h"

#define WBNUMBER self.menuItem.count

@interface ZXPopMenuView (){
    CGRect _itemRect;
}

@property (nonatomic, strong) ZXPopMenuTableViewDataSource * tableViewDataSource;
@property (nonatomic, strong) ZXPopTableViewDelegate   * tableViewDelegate;

@end

@implementation ZXPopMenuView


- (instancetype) initWithFrame:(CGRect)frame
                     menuWidth:(CGFloat)menuWidth
                         items:(NSArray *)items
                     itemRect :(CGRect)itemRect
                        action:(void(^)(NSInteger index))action {
    if (self = [super initWithFrame:frame]) {
        self.menuWidth = menuWidth;
        self.menuItem = items;
        _itemRect = itemRect;
        self.action = [action copy];
        
        self.tableViewDataSource = [[ZXPopMenuTableViewDataSource alloc]initWithItems:items cellClass:[ZXPopOverTableViewCell class] configureCellBlock:^(ZXPopOverTableViewCell *cell, ZXPopMenuDataModel *model) {
            ZXPopOverTableViewCell * tableViewCell = (ZXPopOverTableViewCell *)cell;
            tableViewCell.textLabel.text = model.rightLabelStr;
            tableViewCell.imageView.image = [UIImage imageNamed:model.leftImageStr];
        }];
        self.tableViewDelegate = [[ZXPopTableViewDelegate alloc]initWithDidSelectRowAtIndexPath:^(NSInteger indexRow) {
            if (self.action) {
                self.action(indexRow);
            }
        }];
        
        
        self.tableView = [[UITableView alloc]initWithFrame:[self menuFrame:itemRect] style:UITableViewStylePlain];
        self.tableView.dataSource = self.tableViewDataSource;
        self.tableView.delegate   = self.tableViewDelegate;
        self.tableView.layer.cornerRadius = 10.0f;
        
        self.tableView.backgroundColor = [UIColor redColor];
        self.tableView.rowHeight = 40;
        self.tableView.scrollEnabled = NO;
        [self addSubview:self.tableView];
        
        if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
            [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        }
        if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
            [self.tableView setLayoutMargins:UIEdgeInsetsZero];
        }
    }
    return self;
}


- (CGRect)menuFrame :(CGRect)itemRect{
    
    CGFloat menuX = [self calculateMenuX];
    CGFloat menuY = _itemRect.origin.y+20+_itemRect.size.height;
    CGFloat width = self.menuWidth;
    CGFloat heigh = 40 * WBNUMBER;
    
    return (CGRect){menuX,menuY,width,heigh};
}

/** ------ 计算菜单的x坐标 */
-(CGFloat)calculateMenuX{
    CGFloat screenWith = [UIScreen mainScreen].bounds.size.width;
    CGFloat zxWith = screenWith - _itemRect.origin.x - _itemRect.size.width;
    if (_itemRect.origin.x > 75) {
        if (zxWith>55) {
            return _itemRect.origin.x + _itemRect.size.width/2-150/2;
        }else if(zxWith<=55 && zxWith >45){
            return screenWith - self.menuWidth -30;
        }else if(zxWith <= 45 && zxWith >35){
            return screenWith - self.menuWidth -23;
        }else if(zxWith <= 35 && zxWith > 25){
            return screenWith - self.menuWidth -16;
        }else if(zxWith <= 25 && zxWith > 10){
            return screenWith - self.menuWidth -9;
        }else if (zxWith>=0 && zxWith <= 10){
            return screenWith - self.menuWidth - 3;
        }
    }else{
        if (_itemRect.origin.x <= 75 && _itemRect.origin.x > 65) {
            return 15;
        }else if(_itemRect.origin.x <= 65 && _itemRect.origin.x > 55){
            return 12;
        }else if(_itemRect.origin.x <= 55 && _itemRect.origin.x > 45){
            return 9;
        }else if(_itemRect.origin.x <= 45 && _itemRect.origin.x > 35){
            return 6;
        }else{
            return 3;
        }
    }
    return 0;
}

#pragma mark 绘制三角形
- (void)drawRect:(CGRect)rect
{
    CGFloat screenWith = [UIScreen mainScreen].bounds.size.width;
    CGFloat zxWith = screenWith - _itemRect.origin.x - _itemRect.size.width;
    // 设置背景色
    [[UIColor whiteColor] set];
    //拿到当前视图准备好的画板
    
    CGContextRef  context = UIGraphicsGetCurrentContext();
    
    //利用path进行绘制三角形
    
    CGContextBeginPath(context);//标记
    
    CGFloat location = _itemRect.origin.x+_itemRect.size.width/2;
    if (_itemRect.origin.x > 75) {
        if (zxWith>0 && zxWith < 10){
            location -= 5;
        }
    }else if(_itemRect.origin.x < 10){
        location += 5;
    }
    CGContextMoveToPoint(context,
                         location+10, _itemRect.origin.y+20+_itemRect.size.height);//设置起点
    
    CGContextAddLineToPoint(context,
                            location   ,  _itemRect.origin.y+10+_itemRect.size.height);
    
    CGContextAddLineToPoint(context,
                            location - 10, _itemRect.origin.y+20+_itemRect.size.height);
    
    CGContextClosePath(context);//路径结束标志，不写默认封闭
    
    [[UIColor whiteColor] setFill];  //设置填充色
    
    [[UIColor whiteColor] setStroke]; //设置边框颜色
    
    CGContextDrawPath(context,
                      kCGPathFillStroke);//绘制路径path
    
}

- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [[ZXPopMenuOptions shareManager]hideMenu];
}


@end
