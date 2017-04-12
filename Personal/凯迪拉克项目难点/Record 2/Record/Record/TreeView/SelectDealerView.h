//
//  SelectDealerView.h
//  Record
//
//  Created by vcyber on 17/1/18.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TreeViewNode.h"

@interface SelectDealerView : UIView

- (instancetype)initWithFrame:(CGRect)frame DataArray:(NSArray <TreeViewNode *>*)dataArray;

@end
