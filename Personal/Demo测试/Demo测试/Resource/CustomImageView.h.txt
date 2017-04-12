//
//  CustomImageView.h
//  Demo测试
//
//  Created by vcyber on 16/6/28.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import <UIKit/UIKit.h>

//可以使用类别
@interface CustomImageView : UIImageView

- (void)clipImageRoundRectWithRoundingCorners:(UIRectCorner)rectCorner cornerRadii:(CGSize)size;

- (void)clipImageInnerRoundRectWithRoundingCorners:(UIRectCorner)rectCorner cornerRadii:(CGSize)size;

@end
