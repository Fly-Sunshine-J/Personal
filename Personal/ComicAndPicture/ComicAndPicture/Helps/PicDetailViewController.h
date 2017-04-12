//
//  PicDetailViewController.h
//  ComicAndPicture
//
//  Created by MS on 16/3/12.
//  Copyright © 2016年 JFY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PicDetailViewController : UIViewController

@property (nonatomic, strong) NSString *group_id;

@property (nonatomic, strong) NSString *category;

/**
 *  请求数据
 */
- (void)createData;


/**
 *  创建按钮
 */
- (void)createControls;


- (void)share:(UIButton *)btn;

@end
