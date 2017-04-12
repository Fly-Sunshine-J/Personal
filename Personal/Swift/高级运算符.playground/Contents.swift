//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


//位运算(~)
let initialBits: UInt8 = 0b00001111
let invertedBits = ~initialBits  //0b11110000
0b11110000


//按位与运算符 (&) (0与任何数都是0)
let firstSixBites: UInt8 = 0b11111100
let lastSixBites: UInt8  = 0b00111111
                           0b00111100
let middleFourBits = firstSixBites & lastSixBites


//按位或运算符(|) (有1为1)
let someBits: UInt8 = 0b10110010
let moreBits: UInt8 = 0b01011110
                      0b11111110
let combinedbits = someBits | moreBits

//按位异或运算符 (^) (相同为0不同为1)
let firstBits: UInt8 = 0b00010100
let otherBits: UInt8 = 0b00000101
                       0b00010001
let outputBits = firstBits ^ otherBits



//按位左移/右移运算符 (<<  >>) (超出移动范围会被丢弃 用0来填充产生的空白)
let shiftBits: UInt8 = 4
                            0b00000100
shiftBits << 1
                            0b00001000
shiftBits << 2
                            0b00010000
shiftBits << 5
                            0b10000000
shiftBits << 6
                            0b00000000
shiftBits >> 2
                            0b00000001

//HEX转RGB
let pink: UInt32 = 0xCC6699
let red = (pink & 0xFF0000) >> 16
let green = (pink & 0x00FF00) >> 8
let blue = (pink & 0x0000FF)



//溢出运算符 (&+ &- &*)

var unsignedOverflow = UInt8.max

unsignedOverflow = unsignedOverflow &+ 1

unsignedOverflow = UInt8.min

unsignedOverflow = unsignedOverflow &- 1


//运算符函数 (运算符的重载)
struct Vector2D {
    var x = 0.0, y = 0.0
    
}


func +(left: Vector2D, right: Vector2D) -> Vector2D {
    return Vector2D(x: left.x + right.x, y: left.y + right.y)
}


let v1 = Vector2D(x: 3, y: 3)
let v2 = Vector2D(x: 4, y: 3)

let combinedV = v1 + v2
combinedV.x
combinedV.y


//前缀和后缀运算符(prefix, postfix)

prefix func - (vector: Vector2D) -> Vector2D {
    return Vector2D(x: -vector.x, y: -vector.y)
}

var positive = Vector2D(x: 3, y: 3)
let negative = -positive
negative.x
negative.y


 //复合赋值运算符

func +=(inout left:Vector2D, right: Vector2D) -> Void {
    left = left + right
}

positive += v1
positive.x
positive.y


prefix func ++ (inout vector:Vector2D) -> Vector2D {
    vector += Vector2D(x: 1, y: 1)
    return vector
}


++positive
positive.x
positive.y


//等价操作符

func ==(left: Vector2D, right: Vector2D) -> Bool {
    return (left.x == right.x) && (left.y == left.y)
}


func !=(left: Vector2D, right: Vector2D) -> Bool {
    return !(left == right)
}


//自定义运算符

//要使用operator关键字声明 同时还要指定prefix infix postfix

prefix operator +++ {}

prefix func +++ (inout vector: Vector2D) -> Vector2D {
    vector += vector
    return vector
}

+++positive
positive.x
positive.y

//自定义中缀运算符的优先级和结合性

infix operator +- {associativity left precedence 140}   //左结合优先级140 结合性默认none 优先级默认100
func +- (left: Vector2D, right: Vector2D) -> Vector2D {
    return Vector2D(x: left.x + right.x, y: left.y - right.y)
    
}

let firstVector = Vector2D(x: 1.0, y: 2.0)
let secondVector = Vector2D(x: 3.0, y: 4.0)
let plusMinusVector = firstVector +- secondVector
plusMinusVector.x
plusMinusVector.y







