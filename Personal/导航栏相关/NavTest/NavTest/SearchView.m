//
//  SearchView.m
//  NavTest
//
//  Created by vcyber on 16/6/6.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "SearchView.h"

#define VIEW_LEFT 5.0F
#define VIEW_COL 5.0F
#define IMAGE_WIDTH 18.0F

// 封装View的时候可以用 - View的高度
#define MFHeight self.frame.size.height

// view的宽度
#define MFWidth self.frame.size.width

@implementation SearchView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:229.0/255 green:229.0/255 blue:229.0/255 alpha:1];
        self.layer.masksToBounds = YES;
        [self initSubView];
    }
    return self;
}


- (void)initSubView{
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(VIEW_LEFT, (MFHeight - IMAGE_WIDTH)/2, IMAGE_WIDTH, IMAGE_WIDTH);
//    [button setImage:getImageNamed(@"bg_ss") forState:UIControlStateNormal];
    [button addTarget:self action:@selector(SearchMarkBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:13.0f];
    [self addSubview:button];
    
    UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(button.frame)+VIEW_COL, CGRectGetMinY(button.frame), MFWidth - VIEW_LEFT*2 - IMAGE_WIDTH, CGRectGetHeight(button.frame))];
    textLabel.textColor = [UIColor lightGrayColor];
    textLabel.text = @"搜索商品/4S店";
    textLabel.font = [UIFont systemFontOfSize:14.0f];
    textLabel.textAlignment = NSTextAlignmentLeft;
    [self addSubview:textLabel];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    if (touch.tapCount == 1) {
        NSLog(@"click");
    }
}

-(void)SearchMarkBtnClicked
{
    NSLog(@"click");
}

@end
