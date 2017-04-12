//
//  ArchiveManager.h
//  ComicAndPicture
//
//  Created by MS on 16/3/14.
//  Copyright © 2016年 JFY. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ComicModel;
@class Comic;

@interface RecordManager : NSObject

+ (instancetype)defaultManager;

/**
 *  出入数据
 *
 *  @param comicmModel 要插入的数据模型
 */
- (void)insertDataWithModel:(ComicModel *)comicmModel;

/**
 *  根据模型的id来检索模型是否存在
 */
//- (BOOL)searchDataWithModelId:(NSString *)comicId;

/**
 *  根据模型的id和是否收藏来检索模型是否存在
*/
- (BOOL)searchDataWithModelId:(NSString *)comicId IsCollection:(BOOL)isCollection;


/**
 *  根据模型的id和是否阅读来检索模型是否存在
 */
- (BOOL)searchDataWithModelId:(NSString *)comicId IsRead:(BOOL)isRead;


/**
 *  根据模型的id和是否收藏来检索模型是否存在
 */
- (BOOL)searchDataWithModelId:(NSString *)comicId IsDownload:(BOOL)isDownload;


/**
 *  根据模型的id和是否正在下载来检索模型是否存在
 */
- (BOOL)searchDataWithModelId:(NSString *)comicId Downloading:(BOOL)downloading;


/**
 *  根据模型的Id检索出对应的实体模型并进行修改
 *
 *  @param comicId 数据模型id
 *  @param model    用model修改数据
 */
- (void)modifyModelByModelId:(NSString *)comicId Model:(ComicModel *)model IsRead:(BOOL)isRead;

/**
 *  查询所有已经收藏的
 *
 */
- (NSMutableArray *)searchAllByIsCollection:(NSNumber *)isCollection Read:(NSNumber *)isRead Download:(NSNumber *)isDownload Downloading:(NSNumber *)downloading;

/**
 *  根据comicId和收藏来删除数据
 */
- (void)deleteDataWithModelId:(NSString *)comicId IsCollection:(BOOL)isCollection;

/**
 *  根据comicId和阅读来删除数据
 */
- (void)deleteDataWithModelId:(NSString *)comicId IsRead:(BOOL)isRead;

/**
 *  根据comicId和下载来删除数据
 */
- (void)deleteDataWithModelId:(NSString *)comicId IsDownload:(BOOL)isDownload;

/**
 *  根据comicId和是否正在下载来删除数据
 */
- (void)deleteDataWithModelId:(NSString *)comicId Downloading:(BOOL)downloading;

/**
 *检索阅读的章节数
 */
- (NSNumber *)searchTagWithModelId:(NSString *)comicId IsRead:(BOOL)isRead;

@end
