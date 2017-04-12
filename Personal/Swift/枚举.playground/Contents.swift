//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

//定义一个枚举
enum CompassPoint {
    case North
    case South
    case East
    case West
}

enum Planet {
    case mercury, venus, earth, mars, jupiter, staurn, uranus, nepturn
}

//directionToHead已经被声明为CompassPoint类型  那下次访问的时候可以直接只用.来改变它的值
var directionToHead = CompassPoint.West
directionToHead = .East


//匹配枚举值和switch语句
directionToHead = .South
switch directionToHead {
case .North:
    print("Lots of planets have a north")
case .South:
    print("Watch out for penguins")
case .East:
    print("Where the sun rises")
case .West:
    print("Where the skies are blue")
}

let somePlanet = Planet.earth
switch somePlanet {
case .earth:
    print("Mostly harmless")
default:
    print("Not a safe place for humans")
}



//相关值
enum Barcode {
    case UPCA(Int, Int, Int, Int)
    case QRCode(String)
}


var productBarcode = Barcode.UPCA(8, 85909, 51226, 3)
productBarcode = .QRCode("ABCDEFG")

//这个时候的switch语句  不能直接匹配枚举的值, 但是可以匹配相关值
switch productBarcode {
case .UPCA(let numberSystem, let manufacturer, let product, let check):
    print("UPC-A:\(numberSystem), \(manufacturer), \(product), \(check)")
case .QRCode(let s):
    print("QRCode:\(s)")
}


//如果枚举成员所有的相关被提取为常量或变量,可以在成员名称前标注
switch productBarcode {
case var .UPCA(numberSystem, manufacturer, product, check):
    print("UPC-A:\(numberSystem), \(manufacturer), \(product), \(check)")
case let .QRCode(s):
    print("QRCode:\(s)")
}


//原始值
enum ASCIIControlCharacter:Character {
    case Tab = "\t"
    case LineFeed = "\n"
    case CarriageReturn = "\r"
}


//原始值的隐式赋值  当原始值是整数或者字符串类型的时候
//原始值1, 2, 3...
enum Planet2: Int {
    case Mercury = 1, Venus, Earth, Mars, Jupiter, Saturn, Uranus, Nepturn
}

//原始值North, South...
enum CompassPoint1: String {
    case North, South, East, West
}

let earthOrder = Planet2.Earth.rawValue

let sunsetDirection = CompassPoint1.West.rawValue


//使用原始值来初始化枚举
let possiblePlanet = Planet2(rawValue:7)

let possibleToFind = 11
if let somePlanet = Planet2(rawValue:possibleToFind) {
    switch somePlanet {
    case .Earth:
        print("Mostly harmless")
    default:
        print("Not a safe place for humans")
        
    }
}else {
    print("There is not a planet at position \(possibleToFind)")
}


//递归枚举
enum ArithemticExpression {
    case Number(Int)
    indirect case addition(ArithemticExpression, ArithemticExpression)
    indirect case multiplication (ArithemticExpression, ArithemticExpression)
}


indirect enum ArithemticExpression1 {
    case Number(Int)
    case addition(ArithemticExpression1, ArithemticExpression1)
    case multiplication(ArithemticExpression1, ArithemticExpression1)
}


func evaluate(expression:ArithemticExpression) -> Int {
    switch expression {
    case .Number(let value):
        return value
    case .addition(let left, let right):
        return evaluate(left) + evaluate(right)
    case .multiplication(let left, let right):
        return evaluate(left) * evaluate(right)
    }
}


let five = ArithemticExpression.Number(5)
let four = ArithemticExpression.Number(4)
let sum = ArithemticExpression.addition(five, four)
let product = ArithemticExpression.multiplication(sum, four)
evaluate(product)
























