//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

/**
 *swift中的属性分为两种 一种是存储属性 一种是计算属性  计算属性可用于类, 结构体和枚举  而存储属性只能用于类和结构体
 */

//存储属性
struct FixedLengthRange {
    var firstValue: Int
    let length: Int
    
}

var rangeOfThreeItems = FixedLengthRange(firstValue: 0, length: 3)
rangeOfThreeItems.firstValue = 6
//rangeOfThreeItems.length = 10

/**
 *  常量结构体的存储属性  如果创建一个常量的结构体, 则无法修改实例的任何属性  原因是结构体是值类型, 当一个值类型被声明为常量,它的属性也就成了常量 不可修改
 */
let rangeOfFourItems = FixedLengthRange(firstValue: 1, length: 4)
//rangeOfFourItems.firstValue = 0


//延迟存储属性 (lazy)  延迟属性的声明必须是变量(var)  只用你使用到这个实例的时候才会去创建  但是无法保证线程安全  因为在没有初始化的时候被多个线程访问 无法保证只会被初始化一次

class DataImporter {
    var fileName = "data.txt"
    
}

class DataManager {
    lazy var importer = DataImporter()
    var data = [String]()
    
}

let manager = DataManager()
manager.data.append("some data")
manager.data.append("some more data")

print(manager.importer.fileName)



//计算属性  计算属性不直接存储值, 而是提供一个getter和一个可选的setter  来间接获取和设置属性或变量的值
struct Point {
    var x = 0.0, y = 0.0
    
}

struct Size {
    var width = 0.0, height = 0.0
    
}

struct Rect {
    var origin = Point()
    var size = Size()
//    计算属性center
    var center: Point{
        get {
            let centerX = origin.x + size.width / 2
            let centerY = origin.y + size.height / 2
            return Point(x: centerX, y: centerY)
        }
        
        set(newCenter) {
            origin.x = newCenter.x - size.width / 2
            origin.y = newCenter.y - size.height / 2
        }
    }
    
    
}

var square = Rect(origin: Point(x: 0, y: 0), size: Size(width: 100, height: 100))
let squareCenter = square.center
square.center = Point(x: 100, y: 100)
print("square.origin is now at (\(square.origin.x), \(square.origin.y))")


//便捷setter声明
struct AlternativeRect {
    var origin = Point()
    var size = Size()
    //    计算属性center
    var center: Point{
        get {
            let centerX = origin.x + size.width / 2
            let centerY = origin.y + size.height / 2
            return Point(x: centerX, y: centerY)
        }
        
        set {
            origin.x = newValue.x - size.width / 2
            origin.y = newValue.y - size.height / 2
        }
    }
}


//只读计算属性  只有getter 没有setter的计算属性 就是只读计算属性
struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
    
}

let fourByFiveByTow = Cuboid(width: 4, height: 5, depth: 2)
print("the volume of fourByFiveByTow is \(fourByFiveByTow.volume)")


//属性观察器(willSet(设置前调用), didSet(设置后立即调用))  当属性被设置值的时候都会调用属性观察器, 甚至新值和旧值相同也会调用  可以为延迟属性(layz)之外的其他存储属性添加属性观察器, 也可以通过重载属性的方式为继承的属性添加属性观察器

class StepCounter {
    var totalSteps: Int = 0 {
        willSet {
            print("About to set totalStep to \(newValue)")
        }
        
        didSet {
            print("Added \(totalSteps - oldValue) steps")
        }
    }
    
}

let stepCounter = StepCounter()
stepCounter.totalSteps = 200
stepCounter.totalSteps = 300
stepCounter.totalSteps = 600


//类型属性 就是不管有多少实例,这些属性都只有唯一的一份  特别像静态变量
//值类型的存储型类型属性可以使变量或常量, 计算型类型属性跟实例的计算属性一样只能定义成变量属性
struct SomeStructure {
    static var storedTypeProperty = "Some value"
    static var computedTypeProperty: Int {
        return 1
    }
}

enum SomeEnum {
    static var storedTypeProperty = "Some value"
    static var computedTypeProperty: Int {
        return 2
    }
}

class SOmeClass {
    static var storedTypeProperty = "Some value"
    static var computedTypeProperty: Int {
        return 3
    }
    class var overrideableComputedTypeProperty: Int {
        return 4
    }
}


//获取和设置类型属性的值
print(SomeStructure.storedTypeProperty)
SomeStructure.storedTypeProperty = "Another value"
print(SomeStructure.storedTypeProperty)
print(SomeEnum.computedTypeProperty)
print(SOmeClass.overrideableComputedTypeProperty)


struct AudioChannel {
    static let threshouldLevel = 10
    static var maxInputLevelForAllChannels = 0
    var currentLevel: Int = 0 {
        didSet {
            if currentLevel > AudioChannel.threshouldLevel  {
                currentLevel = 10
            }
            if currentLevel > AudioChannel.maxInputLevelForAllChannels {
                AudioChannel.maxInputLevelForAllChannels = currentLevel
            }
        }
    }
    
}

var leftChannel = AudioChannel()
var rightChannel = AudioChannel()
leftChannel.currentLevel = 7
print(leftChannel.currentLevel)
print(AudioChannel.maxInputLevelForAllChannels)

rightChannel.currentLevel = 11
print(rightChannel.currentLevel)
print(AudioChannel.maxInputLevelForAllChannels)




















