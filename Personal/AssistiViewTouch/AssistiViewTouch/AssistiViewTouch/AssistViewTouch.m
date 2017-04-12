//
//  AssistViewTouch.m
//  AssistiViewTouch
//
//  Created by vcyber on 16/5/26.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "AssistViewTouch.h"

@interface AssistViewTouch()

@property (nonatomic, assign) CGRect superViewRect;
@property (nonatomic, assign) CGRect limitViewRect;

@end

@implementation AssistViewTouch

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createView];
    }
    return self;
}

- (void)createView {
    
    _superViewRect = CGRectZero;
    _limitViewRect = CGRectZero;
    self.backgroundColor = [UIColor redColor];
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = YES;
    
}

- (void)addAssistViewInSuperView:(UIView *)superView {
    
    _superViewRect = superView.frame;
    _limitViewRect = superView.frame;
    [superView addSubview:self];
    
    [self addGesture];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(limitRectOfAssistView:)]) {
        _limitViewRect = [self.delegate limitRectOfAssistView:self];
        [self manageLimitViewRect];
    }
    
}

- (void)manageLimitViewRect {
    
    CGRect rect = _limitViewRect;
    if (CGRectGetMinX(rect) < 0) {
        rect.origin.x = 0;
    }
    if (CGRectGetMinY(rect) < 0) {
        rect.origin.y = 0;
    }
    
    if (CGRectGetMinX(rect) + CGRectGetWidth(rect) > CGRectGetWidth(_superViewRect)) {
        rect.size.width = CGRectGetWidth(_superViewRect) - CGRectGetMinX(rect);
    }
    
    if (CGRectGetMinY(rect) + CGRectGetHeight(rect) > CGRectGetHeight(_superViewRect)) {
        rect.size.height = CGRectGetHeight(_superViewRect) - CGRectGetMinY(rect);
    }
    
    if ((CGRectGetWidth(rect) < CGRectGetWidth(self.frame)) || (CGRectGetHeight(rect) < CGRectGetHeight(self.frame))) {
        rect = _superViewRect;
    }
    _limitViewRect = rect;
    
    self.frame = CGRectMake(CGRectGetMinX(_limitViewRect), CGRectGetMinY(_limitViewRect)*(1+CGRectGetWidth(_limitViewRect)/CGRectGetWidth(_superViewRect)), CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
}

- (void)addGesture {
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self addGestureRecognizer:pan];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self addGestureRecognizer:tap];
}

- (void)panAction:(UIPanGestureRecognizer *)sender {
    
    CGFloat width = CGRectGetWidth(self.frame)/2.0;
    CGFloat height = CGRectGetHeight(self.frame)/2.0;
    
    CGPoint location = [sender locationInView:self.superview];
    
    CGFloat rightMaxX = (CGRectGetMinX(_limitViewRect) + CGRectGetWidth(_limitViewRect) - width);
    
    CGFloat bottomMaxY = (CGRectGetMinY(_limitViewRect) + CGRectGetHeight(_limitViewRect) - height);
    
    //限制左右拖动边界
    if (location.x < width + CGRectGetMinX(_limitViewRect)) {
        location.x = width + CGRectGetMinX(_limitViewRect);
        
    }else if (location.x > rightMaxX){
        location.x = rightMaxX;
    }
    
    //限制上下拖动边界
    if (location.y < height + CGRectGetMinY(_limitViewRect)) {
        location.y = height + CGRectGetMinY(_limitViewRect);
        
    }else if (location.y > bottomMaxY){
        location.y = bottomMaxY;
    }
    
    sender.view.center = CGPointMake(location.x,  location.y);
    
    //拖动结束处理
    if (sender.state == UIGestureRecognizerStateEnded) {
        if ((location.x != (width + CGRectGetMinX(_limitViewRect))) || (location.x != rightMaxX)) {
            
            if (location.x < (CGRectGetMinX(_limitViewRect)+CGRectGetWidth(_limitViewRect)/2.0)) {
                location.x = width + CGRectGetMinX(_limitViewRect);
                sender.view.center = CGPointMake(location.x,  location.y);
               
            }else{
                location.x = rightMaxX;
                sender.view.center = CGPointMake(location.x,  location.y);
               
            }
        }
    }
}


- (void)tapAction:(UITapGestureRecognizer *)pan {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(touchAssistView:)]) {
        [self.delegate touchAssistView:self];
    }
}



@end
