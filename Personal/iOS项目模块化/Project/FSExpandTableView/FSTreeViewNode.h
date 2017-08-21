//
//  TreeViewNode.h
//  Record
//
//  Created by vcyber on 17/1/18.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FSTreeViewNode : NSObject

@property (nonatomic, assign) int nodeLevel;                        //节点所处层次
@property (nonatomic, strong) id nodeData;                          //节点数据
@property (nonatomic, assign) BOOL isExpanded;                      //节点是否展开
@property (strong,nonatomic) NSArray<FSTreeViewNode *> *sonNodes;   //子节点

@end
