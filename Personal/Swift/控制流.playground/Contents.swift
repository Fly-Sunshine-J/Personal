//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

/////////////////////////////////////////////  For循环  ///////////////////////////////////////////
//如果用不到循环的每一项的值, 可以使用_(下划线)代替
let base = 3
var power = 1

for _ in 1...10 {
    power *= base
}
power

//while循环  每次在循环开始的时候计算条件是否符合
//repeat-while 在执行一次循环结束后判断计算条件是否符合(保证执行一次循环体)


let finalSquare = 25
var board = [Int](count: finalSquare + 1, repeatedValue: 0)

board[3] = +08; board[10] = +02; board[9] = +09; board[6] = +11
board[14] = -10; board[19] = -11; board[24] = -8; board[22] = -2

var square  = 0;
var diceRoll = 0
//while square < finalSquare {
//    diceRoll = Int(arc4random()) % 6 + 1
//    print(diceRoll)
//    square   += diceRoll
//    if square < finalSquare {
//        square   += board[square]
//        print(board[square])
//    }
//}
//print("Game Over")

repeat {
    square += board[square]
    diceRoll = Int(arc4random()) % 6 + 1
    square += diceRoll
} while square < finalSquare



//swicth语句的每一个case语句至少一条语句  如果为空会报错
let anotherCharacter:Character = "a"
//switch anotherCharacter {
//    case "a":  //没有语句会报错 可以写一个break
//    case "A":
//    print("The letter A")
//    default:
//    print("Not the letter A")
//}


//switch区间匹配
let approximateCount = 62
let countedThings = "moon orbiting Staturn"
var naturalCount: String
switch approximateCount {
    case 0:
    naturalCount = "No"
    case 1..<5:
    naturalCount = "a few"
    case 5..<12:
    naturalCount = "several"
    case 12..<100:
    naturalCount = "dozens of"
    case 100..<1000:
    naturalCount = "hundreds of"
    default:
    naturalCount = "many"
}

print(naturalCount)


//元组
let somePoint = (1, 1)
switch somePoint {
case (0, 0):
    print("(0, 0)is at the origin")
case (_, 0):
    print("(\(somePoint.0), 0) is on the x-axis")
case (0, _):
    print("(0, \(somePoint.1) is on the y-axis)")
case (-2...2, -2...2):
    print("(\(somePoint.0), \(somePoint.1)) is inside the box")
default:
    print("(\(somePoint.0), \(somePoint.1)) is outside of the box")
}

//值绑定
let anotherPoint = (2, 0)
switch anotherPoint {
case (let x, 0):
    print("on the x-axis with an x value of \(x)")
case (0, let y):
    print("on the y-axis with a y value of \(y)")
case (let x, let y):
    print("somewhere else at (\(x), \(y))")
}


//case语句中使用where来判断额外的条件
let yetAnotherPoint = (1, -1)
switch yetAnotherPoint {
case let (x, y) where x == y:
    print("(\(x), \(y)) is on the line x == y")
case let (x, y) where x == -y:
    print("(\(x), \(y)) is on the line x == -y")
case let (x, y):
    print("(\(x), \(y)) is just some arbitrary point")
}


////////////////////////////////////////    控制转移语句    ////////////////////////////////////////////////
//5种控制转移语句
/**
 *  continue
    break;
    fallthrough
    return
    throw
 */


//continue  停止本次迭代
let puzzleInput = "great minds think alike"
var puzzleOut = ""
for character in puzzleInput.characters {
    switch character{
        case "a", "e", "i", "o", "u", " ":
            continue
    default:
        puzzleOut.append(character)
        
    }
}

print(puzzleOut)

//break   结束整个控制流的执行

let numberSymbol: Character = "三"
var possibleIntegerValue: Int?
switch numberSymbol {
case "1", "١", "一", "๑":
    possibleIntegerValue = 1
case "2", "٢", "二", "๒":
    possibleIntegerValue = 2
case "3", "٣", "三", "๓":
    possibleIntegerValue = 3
case "4", "٤", "四", "๔":
    possibleIntegerValue = 4
default:
    break
}

if let possibleValue = possibleIntegerValue {
    print("The integer value of \(numberSymbol) is \(possibleValue)")
}else {
    print("An integer value could not be found for \(numberSymbol)")
}


//fallthrough 贯穿,比较像c语言中 switch中不使用break一样
let integerToDescribe = 5;
var description = "The number \(integerToDescribe) is"
switch integerToDescribe {
case 2, 3, 5, 7, 11, 17:
    description += "a prime number, and also"
    fallthrough
default:
    description += " an integer"
}

print(description)


//带标签的语句
square = 0
diceRoll = 0
gameLoop: while square != finalSquare {
    diceRoll = Int(arc4random() % 6 + 1)
    switch square + diceRoll {
    case finalSquare:
        break gameLoop
    case let newSquare where newSquare > finalSquare :
        continue gameLoop
    default:
        square += diceRoll
        square += board[square]
    }
}



//提前退出  return  和oc用法一样
func greet(person: [String: String]) {
//    guard执行取决于一个表达式的bool guard后面必须跟一个else 条件为真 执行gurad后面的语句  否则执行else
    guard let name = person["name"] else {
        return
    }
    print("Hello \(name)")
    
    guard let location = person["location"] else {
        print("I hope the weather is nice near you")
        return
    }
    
    print("I hope the weather is nice in \(location)")
    
}

greet(["name": "Jhon"])
greet(["name": "Jane", "location": "Cupertino"])

//监测API是否可用
//if里面的代码段只能在iOS&或者以上可运行
if #available(iOS 7.1, *) {
    
}else {
    
}



