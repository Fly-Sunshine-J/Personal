//
//  ViewController.m
//  CoreDataTest
//
//  Created by vcyber on 16/10/24.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "Student+CoreDataClass.h"
#import "Book+CoreDataClass.h"

@interface ViewController ()

@property (nonatomic, strong) AppDelegate *appDelegate;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.w3school.com.cn/example/xmle/simple.xml"]];
    [NSURLConnection sendAsynchronousRequest:request queue:nil completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        NSLog(@"%@", data);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)save:(UIButton *)sender {
    
    NSManagedObjectContext *context = self.appDelegate.managedObjectContext;
    NSLog(@"save start");
    for (int i = 0; i < 100; i++) {
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"Student" inManagedObjectContext:context];
        //创建学生对象
        Student *stu = [[Student alloc] initWithEntity:entity insertIntoManagedObjectContext:context];
        stu.name = [NSString stringWithFormat:@"张三%d", i];
        NSEntityDescription *bEntity = [NSEntityDescription entityForName:@"Book" inManagedObjectContext:context];
        //创建Book对象
        Book *book = [[Book alloc] initWithEntity:bEntity insertIntoManagedObjectContext:context];
        book.name = @"红楼梦";
        book.cost = @66.66;
        //添加Book对象
        [stu addBooksObject:book];
        
        //保存Student对象
        [_appDelegate saveContext];
    }
    NSLog(@"save end");
}

- (IBAction)read:(UIButton *)sender {
    NSLog(@"Migration start");
//    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Student"];
//    NSArray *arr = [self.appDelegate.managedObjectContext executeFetchRequest:request error:nil];
//    for (Student *stu in arr) {
//        for (Book *b in stu.books) {
//
//        }
//    }
    
    NSLog(@"Migration end %d", [self executeMigration]);
}

- (BOOL)executeMigration {
    BOOL success = NO;
    NSError *error = nil;
    
    NSURL *sourceStore = [[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject] URLByAppendingPathComponent:@"CoreDataTest.sqlite"];
    
    //原来的数据模型的原信息
    NSDictionary *sourceMetadata = [NSPersistentStoreCoordinator metadataForPersistentStoreOfType:NSSQLiteStoreType URL:sourceStore error:&error];
    //原数据模型
    NSManagedObjectModel *sourceModel = [NSManagedObjectModel mergedModelFromBundles:nil forStoreMetadata:sourceMetadata];
    
    //最新版数据模型
    NSManagedObjectModel *destinModel = _appDelegate.managedObjectModel;
    
    //数据迁移的映射模型
    NSMappingModel *mappingModel = [NSMappingModel mappingModelFromBundles:nil
                                                            forSourceModel:sourceModel
                                                          destinationModel:destinModel];
    if (mappingModel) {
        NSError *error = nil;
        
        //迁移管理器
        NSMigrationManager *migrationManager = [[NSMigrationManager alloc]initWithSourceModel:sourceModel
                                                                             destinationModel:destinModel];
        
        //这里可以注册监听  NSMigrationManager 的 migrationProgress来查看进度
        [migrationManager addObserver:self forKeyPath:@"migrationProgress" options:NSKeyValueObservingOptionNew context:nil];
        
        //先把模型存错到Temp.sqlite
        NSURL *destinStore = [[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject] URLByAppendingPathComponent:@"Temp.sqlite"];
        success = [migrationManager migrateStoreFromURL:sourceStore
                                                    type:NSSQLiteStoreType
                                                 options:nil
                                        withMappingModel:mappingModel
                                        toDestinationURL:destinStore
                                         destinationType:NSSQLiteStoreType
                                      destinationOptions:nil
                                                   error:&error];
        if (success) {
            //替换掉原来的旧的文件
            success = [[NSFileManager defaultManager] replaceItemAtURL:sourceStore withItemAtURL:destinStore backupItemName:@"backup.sqlite" options:NSFileManagerItemReplacementUsingNewMetadataOnly | NSFileManagerItemReplacementWithoutDeletingBackupItem resultingItemURL:nil error:nil];
            if (success) {
                //                这里移除监听就可以了。
                [migrationManager removeObserver:self forKeyPath:@"migrationProgress"];
            }
        }
    }
    return success;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"migrationProgress"]) {
        NSLog(@"%@", change[NSKeyValueChangeNewKey]);
        
    }
}


- (BOOL)judgeDataMigrationIsNeed {
    //是否存在文件
    NSURL *storeURL = [[[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject] URLByAppendingPathComponent:@"CoreDataTest.sqlite"];
    if (![[NSFileManager defaultManager] fileExistsAtPath:storeURL.path]) {
        return NO;
    }
    NSError *error = nil;
    
    //比较存错模型的元数据。
    NSDictionary *sourceMataData = [NSPersistentStoreCoordinator metadataForPersistentStoreOfType:NSSQLiteStoreType URL:storeURL error:&error];
    NSManagedObjectModel *destinationModel = _appDelegate.managedObjectModel;
    if ([destinationModel isConfiguration:nil compatibleWithStoreMetadata:sourceMataData]) {
        return NO;
    }
    return YES;
}

- (AppDelegate *)appDelegate {
    if (!_appDelegate) {
        _appDelegate = [UIApplication sharedApplication].delegate;
    }
    return _appDelegate;
}

@end
