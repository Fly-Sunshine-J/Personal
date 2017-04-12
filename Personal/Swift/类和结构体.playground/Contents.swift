//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

//类的定义和结构体的定义
struct Resolution {
    var width = 0
    var height = 0
}

class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}

//类和结构体的实例
let someResolution = Resolution()
let someVideoMode = VideoMode()

//访问属性
print("The width of someResolution is \(someResolution.width)")


someVideoMode.resolution.width = 1280
print("The width of someResolution is \(someVideoMode.resolution.width)")


//结构体类型的成员逐一构造器
let vga = Resolution(width: 640, height: 480)

//结构体和枚举变量
let hd = Resolution(width: 1920, height: 1080)
var cinema = hd

//将hd赋值给cinema的时候,是进行了hd中所有值得copy 然后将copy的值存储到新的cinema实例中
cinema.width = 2048
print("cinema is now \(cinema.width) pixels wide")
print("hd is still \(hd.width) pixels wide")

//类的引用类型  类的赋值操作不是进行copy 而是对其进行操作, 相当于传递的是指针
let tenEighty = VideoMode()
tenEighty.resolution = hd
tenEighty.interlaced = true
tenEighty.name = "10801"
tenEighty.frameRate = 25.0

let alsoTenEighty = tenEighty
alsoTenEighty.frameRate = 30.0
print("The frameRate property of tenEighty is now \(tenEighty.frameRate)")


//恒等运算符 === !== (引用类型) == != (值类型)
if tenEighty === alsoTenEighty {
    print("tenEighty and alsoTenEighty refer to the same Resolution instance")
}





