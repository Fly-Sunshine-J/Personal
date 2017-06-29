//
//  CalendarCollectionViewCell.m
//  Calendar
//
//  Created by vcyber on 17/5/16.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import "CYWCalendarCollectionViewCell.h"
#import "Masonry.h"

@interface CYWCalendarCollectionViewCell ()

@property (nonatomic, strong) UILabel *dateLabel;

@end

@implementation CYWCalendarCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self createUI];
    }
    return self;
}

- (void)createUI {
    _dateLabel = [[UILabel alloc] init];
    _dateLabel.textAlignment = NSTextAlignmentCenter;
    _dateLabel.textColor = [UIColor blackColor];
    _dateLabel.font = [UIFont systemFontOfSize:13.0];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectDate:)];
    [_dateLabel addGestureRecognizer:tap];
    CGFloat lineWidth = 1 / [UIScreen mainScreen].scale;
    [self.contentView addSubview:_dateLabel];
    [_dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView);
        make.right.equalTo(self.contentView).mas_offset(-lineWidth);
        make.top.equalTo(self.contentView);
        make.bottom.equalTo(self.contentView).mas_offset(-lineWidth);
    }];
}


- (void)setModel:(CYWCalendarModel *)model {
    _model = model;
    _dateLabel.text = model.dateString;
    if ([model.dateString isEqualToString:@"今天"]) {
        _dateLabel.backgroundColor = [UIColor redColor];
    }else {
        _dateLabel.backgroundColor = [UIColor whiteColor];
        
        if ([model.dateString isEqualToString:@""]) {
            _dateLabel.userInteractionEnabled = NO;
        }else {
            _dateLabel.userInteractionEnabled = YES;
        }
    }
}



- (void)selectDate:(UITapGestureRecognizer *)tap {
    if (self.selectDateCallBack) {
        self.selectDateCallBack(_model);
    }
}


- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    CGFloat lineWidth = 1 / [UIScreen mainScreen].scale;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, lineWidth);
    
    CGContextMoveToPoint(context, self.frame.size.width, 0);
    CGContextAddLineToPoint(context, self.frame.size.width, self.frame.size.height);
    CGContextAddLineToPoint(context, 0, self.frame.size.height);
    
    CGContextDrawPath(context, kCGPathStroke);
    
}



@end
