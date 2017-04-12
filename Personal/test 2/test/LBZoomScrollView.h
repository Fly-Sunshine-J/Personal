//
//  LBZoomScrollView.h
//  test
//
//  Created by dengweihao on 2017/3/15.
//  Copyright © 2017年 dengweihao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LBZoomScrollView : UIScrollView

@property (nonatomic , strong)UIImage *image;

- (void)showImageWithURL:(NSURL *)url andPlaceHoldImage:(UIImage *)image andFrom:(UIImageView *)fromView andFromViewLocationView:(UIView *)locationView;

@end
