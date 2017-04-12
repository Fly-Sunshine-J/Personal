//
//  LeftViewController.h
//  TableView联动效果
//
//  Created by vcyber on 16/6/8.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LeftViewController : UIViewController

@property (nonatomic, strong) NSArray *leftDataArray; //左侧一级数据源
@property (nonatomic, strong) NSArray<NSArray *> *rightDataArray;//右侧二级数据源

@end
