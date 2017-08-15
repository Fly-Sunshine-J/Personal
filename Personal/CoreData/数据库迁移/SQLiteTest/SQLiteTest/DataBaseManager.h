//
//  DataBaseManager.h
//  SQLiteTest
//
//  Created by vcyber on 16/10/25.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataBaseManager : NSObject

+ (instancetype)shareManager;

//打开数据库
- (BOOL)openDataBaseWithName:(NSString *)name;

//关闭数据库
- (BOOL)closeDB;

/**
 *  创建表
 *
 *  @param name 表名
 *
 *  @return 创建是否成功
 */
- (BOOL)createTableWithName:(NSString *)name;
/**
 *  插入数据
 *
 *  @param sql sql语句
 *
 *  @return 是否插入成功
 */
- (BOOL)insertDataWithSQL:(NSString *)sql;
/**
 *  删除数据
 *
 *  @param sql SQL语句
 *
 *  @return 是否删除成功
 */
- (BOOL)deleteDataWithSQL:(NSString *)sql;
/**
 *  更新数据
 *
 *  @param sql SQL语句
 *
 *  @return 是否更新成功
 */
- (BOOL)updataDataWithSQL:(NSString *)sql;
/**
 *  查询数据
 *
 *  @param sql SQL语句
 *
 *  @return 查询结果
 */
- (NSArray *)selectDataWithSQL:(NSString *)sql;
/**
 *  查询数据
 *
 *  @param sql SQL语句
 *
 *  @return 是否有数据
 */
- (BOOL)queryDataWithSQL:(NSString *)sql;

@end
