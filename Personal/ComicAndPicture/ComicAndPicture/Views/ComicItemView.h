//
//  ComicItemView.h
//  ComicAndPicture
//
//  Created by MS on 16/3/11.
//  Copyright © 2016年 JFY. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ComicItemViewDelegate <NSObject>

@optional
- (void)clickComicItemWithTag:(NSInteger)tag;

@end

@interface ComicItemView : UIScrollView

- (instancetype)initWithFrame:(CGRect)frame AndWithItems:(NSInteger)items;

@property (nonatomic, weak) id<ComicItemViewDelegate>myDelegate;

@end
