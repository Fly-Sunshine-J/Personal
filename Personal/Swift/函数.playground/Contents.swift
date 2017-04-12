//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


/////////////////////////////////////////       函数的定义和调用      //////////////////////////////
func sayHello(personeName:String) -> String {
    let greeting = "Hello " + personeName
    return greeting
}

sayHello("Jhon")


/////////////////////////////////////////   函数的参数和返回值     ////////////////////////////////
func halfOpenRangeLength(start: Int, end: Int) -> Int {
    
    return end - start
}

print(halfOpenRangeLength(1, end: 10))

//无参函数
func sayHelloWord() -> String {
    return "Hello Word"
}

sayHelloWord()

//无返回值的参数
func sayGoodbye(personName: String) {
    print("Goodbye \(personName)")
}
sayGoodbye("Jhon")


//多个返回值  返回的其实是元组
func minMax(array:[Int]) -> (min:Int, max:Int){
    
    var currentMin = array[0]
    var currentMax = array[0]
    for item in array {
        if currentMin > item {
            currentMin = item
        }else if currentMax < item {
            currentMax = item
        }
        
    }
    
    return (currentMin, currentMax)
}


let bounds = minMax([8, -3, 2, 102, 3, 4])
print("min is \(bounds.min), max is \(bounds.max)")


//可选元组返回类型

func minMax2(array:[Int]) -> (min:Int, max:Int)? {
    if array.isEmpty {
        return nil
    }
    
    var currentMin = array[0]
    var currentMax = array[0]
    for item in array {
        if currentMin > item {
            currentMin = item
        }else if currentMax < item {
            currentMax = item
        }
        
    }
    
    return (currentMin, currentMax)
}


if let bound = minMax2([8, -3, 2, 102, 3, 4]) {
    print("min is \(bound.min), max is \(bound.max)")
}


//指定外部参数名
func sayHelloToAnd(to person: String, and anotyherPerson: String) -> String {
    
    return "Hello \(person) and \(anotyherPerson)"
}

sayHelloToAnd(to: "Jhon", and: "Bill")


//忽略外部参数
func someFUnction(firstParaName: Int, _ secondParaName: Int) {
    
}

someFUnction(1, 10)


//默认参数值  //调用的时候不传入参数  会使用默认的参数
func anotherFunc(paramDefault: Int = 10) -> Int{
    return paramDefault
}

anotherFunc()
anotherFunc(2)


/////////////////////////////////////    可变参数    /////////////////////////////////////////
//如果除了可变参数外的其他参数  可变参数放在最后
func arithemticMean(numbers:Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}

arithemticMean(1, 2, 3, 4, 5)


//输入输出参数  感觉像指针
/**
 *  如果想要一个函数可以修改参数的值 并且想要在这些修改在函数调用后仍然存在 那么就应该把这个参数定义为输入输出参数
 */
func swapTwoInts(inout a: Int, inout _ b: Int) -> Void {
    let temp = a
    a = b
    b = temp
}

var someInt = 10
var anotherInt = 20
swapTwoInts(&someInt, &anotherInt)
print("someInt = \(someInt), anotherInt = \(anotherInt)")


//函数类型   由函数的参数类型和返回类型组成
func addTwoInts(one: Int, tow: Int) -> Int {
        return one + tow
}
//函数类型  (Int, Int) -> Int 有两个Int行的参数并返回一个Int型的值

func printHello() {
    
}

//函数类型  () -> Void  没有参数,并返回Void类型的函数


//使用函数类型
//定义一个mathFunc的变量  类型是两个Int参数和一个返回值Int的型的函数  并指向addTowInts
var mathFunc: (Int, Int) -> Int = addTwoInts
print(mathFunc(10, 20))


//函数类型作为参数类型
func printMathResult(mathFunc:(Int, Int) -> Int, _ a: Int, _ b: Int) {
    
    print(mathFunc(a, b))
}

printMathResult(addTwoInts, 20, 30)


//函数类型作为返回值
func stepForward(input: Int) ->Int {
    return input + 1
}

func stepBackward(input: Int) -> Int {
    return input - 1
}


func chooseSetpFunc(backward: Bool) -> (Int) -> Int {
    return backward ? stepBackward : stepForward
}

var currentValue = 10
while currentValue != 0 {
    print(currentValue)
    currentValue = chooseSetpFunc(true)(currentValue)
}



//嵌套函数
func chooseFunc(backwards: Bool) -> (Int) -> Int {
    func stepF(input: Int) -> Int { return input + 1 }
    func stepW(input: Int) -> Int { return input - 1 }
    
    return backwards ? stepW : stepF
}

currentValue = -4
while currentValue != 0 {
    print(currentValue)
    currentValue = chooseSetpFunc(false)(currentValue)
}













