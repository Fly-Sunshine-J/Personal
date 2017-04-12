//
//  RightViewController.h
//  TableView联动效果
//
//  Created by vcyber on 16/6/8.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import <UIKit/UIKit.h>

#define JFYWIDTH [UIScreen mainScreen].bounds.size.width
#define JFYHEIGHT [UIScreen mainScreen].bounds.size.height

@protocol RightViewControllerDelegate <NSObject>

- (void)willDisplayHeaderView:(NSInteger)section;
- (void)didEndDisplayHeaderView:(NSInteger)section;

@end

@interface RightViewController : UIViewController

@property (nonatomic, weak) id<RightViewControllerDelegate>delegate;
@property (nonatomic, strong) NSArray *sectionTitleArray; //section的头视图名称
@property (nonatomic, strong) NSArray<NSArray *> * rightDataArray; //数据源

/**
 *  当左边的TableView滚动时, 右边的滚到对应的section
 */
- (void)scrollToSelectedIndexPath:(NSIndexPath *)indexPath;

@end
