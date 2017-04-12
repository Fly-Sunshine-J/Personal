//
//  MyAlertView.m
//  TextKit_Sample
//
//  Created by vcyber on 16/6/13.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "MyAlertView.h"

#define ALERTWIDTH [UIScreen mainScreen].bounds.size.width
#define ALERTHEIGHT [UIScreen mainScreen].bounds.size.height
#define FONT [UIFont systemFontOfSize:13]

@implementation MyAlertView

- (instancetype)initWithFrame:(CGRect)frame Name:(NSString *)name Phone:(NSString *)phone Address:(NSString *)address {
    
    self = [super initWithFrame:frame];
    if (self) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        [self addGestureRecognizer:tap];
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.2];
        [self createUIWithName:name Phone:phone Address:address];
        
    }
    return self;
}


- (void)createUIWithName:(NSString *)name Phone:(NSString *)phone Address:(NSString *)address {
    
    UIView *containerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ALERTWIDTH * 0.6, ALERTHEIGHT * 0.4)];
    containerView.center = self.center;
    containerView.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.2];
    [self addSubview:containerView];
    
    UILabel *signLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(containerView.frame), CGRectGetHeight(containerView.frame) / 7)];
    signLabel.textAlignment = NSTextAlignmentCenter;
    signLabel.font = FONT;
    signLabel.text = @"报名";
    signLabel.backgroundColor = [UIColor whiteColor];
    [containerView addSubview:signLabel];
    
    UIButton *disButn = [UIButton buttonWithType:UIButtonTypeCustom];
    disButn.frame = CGRectMake(CGRectGetWidth(signLabel.frame) - CGRectGetHeight(signLabel.frame), 0, CGRectGetHeight(signLabel.frame), CGRectGetHeight(signLabel.frame));
    [disButn setBackgroundImage:[UIImage imageNamed:@"dismiss"] forState:UIControlStateNormal];
    [disButn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [containerView addSubview:disButn];
    
    UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(signLabel.frame) + 1, CGRectGetWidth(containerView.frame), CGRectGetHeight(containerView.frame) - CGRectGetHeight(signLabel.frame) - 1)];
    bottomView.backgroundColor = [UIColor whiteColor];
    [containerView addSubview:bottomView];
    
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 30, 40, 30)];
    nameLabel.text = @"姓名：";
    nameLabel.font= FONT;
    [bottomView addSubview:nameLabel];
    UILabel *nameL = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(nameLabel.frame), 30, CGRectGetWidth(bottomView.frame) - CGRectGetMaxX(nameLabel.frame), 30)];
    nameL.text = name;
    nameL.font = FONT;
    [bottomView addSubview:nameL];
    
    UIButton *changeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    changeBtn.frame = CGRectMake(CGRectGetWidth(bottomView.frame) - CGRectGetHeight(nameLabel.frame) - 20, CGRectGetMinY(nameLabel.frame), CGRectGetHeight(nameLabel.frame), CGRectGetHeight(nameLabel.frame));
    [changeBtn setBackgroundImage:[UIImage imageNamed:@"dismiss"] forState:UIControlStateNormal];
    [changeBtn addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:changeBtn];
    
    
    UILabel *phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(nameLabel.frame) + 10, 40, 30)];
    phoneLabel.text = @"电话：";
    phoneLabel.font = FONT;
    [bottomView addSubview:phoneLabel];
    UILabel *phoneL = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(phoneLabel.frame), CGRectGetMinY(phoneLabel.frame), CGRectGetWidth(bottomView.frame) - CGRectGetMaxX(phoneLabel.frame), 30)];
    phoneL.text = phone;
    phoneL.font = FONT;
    [bottomView addSubview:phoneL];
    
    UILabel *addressLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, CGRectGetMaxY(phoneLabel.frame) + 10, 40, 30)];
    addressLabel.text = @"地址：";
    addressLabel.font = FONT;
    [bottomView addSubview:addressLabel];
    UILabel *addressL = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(addressLabel.frame), CGRectGetMinY(addressLabel.frame), CGRectGetWidth(bottomView.frame) - CGRectGetMaxX(addressLabel.frame), 30)];
    addressL.text = address;
    addressL.font = FONT;
    [bottomView addSubview:addressL];
    
    
    UIButton *signBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    signBtn.frame = CGRectMake(20, CGRectGetHeight(bottomView.frame) - 40, CGRectGetWidth(bottomView.frame) - 40, 30);
    [signBtn setBackgroundColor:[UIColor orangeColor]];
    [signBtn setTitle:@"立即预约" forState:UIControlStateNormal];
    [signBtn.titleLabel setFont:FONT];
    [signBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [signBtn addTarget:self action:@selector(reservation:) forControlEvents:UIControlEventTouchUpInside];
    [bottomView addSubview:signBtn];
    
}


- (void)reservation:(UIButton *)sender {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(reservationBtnClick:)]) {
        
        [self.delegate reservationBtnClick:self];
    }
    
}


- (void)show {
    
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    
}

- (void)dismiss {
    
    [self removeFromSuperview];
}

@end
