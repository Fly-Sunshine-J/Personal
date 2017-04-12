//
//  AdView.m
//  启动页加载广告页面
//
//  Created by vcyber on 16/6/7.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "AdView.h"

// 广告显示的时间
static int const showtime = 3;

@interface AdView ()

@property (nonatomic, strong) UIImageView *adImageView;
@property (nonatomic, strong) UIButton *jumpBtn;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) int countTime;

@end

@implementation AdView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _adImageView = [[UIImageView alloc] initWithFrame:frame];
        _adImageView.userInteractionEnabled = YES;
        _adImageView.contentMode = UIViewContentModeScaleAspectFill;
        _adImageView.clipsToBounds = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickImage:)];
        [_adImageView addGestureRecognizer:tap];
        
        _jumpBtn = [[UIButton alloc] initWithFrame:CGRectMake(kscreenWidth - 60 - 24, 30, 60, 30)];
        [_jumpBtn setTitle:[NSString stringWithFormat:@"跳过%d", showtime] forState:UIControlStateNormal];
        _jumpBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [_jumpBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _jumpBtn.backgroundColor = [UIColor colorWithRed:38/255.0 green:38/255.0 blue:38/255.0 alpha:0.6];
        _jumpBtn.layer.cornerRadius = 4;
        [_jumpBtn addTarget:self action:@selector(jump:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_adImageView];
        [self addSubview:_jumpBtn];
    }
    return self;
}

- (void)clickImage:(UITapGestureRecognizer *)tap {
    
    [self jump:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"PUSHTOAD" object:nil userInfo:nil];
}

- (void)jump:(UIButton *)sender {
    
    [UIView animateWithDuration:0.3f animations:^{
        
        self.alpha = 0.f;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
    }];
}

- (NSTimer *)timer {
    
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(cutDownTime:) userInfo:nil repeats:YES];
    }
    return _timer;
}

- (void)cutDownTime:(NSTimer *)timer {
    
    _countTime--;
    [_jumpBtn setTitle:[NSString stringWithFormat:@"跳过%d",_countTime] forState:UIControlStateNormal];
    if (_countTime == 0) {
        [_timer invalidate];
        _timer = nil;
        [self jump:nil];
    }
}

- (void)setFilePath:(NSString *)filePath {
    
    _filePath = filePath;
    _adImageView.image = [UIImage imageWithContentsOfFile:filePath];
}


- (void)show {
    [self startTimer];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}

- (void)startTimer
{
    _countTime = showtime;
    [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}

@end
