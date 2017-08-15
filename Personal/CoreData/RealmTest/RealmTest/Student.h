//
//  Student.h
//  RealmTest
//
//  Created by vcyber on 16/10/25.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import <Realm/Realm.h>
#import "Book.h"
@interface Student : RLMObject
@property int num;
@property NSString *name;
@property int age;
@property RLMArray<Book *><Book> *books;  //这里表示一对多的关系

@end
RLM_ARRAY_TYPE(Student)  //宏定义  定义RLMArray<Student>这个类型
