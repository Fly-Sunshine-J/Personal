//
//  CommentView.m
//  aaa
//
//  Created by vcyber on 16/7/5.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "CommentView.h"

@implementation CommentView

@synthesize str = _str;

- (void)setStr:(NSString *)str {
    _str = str;
}

- (NSString *)str {
    
    return _str;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithWhite:0.8 alpha:0.8];
        _str = @"aaa";
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    
    UIView *containView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.frame) * 0.8, CGRectGetHeight(self.frame) * 0.7)];
    containView.center = self.center;
    containView.backgroundColor = [UIColor whiteColor];
    [self addSubview:containView];
    
    UIBezierPath *roundRectPath = [UIBezierPath bezierPathWithRoundedRect:containView.bounds cornerRadius:10];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = containView.bounds;
    layer.path = roundRectPath.CGPath;
    containView.layer.mask = layer;
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"test"]];
    imageView.frame = CGRectMake(0, 0, CGRectGetWidth(containView.frame), CGRectGetHeight(containView.frame) * 0.6);
    [containView addSubview:imageView];
    
    UILabel *topLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(imageView.frame) + 20, CGRectGetWidth(containView.frame), CGRectGetHeight(containView.frame) * 0.1)];
    topLabel.text = @"一 给个好评呗 一";
    topLabel.font = [UIFont boldSystemFontOfSize:13];
    topLabel.textAlignment = NSTextAlignmentCenter;
    [containView addSubview:topLabel];
    
    UILabel *middleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(topLabel.frame), CGRectGetWidth(containView.frame), CGRectGetHeight(containView.frame) * 0.1)];
    middleLabel.text = @"It's的成长需要你的支持,";
    middleLabel.font = [UIFont systemFontOfSize:14];
    middleLabel.textColor = [UIColor lightGrayColor];
    middleLabel.textAlignment = NSTextAlignmentCenter;
    [containView addSubview:middleLabel];
    
    UILabel *buttomLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(middleLabel.frame) - CGRectGetHeight(middleLabel.frame) * 0.6, CGRectGetWidth(containView.frame), CGRectGetHeight(containView.frame) * 0.1)];
    buttomLabel.text = @"我们诚挚希望能够得到你们的鼓励!";
    buttomLabel.font = [UIFont systemFontOfSize:14];
    buttomLabel.textColor = [UIColor lightGrayColor];
    buttomLabel.textAlignment = NSTextAlignmentCenter;
    [containView addSubview:buttomLabel];
    
    
    UILabel *line1 = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(containView.frame) * 0.9, CGRectGetWidth(containView.frame), 1)];
    line1.backgroundColor = [UIColor lightGrayColor];
    [containView addSubview:line1];
    
    UILabel *line2 = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetWidth(containView.frame) / 2 - 0.5, CGRectGetHeight(containView.frame) * 0.9 + 10, 1, CGRectGetHeight(containView.frame) * 0.1 - 20)];
    line2.backgroundColor = [UIColor lightGrayColor];
    [containView addSubview:line2];
    
    NSArray *titleArray = @[@"等下再说", @"鼓励一下"];
    for (int i = 0; i < titleArray.count; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
        btn.frame = CGRectMake(CGRectGetMaxX(line2.frame) * i, CGRectGetMaxY(line1.frame), CGRectGetMinX(line2.frame), CGRectGetHeight(containView.frame) * 0.1);
        [btn setTitle:titleArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        [containView addSubview:btn];
    }
    
}


- (void)btnClick:(UIButton *)btn {
    [self dismissConmentView];
    if (self.delegate && [self.delegate respondsToSelector:@selector(clickBtn:)]) {
        [self.delegate clickBtn:btn];
    }
    
}


- (void)showCommentView {
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (void)dismissConmentView {
    
    [self removeFromSuperview];
}

@end
