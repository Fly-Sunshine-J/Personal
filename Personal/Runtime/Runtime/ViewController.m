//
//  ViewController.m
//  Runtime
//
//  Created by vcyber on 17/6/27.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import "ViewController.h"
#import "MyClass1.h"
#import <objc/runtime.h>
#import "UIView+Border.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self ex_registerNewClass];
    [self myClass1];

    UIView *colorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    colorView.backgroundColor = [UIColor greenColor];
    [self.view addSubview:colorView];
    colorView.page = 10;
    colorView.name = @"RedView";
    NSLog(@"colorView page is %d, name is %@", colorView.page, colorView.name);
    
}


- (void)myClass1 {
    
    MyClass1 *class1 = [[MyClass1 alloc] init];
    class1.string = @"test";
    Class cls = [class1 class];
    
    //类名
    NSLog(@"class name: %s", class_getName(cls));
    NSLog(@"//类名---------------------------------------------");
    
    //父类
    NSLog(@"super class name: %s", class_getName(class_getSuperclass(cls)));
    NSLog(@"//父类---------------------------------------------");
    
    //是不是元类
    NSLog(@"MyClass1 is %@ a meta-class", @(class_isMetaClass(cls)));
    NSLog(@"//是不是元类---------------------------------------------");
    
    //获取元类
    NSLog(@"%s meta-class is %s", class_getName(cls), class_getName(objc_getMetaClass(class_getName(cls))));
    NSLog(@"//获取元类---------------------------------------------");
    
    //变量实例的大小
    NSLog(@"instance size: %zu", class_getInstanceSize(cls));
    NSLog(@"//变量实例的大小---------------------------------------------");
    
    //成员变量
    
    unsigned int count;
    Ivar *ivars = class_copyIvarList(cls, &count);    //获取成员变量列表  属性+_（下划线）也属于成员变量的一种
    for (unsigned int i = 0; i < count; i++) {
        Ivar ivar = ivars[i];
        NSLog(@"instance variable's name: %s at index: %d", ivar_getName(ivar), i);
    }
    free(ivars);
    
    Ivar string = class_getInstanceVariable(cls, "_string");    //获取特定的成员变量
    if (string != NULL) {
        NSLog(@"instance variable %s, value is %@", ivar_getName(string), object_getIvar(class1, string));   //获取成员变量名和值
    }else {
        NSLog(@"no have variable");
    }
    
    Ivar _instance2 = class_getInstanceVariable(cls, "_instance2");
    if (_instance2 != NULL) {
        object_setIvar(class1, _instance2, @(2));  //设置成员变量的值  比object_setInstanceVariable快
        NSLog(@"_instance variable %s, value is %@", ivar_getName(_instance2), object_getIvar(class1, _instance2));
    }else {
        NSLog(@"no have variable");
    }
    
    NSLog(@"//成员变量---------------------------------------------");
    
    
    
    //属性
    
    /*****添加属性*****/
    objc_property_attribute_t att1 = {"T","NSNumber"};
    objc_property_attribute_t att2 = {"&", ""};
    objc_property_attribute_t att3 = {"N", ""};
    objc_property_attribute_t att4 = {"V", "_age"};
    objc_property_attribute_t atts[] = {att1, att2, att3, att4};
    BOOL result = class_addProperty(cls, "age", atts, 4);
    /*****添加属性*****/
    
    /*****添加属性setter&getter*****/
    class_addMethod(cls, NSSelectorFromString(@"age"), (IMP)age, "@");
    class_addMethod(cls, NSSelectorFromString(@"setAge:"), (IMP)setAge, "@");
    /*****添加属性setter&getter*****/

    [class1 performSelector:NSSelectorFromString(@"setAge:") withObject:@99];
    NSLog(@"class1 age is %@", [class1 performSelector:NSSelectorFromString(@"age")]);
    
    
    
//    /*****替换属性*****/
//    objc_property_attribute_t att5 = {"T", "NSString"};
//    objc_property_attribute_t atts2[] = {att5, att2, att3, att4};
//    class_replaceProperty(cls, "age", atts2, 4);
//    /*****替换属性*****/
    
    objc_property_t * properties = class_copyPropertyList(cls, &count);    //获取属性列表
    for (int i = 0; i < count; i++) {
        objc_property_t property = properties[i];
        unsigned int j;
        /*****获取属性的属性*****/
        objc_property_attribute_t *att_ts = property_copyAttributeList(property, &j);
        for (int k = 0; k < j; k++) {
            objc_property_attribute_t att_t = att_ts[k];
            NSLog(@"objc_property_attribute_t name : %s, value : %s", att_t.name, att_t.value);
        }
        /*****获取属性的属性*****/
        NSLog(@"property's name: %s", property_getName(property));
        free(att_ts);
    }
    free(properties);
    
    objc_property_t array = class_getProperty(cls, "array");   //获取特定的属性
    if (array != NULL) {
        NSLog(@"property %s", property_getName(array));
    }else {
        NSLog(@"no have property");
    }
    NSLog(@"//属性---------------------------------------------");
    
    
    //实例方法
    Method *methods = class_copyMethodList(cls, &count);    //获取实例方法列表
    for (int i = 0; i < count; i++) {
        Method method = methods[i];
        NSLog(@"method's signature: %@", NSStringFromSelector(method_getName(method)));
    }
    free(methods);
    
    Method method1 = class_getInstanceMethod(cls, @selector(method1));  //获取特定的实例方法
    if (method1 != NULL) {
        NSLog(@"method %@", NSStringFromSelector(method_getName(method1)));
    }else {
        NSLog(@"no have method");
    }
    NSLog(@"//实例方法---------------------------------------------");
    
    //类方法
    Method classMethod = class_getClassMethod(cls, @selector(classMethod1));  //将类selector转化为Method
    if (method1 != NULL) {
        NSLog(@"classMethod %@", NSStringFromSelector(method_getName(classMethod)));
    }else {
        NSLog(@"no have classMethod");
    }
    
    NSLog(@"MyClass is%@ responsd to selector: method3WithArg1:arg2:", class_respondsToSelector(cls, NSSelectorFromString(@"method3WithArg1:arg2:")) ? @"" : @" not");
    
    IMP imp = class_getMethodImplementation(cls, NSSelectorFromString(@"method3WithArg1:arg2:"));   //获取方法的实现指针IMP  这个IMP可直接调用
    ((void (*) (id, SEL, ...))imp)(class1, NSSelectorFromString(@"method3WithArg1:arg2:"), @2, @"sda");
    
    NSLog(@"//类方法---------------------------------------------");
    
    //替换方法实现IMP
    IMP method2IMP = class_getMethodImplementation(cls, NSSelectorFromString(@"method2"));
    class_replaceMethod(cls, NSSelectorFromString(@"method1"), method2IMP, "V@:");
    class_replaceMethod(cls, NSSelectorFromString(@"method3WithArg1:arg2:"), (IMP)NewClassMethod, "V@:");
    [class1 method1];
    
    NSLog(@"//替换方法实现IMP---------------------------------------------");

    
    // 协议
    
    Protocol *UITableViewDelegate = objc_getProtocol("UITableViewDelegate");  //根据name生成一个protocol   这个protocol要存在
    class_addProtocol(cls, UITableViewDelegate);                              //给指定类添加一个protocol
    
    Protocol *newProtocol = objc_allocateProtocol("NewProtocol");     //分配一个新的协议   协议添加方法 属性需要在注册之前完成
    
    objc_registerProtocol(newProtocol);                               //注册协议
    
    Protocol * __unsafe_unretained * protocols = class_copyProtocolList(cls, &count);   //获取协议列表
    Protocol * protocol;
    for (int i = 0; i < count; i++) {
        protocol = protocols[i];
        NSLog(@"protocol name: %s", protocol_getName(protocol));
    }
    NSLog(@"MyClass is%@ responsed to protocol %s", class_conformsToProtocol(cls, protocol) ? @"" : @" not", protocol_getName(protocol));   //是否遵循协议&获取协议名
    NSLog(@"// 协议---------------------------------------------");

    
    
    
//    Class *classes = objc_copyClassList(count);  //App所有的类(包含系统)
//    for (int i = 0; i < *count; i++) {
//        NSLog(@"class name is %s", class_getName(classes[i]));
//    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma MyClass添加属性的setter &getter  写在这里其实不合适
id age(id instance, SEL sel) {
    NSString *key = NSStringFromSelector(sel);
    Ivar ivar = class_getInstanceVariable([instance class], "_propertys");
    NSDictionary *dict = object_getIvar(instance, ivar);
    return [dict valueForKey:key];
}

void setAge(id instance, SEL sel, id newValue) {
    NSString *selString = NSStringFromSelector(sel);
    NSString *key = [[selString substringWithRange:NSMakeRange(3, selString.length - 4)] lowercaseString];
    Ivar ivar = class_getInstanceVariable([instance class], "_propertys");
    NSMutableDictionary *dict = object_getIvar(instance, ivar);
    if (!dict) {
        dict = [NSMutableDictionary dictionary];
        object_setIvar(instance, ivar, dict);
    }
    [dict setValue:newValue forKey:key];
}


#pragma mark --运行时创建新的类&Meta-Class

void NewClassMethod(id instance, SEL sel, id argm1, id argm2) {
    NSLog(@"this object is %p  SEL:%@  argm1:%@  argm2:%@", instance, NSStringFromSelector(sel), argm1, argm2);
    NSLog(@"Class is %@, super class is %@", [instance class], [instance superclass]);
    
    Class currentClass = [instance class];
    int i = 0;
    do {
        NSLog(@"Following the isa pointer %d times gives %p", i, currentClass);
        currentClass = objc_getClass((__bridge void *)currentClass);
    } while (currentClass != nil);
    
     NSLog(@"NSObject's class is %p   meta class is %p", [NSObject class], objc_getClass((__bridge void *)[NSObject class]));
    
}

- (void)ex_registerNewClass {
//    创建一个新类NewErrorClass 父类是NSError
    Class newClass = objc_allocateClassPair([NSError class], "NewErrorClass", 0);
//    为新类添加一个方法
    class_addMethod(newClass, NSSelectorFromString(@"testNewClassSelArgm1: Argm2:"), (IMP)NewClassMethod, "V@:");
    //创建类的操作要在这个之前完成（包括添加方法和属性、实例变量...）  不能为现有的类和元类添加实例变量
    class_addIvar(newClass, "name", sizeof(NSString *), log2(sizeof(NSString *)), @encode(NSString *));
    objc_registerClassPair(newClass);
    
    id instance = [[newClass alloc] initWithDomain:@"domain" code:0 userInfo:nil];
    Ivar name = class_getInstanceVariable(newClass, "name");
    object_setIvar(instance, name, @"jfy");
    NSLog(@"newClass name is %@", object_getIvar(instance, name));
//    这个有警告
    [instance performSelector:NSSelectorFromString(@"testNewClassSelArgm1: Argm2:") withObject:@"aaa" withObject:@"bbb"];
//    NewClassMethod(instance, NSSelectorFromString(@"testNewClassSelArgm1: Argm2:"), @"aaa", @"bbb");
    NSLog(@"// 创建一个新类---------------------------------------------");
}


@end
