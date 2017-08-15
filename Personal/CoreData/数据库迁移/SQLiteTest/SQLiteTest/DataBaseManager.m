//
//  DataBaseManager.m
//  SQLiteTest
//
//  Created by vcyber on 16/10/25.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "DataBaseManager.h"
#import <sqlite3.h>

@interface DataBaseManager (){
    sqlite3 *db;
    NSString *dbName;
}

@end

@implementation DataBaseManager

+ (instancetype)shareManager {
    static DataBaseManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DataBaseManager alloc] init];
    });
    return manager;
}

- (BOOL)openDataBaseWithName:(NSString *)name {
    if (db) {
        return YES;
    }
    dbName = name;
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:name];
    
    int err = sqlite3_open([path UTF8String], &db);
    return err == SQLITE_OK ? YES : NO;
}


- (BOOL)closeDB {
    int err = sqlite3_close(db);
    if (err == SQLITE_OK) {
        db = nil;
        return YES;
    }else {
        return NO;
    }
}

- (BOOL)createTableWithName:(NSString *)name {
    if ([self openDataBaseWithName:dbName]) {
        NSString *sql = [NSString stringWithFormat:@"create table if not exists %@ (id integer primary key autoincrement, name text, age integer);", name];
        char *err;
        int result = sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err);
        if (result == SQLITE_OK) {
            [self closeDB];
            return YES;
        }else {
            NSLog(@"%s", err);
            [self closeDB];
            return NO;
        }
    }else {
        
        return NO;
    }
}

- (BOOL)insertDataWithSQL:(NSString *)sql {
    
    return [self executeSQL:sql];
}


- (BOOL)deleteDataWithSQL:(NSString *)sql {
    return [self executeSQL:sql];
}


- (BOOL)updataDataWithSQL:(NSString *)sql {
    return [self executeSQL:sql];
}

- (NSArray *)selectDataWithSQL:(NSString *)sql {
    
    if ([self openDataBaseWithName:dbName]) {
        // 创建一个数据库的替身, 存储对数据库的所有操作
        sqlite3_stmt *stmt = nil;
        
        int result = sqlite3_prepare_v2(db, [sql UTF8String], -1, &stmt, NULL);

        if (SQLITE_OK == result) {
            // 创建一个可变数组, 用于存储数据
            NSMutableArray *rows=[NSMutableArray array];
            // 当sql执行成功, 遍历数据
            // 循环遍历所有的结果, 每次遍历到一条数据, 都会返回sqlite_row, 如果没有数据了, 就不会返回SQLITE_ROW, 跳出循环
            while (SQLITE_ROW == sqlite3_step(stmt)) {
                
                // 取int类型的数据
                int columnCount = sqlite3_column_count(stmt);
                
                // 创建一个可变字典, 用来存储数据
                NSMutableDictionary *dic=[NSMutableDictionary dictionary];
                
                for (int i = 0; i < columnCount; i++) {
                    
                    // 在循环体中去按列取数据
                    // 取得列名
                    const char *name = sqlite3_column_name(stmt, i);
                    
                    // 取得某列的值
                    const unsigned char *value = sqlite3_column_text(stmt, i);
                    
                    // 将char *字符串转为NSString字符串
                    dic [[NSString stringWithUTF8String:name]] = [NSString stringWithUTF8String:(const char *) value];
                }
                
                [rows addObject:dic];
            }
            // 销毁stmt替身, 把里面的操作和结果写入本地sqlite文件
            sqlite3_finalize(stmt);
            return rows;
        }else {
            return nil;
        }
        
    }else {
        
        return nil;
    }

}

- (BOOL)queryDataWithSQL:(NSString *)sql {
    NSArray *arr  = [self selectDataWithSQL:sql];
    return arr.count > 0 ? YES : NO;
}


- (BOOL)executeSQL:(NSString *)sql {
    char *err;
    if ([self openDataBaseWithName:dbName]) {
        int result = sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err);
        if (result == SQLITE_OK) {
            [self closeDB];
            return YES;
        }else {
            NSLog(@"%s", err);
            [self closeDB];
            return NO;
        }
    }else {
        
        return NO;
    }
}

@end
