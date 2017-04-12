//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


//非泛型

func swapTowInts(inout a: Int, inout b: Int) -> Void {
    let temp = a
    a = b
    b = temp
    
}

var someInt = 3
var anotherInt = 10
swapTowInts(&someInt, b: &anotherInt)
someInt
anotherInt


//泛型函数

func swapTowValue<T>(inout a: T, inout b: T) -> Void {
    let temp = a
    a = b
    b = temp
    
}


swapTowValue(&someInt, b: &anotherInt)
someInt
anotherInt

var someString = "Hello"
var anotherString = "World"
swapTowValue(&someString, b: &anotherString)
someString
anotherString

//非泛型的
struct IntStack {
    var items = [Int]()
    
    mutating func push(item: Int) {
        items.append(item)
    }
    
    mutating func pop() -> Int {
        return items.removeLast()
    }
}

//泛型
struct Stack<T> {
    var items = [T]()
    mutating func push(item: T) -> Void {
        items.append(item)
    }
    
    mutating func pop() -> T {
        return items.removeLast()
    }
    
}



var stackOfString = Stack<String>()
stackOfString.push("uno")
stackOfString.push("dos")
stackOfString.push("tres")
stackOfString.push("cuatro")

let fromTheTop = stackOfString.pop()
stackOfString.items



//扩展泛型类型

extension Stack {
    var topItem: T? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
    
}

if let topItem = stackOfString.topItem {
    topItem
}



//类型约束
//类型约束语法

//func someFunction<T: someClass, U: SomeProtocol>(someT: T, someU: U) -> Void {
//    
//}


//类型约束行为

func findIndex(ofString valueToFind: String, in array: [String]) -> Int? {
    for (index, value) in array.enumerate() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

let strings = ["cat", "dog", "llama", "parakeet", "terrapin"]
if let foundIndex = findIndex(ofString: "llama", in: strings) {
    foundIndex
}


//泛型版本

func findIndex1<T: Equatable>(of ValueToFind: T, in array: [T]) -> Int? {
    for (index, value) in array.enumerate() {
        if value == ValueToFind {
            return index
        }
    }
    return nil
}


let doubleIndex = findIndex1(of: 9.3, in: [11, 23, 2.3, 9.3])
let stringIndex = findIndex1(of: "dog", in: strings)


//关联类型


protocol Container {
    associatedtype ItemType
    mutating func append(item: ItemType)
    var count: Int { get }
    subscript(i: Int) -> ItemType { get }
}




struct IntStack1: Container{
    
    var items = [Int]()
    mutating func push(item: Int) {
        items.append(item)
    }
    
    mutating func pop() -> Int{
        return items.removeLast()
    }
    
    typealias ItemType = Int
    mutating func append(item: Int) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) ->Int {
        return items[i]
    }
    
}



struct Stack1<T>: Container {
    var items = [T]()
    mutating func push(item: T) {
        items.append(item)
    }
    
    mutating func pop() -> T {
        return items.removeLast()
    }
    
    
    mutating func append(item: T) {
        self.push(item)
    }
    
    var count: Int {
        return items.count
    }
    
    subscript(i: Int) -> T {
        return items[i]
    }
    
    
}



//扩展一个存在的类型为一指定关联类型
extension Array: Container {
    
}


//Where语句  类型约束

func allItemsMatch<C1: Container, C2: Container where C1.ItemType == C2.ItemType, C1.ItemType: Equatable>(someContainer: C1, _ anotherContainer: C2) -> Bool {
    
    if someContainer.count != anotherContainer.count {
        return false
    }
    
    for i in 0..<someContainer.count{
        if someContainer[i] != anotherContainer[i] {
            return false
        }
    }
    
    return true
}


var stackOfStrings = Stack1<String>()
stackOfStrings.push("uno")
stackOfStrings.push("dos")
stackOfStrings.push("tres")

var arrayOfStrings = ["uno", "dos", "tres"]

allItemsMatch(stackOfStrings, arrayOfStrings)














