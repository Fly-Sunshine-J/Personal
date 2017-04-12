//
//  DetailViewController.h
//  ComicAndPicture
//
//  Created by MS on 16/3/9.
//  Copyright © 2016年 JFY. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ComicModel;

@interface DetailViewController : UIViewController

@property (nonatomic, strong) ComicModel *model;

@property (nonatomic, assign) BOOL downloaded;

@end
