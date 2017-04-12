//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

//实例方法
class Counter {
    var count = 0
    func increment() -> Void {
        count += 1
    }
    
    func increment(by amount: Int) -> Void {
        count += amount
    }
    
    func reset() -> Void {
        count = 0
    }
    
}

let counter = Counter()
counter.increment()
print(counter.count)
counter.increment(by: 4)
print(counter.count)
counter.reset()
print(counter.count)


//结构体和枚举是值类型 默认实例方法是不能修改属性值的, 但是如果需要修改就需要用到变异方法去修改(mutating)

struct Point {
    var x = 0.0, y = 0.0
    func isToTheRightOf(x: Double) -> Bool {
        return self.x > x
    }
    
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        x = x + deltaX
        y = y + deltaY
    }
    
//    变异方法给self赋值
    mutating func moveBy2(x deltaX: Double, y deltaY: Double) {
        self = Point(x: x + deltaX, y: y + deltaY)
    }
    
}
//值类型的数据(包括基本数据)如果被声明为let,不管基本数据是var还是let  全部都是let  不可修改
var somePoint = Point(x: 4, y: 5)
if somePoint.isToTheRightOf(2) {
    print("This Point is to the right of the line where x == 2")
}
//如果somePoint声明为let  这里会报错 原因在上面
somePoint.moveBy(x: 1, y: 1)
print("The point is now at (\(somePoint.x), \(somePoint.y))")

somePoint.moveBy2(x: 1, y: 1)
print("The point is now at (\(somePoint.x), \(somePoint.y))")


//枚举变异方法
enum TriStateSwitch {
    case Off, Low, High
    mutating func next() {
        switch self {
        case .Off:
            self = .Low
        case .Low:
            self = .High
        case .High:
            self = .Off
        }
    }
}

var ovenLight = TriStateSwitch.Low
ovenLight.next()
ovenLight.next()



//类型方法  枚举和结构体使用static   类使用class
class SomeClass {
    class func someTypeMethod() {
        
    }
}

SomeClass.someTypeMethod()


struct LevelTracker {
    static var heighestUnlockedLevel = 1
    var currentLevel = 1
    
    static func unlock(level: Int) {
        if level > heighestUnlockedLevel {
            heighestUnlockedLevel = level
        }
    }
    
    
    static func isUnlocked(level: Int) -> Bool {
        return level <= heighestUnlockedLevel
    }
    
    
    mutating func advance(to level: Int) -> Bool {
        if LevelTracker.isUnlocked(level) {
            currentLevel = level
            return true
        }else {
            return false
        }
    }
    
}


class Player {
    var tracker = LevelTracker()
    let playerName: String
    
    func complete(level: Int) -> Void {
        LevelTracker.unlock(level + 1)
        tracker.advance(to: level + 1)
    }
    
    init(name: String) {
        playerName = name
    }
    
}

var palyer = Player(name: "Jhon")
palyer.complete(3)
print("highest unlocked level is now \(LevelTracker.heighestUnlockedLevel)")


palyer = Player(name: "Beto")
if palyer.tracker.advance(to: 6) {
    print("player is now on level 6")
}else {
    print("level 6 has yet been unlocked")
}

























