//
//  Student.h
//  RealmTest
//
//  Created by vcyber on 16/10/25.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import <Realm/Realm.h>
#import "Book.h"
// V0
//@interface Student : RLMObject
//@property int num;
//@property NSString *name;
//@property int age;
//@property RLMArray<Book *><Book> *books;  //这里表示一对多的关系
//
//@end
RLM_ARRAY_TYPE(Student)  //宏定义  定义RLMArray<Student>这个类型

//V1
//@interface Student : RLMObject
//@property int num;
//@property NSString *name;
//@property RLMArray<Book *><Book> *books;  //这里表示一对多的关系
//
//@end

//V2
//@interface Student : RLMObject
//@property int num;
//@property NSString *name;
//@property NSString *sex;
//@property RLMArray<Book *><Book> *books;  //这里表示一对多的关系

//@end


//V3
typedef NS_ENUM(NSInteger, Sex) {
    Unknow = 0,
    Male,
    Female
};

@interface Student : RLMObject
@property int num;
@property NSString *name;
@property Sex sex;
@property RLMArray<Book *><Book> *books;  //这里表示一对多的关系

+ (Sex)sexTypeForString:(NSString *)typeString;
@end
