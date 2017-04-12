//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


class Apartment {
    let number: Int
    init(number: Int) {
        self.number = number
    }
    var tenant: Person?
    deinit {
        print("Apartment \(number) is being deinit");
    }
    
}

class Person {
    
    let name: String
    init(name: String) {
        
        self.name = name;
        print("\(name) is being init");
    }
    var apartment: Apartment?
    
    deinit {
        print("\(name) is being deinit");
    }
}


var reference1: Person?
var reference2: Person?
var reference3: Person?

reference1 = Person(name: "John");
reference2 = reference1
reference3 = reference1
reference1 = nil
reference2 = nil
//Person实例并没有被销毁
reference3 = nil
//Person实例被销毁


var john: Person?
var number73: Apartment?
john = Person(name: "John Appleseed")
number73 = Apartment(number: 73)

john!.apartment = number73
number73!.tenant = john

john = nil
number73 = nil
//并没有调用析构函数


//如果引用有些时候没有值,可以使用弱引用避免循环强引用  如果引用总有值,则可以使用无主引用

//弱引用(必须是变量  不能是常量)

class Apartment1 {
    let number: Int
    init(number: Int) {
        self.number = number
    }
    //弱引用
    weak var tenant: Person1?
    deinit {
        print("Apartment \(number) is being deinit");
    }
    
}

class Person1 {
    
    let name: String
    init(name: String) {
        
        self.name = name;
        print("\(name) is being init");
    }
    var apartment: Apartment1?
    
    deinit {
        print("\(name) is being deinit");
    }
}

var p1: Person1?
var a1: Apartment1?

p1 = Person1(name: "person1");
a1 = Apartment1(number: 1);

p1!.apartment = a1
a1!.tenant = p1

p1 = nil
a1 = nil



//无主引用
//由于无主引用永远都是有值的  所以无主引用总是被定义为非可选类型
//顾客不一定有信用卡 但是信用卡肯定属于某一个顾客
class Customer {
    let name: String
    var card: CreditCard?
    
    init(name: String) {
        self.name = name;
    }
    
    deinit {
        print("\(name) is being deinit")
    }
    
}


class CreditCard {
    let number: UInt64
    unowned let customer: Customer
    init (number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    
    deinit {
        print("Card \(number) is being deinit")
    }
}


var xiaoM: Customer?
xiaoM = Customer(name: "xiaoM")
xiaoM!.card = CreditCard(number: 1234_8888_8888_8888, customer: xiaoM!)

xiaoM = nil



//无主引用以及隐式解析可选属性

class Country {
    let name: String
    var capitalCity: City!
    
    init (name: String, capitalName:String) {
        self.name = name
        self.capitalCity = City(name: capitalName, country: self)
    }
    
}


class City {
    
    let name: String
    unowned let country: Country
    init (name: String, country: Country) {
        self.name = name;
        self.country = country;
    }
}


var country = Country(name: "Canada", capitalName: "Ottawa")
print("\(country.name)'s capital city is called \(country.capitalCity.name)")





/********************************************************************************
 *当类的属性相互持有,如果两个属性的值都可以为空      使用弱引用(weak)解决强引用问题
 *当类的属性相互持有,如果两个属性的值有一个不可为空   使用无主引用(unowned)解决强引用问题
 *当类的属性相互持有,如果两个属性的值有都不可为空    使用无主引用以及隐式解析可选属性解决强引用问题
 *********************************************************************************/



//闭包引起的循环强引用

class HTMLElement {
    let name: String
    let text: String?
    
    lazy var asHTML:() -> String = {
        
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        }else {
            return "<\(self.name)>"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinit")
    }
    
}


var pagegraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")
print(pagegraph!.asHTML)
pagegraph = nil
//不会销毁实例对象

//解决闭包引起的循环强引用

class HTMLElement1 {
    let name: String
    let text: String?
    
    lazy var asHTML:() -> String = {
        [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        }else {
            return "<\(self.name)>"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinit")
    }
    
}


var pagegraph1: HTMLElement1? = HTMLElement1(name: "p", text: "hello, world")
print(pagegraph1!.asHTML)
pagegraph1 = nil





        