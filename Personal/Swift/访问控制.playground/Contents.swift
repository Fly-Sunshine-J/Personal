//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


//访问级别 public供给模块外使用 internal模块内使用(默认)  private 源文件内使用

public class SomePublicClass {           //显示的public类
    public var somePublicProperty = 0    //显示的public类成员
    var someInternalProperty = 0         //隐式的internal类成员
    private func somePrivateMethod() {}   //显示的private类成员
    
}


class SomeInternalClass {               //隐式的internal类
    var someInternalProperty = 0        //隐式的internal类成员
    private func somePrivateMethod() {} //显示的private类成员
}


private class SomePrivateClass {  //显示的private类
    var somePrivateProperty = 0  //隐式的private类成员
    func somePrivateMethod() {   //隐式的private类成员
    
    }
    
}


//元组类型  元组的访问级别与元组中访问级别最低的类型一致
//函数类型  函数的访问级别根据参数类型和返回值类型的访问级别得出  如果得出的级别不符合默认, 就需要显示声明访问级别
//枚举类型  枚举的访问级别继承自该枚举 不能为枚举中的成员单独声明不同的访问级别
//嵌套类型  private级别的类型定义嵌套类型自动拥有private访问级别 public或internal级别中定义嵌套类型自动拥有internal访问级别  如果想拥有public访问级别 需要明确的声明public

//子类   子类的访问级别不能高于父类的访问级别  通过继承重新声明级别可以供给他人使用
public class A {
    private func someMethod() {print("aaa")}
}

public class B: A {
    override internal func someMethod() {
        super.someMethod()
    }
}

var b = B()
b.someMethod()


//getter setter

struct TranckedString {
    private(set) var numberOfEdits = 0 //该属性只能在源文件中使用set
    var value: String = "" {
        didSet {
            numberOfEdits += 1
        }
    }
    
}


var stringToEdit = TranckedString()
stringToEdit.value = "aa"
stringToEdit.value += "bb"
stringToEdit.numberOfEdits


//协议 协议明确访问级别时 你要确保该协议只在你声明的访问级别作用域中使用 协议中的每一个必须要实现的函数都具有和该协议相同的访问级别  协议的继承不能高于父协议的访问级别  一个类遵守了协议那么这个类的访问级别取协议和该类访问级别中最低的那个 也就是说类是public级别 protocol是internal级别  那么类的访问级别就是internal


//扩展  扩展的成员应该具有和原始类成员一致的访问级别 你也可以明确声明扩展的访问级别(private extension)给该扩展内的成员声明一个新的默认访问级别 这个新的默认访问级别仍然可以被单独成员所声明的访问级别所覆盖

//泛型   泛型类型或函数的访问级别去泛型类型 函数本身 泛型类型参数三者中最低访问级别

//类型别名 一个类型别名访问级别不能高于源类型的访问级别 private级别的类型别名可以设定一个public internal private的类型










