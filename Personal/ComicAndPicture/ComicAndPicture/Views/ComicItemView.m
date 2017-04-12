//
//  ComicItemView.m
//  ComicAndPicture
//
//  Created by MS on 16/3/11.
//  Copyright © 2016年 JFY. All rights reserved.
//

#import "ComicItemView.h"
#import "RecordManager.h"

@implementation ComicItemView

- (instancetype)initWithFrame:(CGRect)frame AndWithItems:(NSInteger)items {
    
    if ([super initWithFrame:frame]) {
        
        [self createItemsWithItems:items];
        
    }
    
    return self;
    
}

- (void)createItemsWithItems:(NSInteger)items {
    
    CGFloat xSpace = (WIDTH - 70 * 4) / 5;
    
    for (int i = 0; i < items; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [btn setTitle:[NSString stringWithFormat:@"%d话", i + 1] forState:UIControlStateNormal];
        
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        [btn setImage:[UIImage imageNamed:@"yuanlaibiaoqian"] forState:UIControlStateSelected];
        
        btn.backgroundColor = [UIColor colorWithWhite:0.2 alpha:0.2];
        
        btn.frame = CGRectMake(xSpace + (70 + xSpace) * (i % 4) , (5 + 40) * (i / 4), 70, 40);
        
        btn.layer.cornerRadius = 5;
        
        btn.tag = 1000 + i;
        
        [btn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:btn];
        
    }
    
    
}


- (void)click:(UIButton *)btn {
    
    [self.myDelegate clickComicItemWithTag:btn.tag - 1000];
    
}


@end
