//
//  HeadImageView.h
//  NavTest
//
//  Created by vcyber on 16/6/8.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HeadImageView : UIView

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, assign) CGFloat scale;

- (instancetype)initWithFrame:(CGRect)frame Image:(UIImage *)image;

@end
