//
//  LookComicViewController.h
//  ComicAndPicture
//
//  Created by MS on 16/3/12.
//  Copyright © 2016年 JFY. All rights reserved.
//

#import "ComicRootVC.h"

@protocol LookComicViewController <NSObject>

/**
 *  记录已经看的是第几话
 *
 *  @param tag 记录的话
 */
- (void)recordItemWithTag:(NSInteger)tag;

@end

@interface LookComicViewController : ComicRootVC

@property (nonatomic, strong) NSArray *comicArray;

@property (nonatomic, assign) NSInteger tag;

@property (nonatomic, assign) BOOL downloaded;

@property (nonatomic, weak) id<LookComicViewController> delegate;

@end
