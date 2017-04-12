//
//  TreeTableViewCell.h
//  Record
//
//  Created by vcyber on 17/1/18.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TreeViewNode.h"


@interface TreeTableViewCell : UITableViewCell


@property (nonatomic, strong) UIImageView *arrowView;
@property (nonatomic, strong) UILabel *nameLabel;

-(void)configCellWithNode:(TreeViewNode *)node;

@end
