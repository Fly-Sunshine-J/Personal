//
//  SelectDealerView.h
//  Record
//
//  Created by vcyber on 17/1/18.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSTreeViewNode.h"

@interface FSExpandTableView : UIView

@property (nonatomic, copy) void(^selectCell)(FSTreeViewNode *);

- (instancetype)initWithFrame:(CGRect)frame;

@property (nonatomic, strong) NSArray<FSTreeViewNode *> *dataArray;

@property (nonatomic, assign) BOOL show;

@end
