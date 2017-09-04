//
//  NSObject+FSKVO.m
//  Runtime
//
//  Created by vcyber on 17/8/23.
//  Copyright © 2017年 vcyber. All rights reserved.
//

#import "NSObject+FSKVO.h"
#import <objc/message.h>

static const void *observerKey = &observerKey;
static const void *keyPathKey = &keyPathKey;
static const void *optionsKey = &optionsKey;
static const void *setterKey = &setterKey;
static const void *oldValueKey = &oldValueKey;

@implementation NSObject (FSKVO)

- (void)fs_addObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context {
    //1.动态生成一个类
    NSString *oldClassName = NSStringFromClass([self class]);
    NSString *newClassName = [@"FS_" stringByAppendingString:oldClassName];
    Class newClass = objc_allocateClassPair([self class], newClassName.UTF8String, 0);
    //2.为新生成的类添加setter方法
    NSString *setter = [@"set" stringByAppendingString:[[keyPath capitalizedString] stringByAppendingString:@":"]];
    class_addMethod(newClass, NSSelectorFromString(setter), (IMP)setKeyPath, "v@:@");
    objc_registerClassPair(newClass);
    //修改被观察者的isa指针!!让它指向自定义的类!!
    object_setClass(self, newClass);
    //3.获取旧值
    id oldValue = [self valueForKeyPath:keyPath];
    //3.保存observer keyPath options setter 旧值 用于消息发送
    objc_setAssociatedObject(self, observerKey, observer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(self, keyPathKey, keyPath, OBJC_ASSOCIATION_COPY);
    objc_setAssociatedObject(self, optionsKey, @(options), OBJC_ASSOCIATION_ASSIGN);
    objc_setAssociatedObject(self, setterKey, setter, OBJC_ASSOCIATION_COPY);
    objc_setAssociatedObject(self, oldValueKey, oldValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


void setKeyPath(id self, SEL _cmd, id newValue) {
    id class = [self class];
    //改变当前对象指向父类!!
    object_setClass(self, class_getSuperclass(class));
    //调用父类的setter方法
    
    NSString *setter = objc_getAssociatedObject(self, setterKey);
    objc_msgSend(self, NSSelectorFromString(setter), newValue);
    //取出观察者 转发消息
    id observer = objc_getAssociatedObject(self, observerKey);
    NSString *keyPath = objc_getAssociatedObject(self, keyPathKey);
    NSUInteger options = [objc_getAssociatedObject(self, optionsKey) unsignedIntegerValue];
    NSMutableDictionary<NSKeyValueChangeKey, id> *change = [NSMutableDictionary dictionary];
    if (options & NSKeyValueObservingOptionNew) {
        change[NSKeyValueChangeNewKey] = newValue;
    }
    if (options & NSKeyValueObservingOptionOld) {
        change[NSKeyValueChangeOldKey] = objc_getAssociatedObject(self, oldValueKey);
    }
    objc_msgSend(observer, @selector(observeValueForKeyPath:ofObject:change:context:), keyPath, self, change, NULL);
    object_setClass(self, class);
    objc_setAssociatedObject(self, oldValueKey, newValue, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end
