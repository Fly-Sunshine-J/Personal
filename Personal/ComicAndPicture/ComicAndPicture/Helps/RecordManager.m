//
//  ArchiveManager.m
//  ComicAndPicture
//
//  Created by MS on 16/3/14.
//  Copyright © 2016年 JFY. All rights reserved.
//

#import "RecordManager.h"
#import "ComicModel.h"
#import "Comic.h"
#import <MagicalRecord/MagicalRecord.h>

@implementation RecordManager

+ (instancetype)defaultManager {
    
    static RecordManager *manager;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[RecordManager alloc] init];
        
    });
    
    return manager;
    
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        
        
    }
    return self;
}

/**
 *  插入数据
 *
 *  @param comicmModel 数据模型
 */
- (void)insertDataWithModel:(ComicModel *)comicmModel {
    
    Comic *comic = [Comic MR_createEntity];
    
    [comic configEntityModelWithModel:comicmModel];
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
    
}


- (BOOL)searchDataWithModelId:(NSString *)comicId {
    
    
    Comic *comicModel = [Comic MR_findFirstByAttribute:@"comicId" withValue:comicId];
    
    if (comicModel) {
            
            return YES;
    }
    
    return NO;
    
}


- (BOOL)searchDataWithModelId:(NSString *)comicId  IsCollection:(BOOL)isCollection {

    NSArray *array = [Comic MR_findByAttribute:@"comicId" withValue:comicId];
    
    for (Comic *comic in array) {
        
        if ([comic.isCollection isEqualToNumber:[NSNumber numberWithBool:isCollection]]){
            
            return YES;
        }
        
    }
  
    return NO;
}


- (BOOL)searchDataWithModelId:(NSString *)comicId IsRead:(BOOL)isRead {
    NSArray *array = [Comic MR_findByAttribute:@"comicId" withValue:comicId];
    
    for (Comic *comic in array) {
        
        if ([comic.isRead isEqualToNumber:[NSNumber numberWithBool:isRead]]){
            
            return YES;
        }
        
    }
    
    return NO;
    
}


- (BOOL)searchDataWithModelId:(NSString *)comicId IsDownload:(BOOL)isDownload {
    
    NSArray *array = [Comic MR_findByAttribute:@"comicId" withValue:comicId];
    
    for (Comic *comic in array) {
        
        if ([comic.isDownload isEqualToNumber:[NSNumber numberWithBool:isDownload]]){
            
            return YES;
        }
        
    }
    
    return NO;
    
}

- (BOOL)searchDataWithModelId:(NSString *)comicId Downloading:(BOOL)downloading {
    
    NSArray *array = [Comic MR_findByAttribute:@"comicId" withValue:comicId];
    
    for (Comic *comic in array) {
        
        if ([comic.downloading isEqualToNumber:[NSNumber numberWithBool:downloading]]){
            
            return YES;
        }
        
    }
    
    return NO;
    
}


- (NSMutableArray *)searchAllByIsCollection:(NSNumber *)isCollection Read:(NSNumber *)isRead Download:(NSNumber *)isDownload Downloading:(NSNumber *)downloading{
    
    NSMutableArray *array;
    
    if ([isCollection boolValue]) {
        
        array =[NSMutableArray arrayWithArray: [Comic MR_findByAttribute:@"isCollection" withValue:[NSNumber numberWithBool:YES]]];
        
    }else if ([isRead boolValue] ) {
        
        array = [NSMutableArray arrayWithArray:[Comic MR_findByAttribute:@"isRead" withValue:[NSNumber numberWithBool:YES]]];
        
    }else if ([isDownload boolValue] || [downloading boolValue]){
        
        array = [NSMutableArray arrayWithArray:[Comic MR_findByAttribute:@"downloading" withValue:[NSNumber numberWithBool:YES]]];
        
        NSArray *arr = [Comic MR_findByAttribute:@"isDownload" withValue:[NSNumber numberWithBool:YES]];
        
        [array addObjectsFromArray:arr];
        
        
    }
    
    NSMutableArray *resultArray = [NSMutableArray array];
    
    for (Comic *comic in array) {
        
        ComicModel *model = [[ComicModel alloc] init];
        
        [model configModelWithEntityModel:comic];
        
        [resultArray addObject:model];
    }
    
    return resultArray;
    
}


- (void)modifyModelByModelId:(NSString *)comicId Model:(ComicModel *)model IsRead:(BOOL)isRead{
    
    NSArray *array = [Comic MR_findByAttribute:@"comicId" withValue:comicId];
    
    for (Comic *comic in array) {
        
        if ([comic.isRead isEqualToNumber:[NSNumber numberWithBool:isRead]]){
            
            [comic configEntityModelWithModel:model];
            
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];        }
        
    }
    
}


- (void)deleteDataWithModelId:(NSString *)comicId IsCollection:(BOOL)isCollection{
    
    NSArray *array = [Comic MR_findByAttribute:@"comicId" withValue:comicId];
    
    for (Comic *comic in array) {
    
        if (comic.isCollection) {
            
            [comic MR_deleteEntity];
            
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
            
            return;
            
        }
        
    }
    
   
}


- (void)deleteDataWithModelId:(NSString *)comicId IsRead:(BOOL)isRead {
    
    NSArray *array = [Comic MR_findByAttribute:@"comicId" withValue:comicId];
    
    for (Comic *comic in array) {
        
        if (comic.isRead) {
            
            [comic MR_deleteEntity];
            
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
            
            return;
            
        }
        
    }
}


- (void)deleteDataWithModelId:(NSString *)comicId IsDownload:(BOOL)isDownload {
    
    NSArray *array = [Comic MR_findByAttribute:@"comicId" withValue:comicId];
    
    for (Comic *comic in array) {
        
        if (comic.isDownload) {
            
            [comic MR_deleteEntity];
            
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
            
            return;
            
        }
        
    }
    
}


- (void)deleteDataWithModelId:(NSString *)comicId Downloading:(BOOL)downloading {
    
    NSArray *array = [Comic MR_findByAttribute:@"comicId" withValue:comicId];
    
    for (Comic *comic in array) {
        
        if (comic.downloading) {
            
            [comic MR_deleteEntity];
            
            [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreAndWait];
            
            return;
            
        }
        
    }
}


- (NSNumber *)searchTagWithModelId:(NSString *)comicId IsRead:(BOOL)isRead {
    
    NSArray *array = [Comic MR_findByAttribute:@"comicId" withValue:comicId];
    
    for (Comic *comic in array) {
        
        if ([comic.isRead isEqualToNumber:[NSNumber numberWithBool:isRead]]) {
            
            return comic.tag;
            
        }
        
    }
    
    return nil;
    
}
@end
