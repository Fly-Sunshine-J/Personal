//
//  DetailViewController.h
//  iOS测试相关
//
//  Created by vcyber on 2017/9/18.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) NSDate *detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
- (int)getNum;
@end

