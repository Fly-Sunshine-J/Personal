//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


//扩展语法

//extension SomeType {
//    
//}

//extension SomeType: SomeProtocol, AotherProtocol {
//
//}



//计算型属性

extension Double {
    var km: Double {return self * 1000.0}
    var m: Double {return self}
    var cm: Double {return self / 100}
    var mm: Double {return self / 1000}
    
}

let oneInch = 25.4.mm

let threekm = 4.km

let aMarathon = 42.km + 195.m

/*********************************************************************************
 *扩展可以添加新的计算属性, 但是不能添加存储属性 也不可以向已有的属性添加属性观察器
 *
 *********************************************************************************/


//扩展可以向已有的类型添加新的构造器

struct Size {
    var width = 0.0, height = 0.0
    
}

struct Point {
    var x = 0.0, y = 0.0
    
}

struct Rect {
    var origin = Point()
    var size = Size()
    
}


let defaultRect = Rect()

let memberwiseRect = Rect(origin: Point(x: 2, y: 2), size: Size(width: 4, height: 4))

//扩展中添加新的构造器
extension Rect {
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
        
    }
}

let centerRect = Rect(center: Point(x: 4, y: 4), size: Size(width: 3, height: 3))



//向扩展中添加新的实例方法和类型方法
extension Int {
    func repetitions(task: () -> ()) -> Void {
        for _ in 0 ..< self {
            task()
        }
    }
}

3.repetitions({print("Hello")})

//修改实例方法  通过扩展可以实现修改自身实例  结构体和枚举中修改self或者属性的方法 必须将该实例方法标注为mutating

extension Int {
    mutating func square() {
        self = self * self
    }
}

var someInt = 10
someInt.square()


//扩展下标

extension Int {
    subscript(index: Int) -> Int {
        var decimalBase = 1
        for _ in 0 ..< index {
            decimalBase *= 10
        }
        return (self / decimalBase) % 10
    }
}

364236483[2]
364236483[5]
364236483[8]
//超出index会是0 相当于 00364236483[10]
364236483[10]


//扩展的嵌套类型

extension Int {
    enum Kind {
        case Negative, Zero, Positive
    }
    
    var kind: Kind {
        switch self {
        case 0:
            return .Zero
        case let x where x > 0:
            return .Positive
        default:
            return .Negative
        }
    
    }
    
}


func printintegerKinds(numbers: [Int]) -> Void {
    for number in numbers {
        switch number.kind {
        case .Negative:
            print("- ", terminator: "")
        case .Zero:
            print("0 ", terminator: "")
        case .Positive:
            print("+ ", terminator: "")
        
        }
    }
}

printintegerKinds([3, 4, 0, -1, 8, 0, -4])












