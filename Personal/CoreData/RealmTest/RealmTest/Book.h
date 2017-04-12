//
//  Book.h
//  RealmTest
//
//  Created by vcyber on 16/10/25.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import <Realm/Realm.h>
@class Student;

@interface Book : RLMObject

@property NSString *title;
@property float price;
@property Student *stu;     //这里表示一对多的关系

@end
RLM_ARRAY_TYPE(Book)  //宏定义  定义RLMArray<Book>这个类型