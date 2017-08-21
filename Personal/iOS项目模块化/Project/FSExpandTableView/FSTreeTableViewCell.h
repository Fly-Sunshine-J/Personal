//
//  TreeTableViewCell.h
//  Record
//
//  Created by vcyber on 17/1/18.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FSTreeViewNode.h"


@interface FSTreeTableViewCell : UITableViewCell

@property (nonatomic, copy) void(^expandBlock)(NSIndexPath *);

-(void)configCellWithNode:(FSTreeViewNode *)node IndexPath:(NSIndexPath *)indexPath;

@end
