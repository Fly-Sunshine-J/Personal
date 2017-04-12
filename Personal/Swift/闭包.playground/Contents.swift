//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"];

func backwards(s1: String, s2: String) -> Bool {
    return s1 > s2
}

var resversed = names.sort(backwards)

//闭包的一般形式
//{(参数) -> 返回值 in
//    算法
//}

resversed = names.sort({(s1: String, s2: String) -> Bool in
    return s1 > s2
})


//闭包可以根据上下文推断类型
resversed = names.sort({s1, s2 in return s1 > s2})


//单表达式闭包隐式返回
resversed = names.sort({s1, s2 in s1 > s2})

//参数名称缩写
resversed = names.sort({$0 > $1})

//运算符函数
resversed = names.sort(<)

//尾随闭包   将闭包作为函数的最后一个参数传递给参数
func someFunctionThatTakesAClosure(closure:() -> Void) {
    
    //函数部分
}

//不使用尾随闭包进行函数调用
someFunctionThatTakesAClosure({
    
//    闭包主体部分
})


//使用尾随闭包进行函数调用
someFunctionThatTakesAClosure(){
//    闭包主体部分
}


resversed = names.sort(){$0 > $1}

let digitNames = [0: "Zero", 1: "One", 2: "Tow", 3: "Three", 4: "Four", 5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"]

let numbers = [16, 58, 510]
let strings = numbers.map(){(number) -> String in
    var output = ""
    var number = number
    while number > 0  {
        output = digitNames[number % 10]! + output
        number /= 10
    }
    return output
}


//捕获值
func makeIncrementor(forIncrement amount: Int) -> () -> Int {
    
    var runningTotal = 0
    func incrementor() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementor
}

let incermentorByTen = makeIncrementor(forIncrement: 10)
incermentorByTen()
incermentorByTen()
incermentorByTen()


let incrementBySeven = makeIncrementor(forIncrement: 7)
incrementBySeven()

incermentorByTen()

//闭包的引用类型 如果将闭包赋值给不同的常量或者变量, 两个值都会指向同一个闭包
let alsoIncrementByTen = incermentorByTen
alsoIncrementByTen()

















