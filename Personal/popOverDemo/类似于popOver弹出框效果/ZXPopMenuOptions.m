//
//  ZXPopMenuOptions.m
//  类似于popOver弹出框效果
//
//  Created by ZouXu on 16/6/16.
//  Copyright © 2016年 ZouXu. All rights reserved.
//

#import "ZXPopMenuOptions.h"
#import "ZXPopMenuView.h"

@interface ZXPopMenuOptions ()

@property (nonatomic, strong) ZXPopMenuView * popMenuView;

@end

@implementation ZXPopMenuOptions

+ (ZXPopMenuOptions *) shareManager {
    static ZXPopMenuOptions *_popMenuSingOptions;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _popMenuSingOptions = [[ZXPopMenuOptions alloc]init];
    });
    return _popMenuSingOptions;
}

- (void) showPopMenuSelecteWithFrame:(CGFloat)width
                                items:(NSArray *)items
                      basicItemRect :(CGRect)basicItemRect
                              action:(void (^)(NSInteger))action {
    __weak __typeof(&*self)weakSelf = self;
    if (self.popMenuView != nil) {
        [weakSelf hideMenu];
    }
    
    UIWindow * window = [[[UIApplication sharedApplication] windows] firstObject];
    self.popMenuView = [[ZXPopMenuView alloc]initWithFrame:window.bounds
                                                 menuWidth:width
                                                     items:items
                                                  itemRect:basicItemRect
                                                    action:^(NSInteger index) {
                                                        action(index);
                                                        [weakSelf hideMenu];
                                                    }];
    self.popMenuView.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.1];
    [window addSubview:self.popMenuView];
    
    
    
    [UIView animateWithDuration:0.3 animations:^{
        self.popMenuView.tableView.transform = CGAffineTransformMakeScale(1.0, 1.0);
    }];
    
}

- (void) hideMenu {
    [UIView animateWithDuration:0.15 animations:^{
        self.popMenuView.tableView.transform = CGAffineTransformMakeScale(0.0001, 0.0001);
    } completion:^(BOOL finished) {
        [self.popMenuView.tableView removeFromSuperview];
        [self.popMenuView removeFromSuperview];
        self.popMenuView.tableView = nil;
        self.popMenuView = nil;
    }];
}




@end
