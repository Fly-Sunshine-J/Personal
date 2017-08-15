//
//  AppDelegate.h
//  CoreDataTest
//
//  Created by vcyber on 16/10/24.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

//数据的上下文
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
//数据模型
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
//持久化存储助理
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
//保存当前上下文中的数据
- (void)saveContext;

@end

