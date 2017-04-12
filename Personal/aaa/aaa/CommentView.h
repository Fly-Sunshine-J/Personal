//
//  CommentView.h
//  aaa
//
//  Created by vcyber on 16/7/5.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CommentView;

@protocol  CommentViewDelegate <NSObject>

- (void)clickBtn:(UIButton *)btn;

@end

@interface CommentView : UIView

@property (nonatomic, weak)id<CommentViewDelegate>delegate;
@property (nonatomic, strong) NSString *str;


- (void)showCommentView;

@end
