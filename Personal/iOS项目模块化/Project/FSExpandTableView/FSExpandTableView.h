//
//  FSExpandTableView.h
//  FSExpandTableView
//
//  Created by vcyber on 17/8/21.
//  Copyright © 2017年 wenchaoios. All rights reserved.
//

#import <UIKit/UIKit.h>

//! Project version number for FSExpandTableView.
FOUNDATION_EXPORT double FSExpandTableViewVersionNumber;

//! Project version string for FSExpandTableView.
FOUNDATION_EXPORT const unsigned char FSExpandTableViewVersionString[];

// In this header, you should import all the public headers of your framework using statements like #import <FSExpandTableView/PublicHeader.h>
#import <UIKit/UIKit.h>
#import "FSTreeViewNode.h"

IB_DESIGNABLE
@interface FSExpandTableView : UIView

@property (nonatomic, copy) void(^selectCell)(FSTreeViewNode *);

- (instancetype)initWithFrame:(CGRect)frame;

@property (nonatomic, strong) NSArray<FSTreeViewNode *> *dataArray;

@property (nonatomic, assign) BOOL show;

@end


