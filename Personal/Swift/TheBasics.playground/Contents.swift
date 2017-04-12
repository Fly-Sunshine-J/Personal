//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

////////////////////////////////////     多个变量一行的写法       /////////////////
var red, green, blue: Double

var friendlyWelcome = "Hello"
print(friendlyWelcome)
print("\(friendlyWelcome)")

let minUInt8 = UInt8.min
let maxUInt8 = UInt8.max

//二进制
let binaryInteger = 0b10001
//八进制
let octalInteger = 0o21
//十六进制
let hexadecimalInteger = 0x11
//科学计数法
let 科学计数法 = 1.25e2
//
let 科学计数法2 = 0xFp2


/////////////////////////////////////   不同类型运算,要做类型转化   ////////////////////
let towThousand: UInt16 = 2_000
let one:UInt8 = 1
let towThousandAndOne = towThousand + UInt16(one)


let three = 3
let pointOenFourOneFiveNine = 0.14159
let pi = Double(three) + pointOenFourOneFiveNine


////////////////////////////////////    类型别名                   ///////////////////////
typealias AudioSample = UInt16  //以后可以使用AudioSample代替UInt16

var maxAmplitudeFound = AudioSample.min


/////////////////////////////////////           元组                 ////////////////////
let http404Error = (404, "Not Found")   //l类型为(Int, String)的元组

//使用元组的内容分解成单独的常量或者变量
let (statusCode, statusMessage) = http404Error
print("The status code is \(statusCode), The status message is \(statusMessage)")

//分解的时候,如果只需要部分元组元素,可以使用_(下划线)代替
let(justStatusCode, _) = http404Error
print("The status code is \(justStatusCode)")

//不分解也可以通过元组的下标来访问元组中的元素,下标从0开始
print("The status code is \(http404Error.0), The status message is \(http404Error.1)")

//可以在定义元组的时候给元素命名
let http200Error = (statusCode: 200, description: "OK")

//获取元组元素,可以直接通过元素的命名来获取单个元素
print("The status code is \(http200Error.statusCode), The status message is \(http200Error.description)")


/////////////////////////////////////           可选类型                 ////////////////////
//swift中的可选状态都可以被设置为nil  不只是对象
let possibleNumber: String = "123"
let convertednumber = Int(possibleNumber)

//可以给变量赋值nil来表示没值
var serverResponseCode : Int? = 404
//如果想要某一个变量没值, 那么这个变量要设置为可选类型
serverResponseCode = nil

//如果可选变量声明的时候没有给值, 默认为nil
var surveyAnswer: String?


//if语句判断和强制解析
if convertednumber != nil {
    //使用!(感叹号)进行强制解析  前提是你知道这个可选类型有值
    print("\(convertednumber)")
}

//使用!(感叹号)进行强制解析  前提是你知道这个可选类型有值
print("\(convertednumber!)")

//可选绑定
if let actualNumber = Int(possibleNumber) {
    print("\(possibleNumber) has an integer value of \(actualNumber)")
}else {
    print("\(possibleNumber) could not be converted to an integer")
}

//可选绑定可以一次多个, 需要用,(逗号隔开)
//if let constantName = someOptional, anotherContantName = someOtherOptional {
//    
//    
//}


//隐性解析可选类型
//当可选类型第一次赋值之后就可以确定之后一直是有值得时候, 隐式解析就非常的有用, 隐式解析在swift中主要用于类的构造过程中
//可选解析和隐式解析
let possibleString: String? = "An optional string"
print(possibleString)
let forcedString: String =  possibleString!
print(forcedString)

let assumedString: String! = "An implicitly unwrapped optional string"
print(assumedString)
let implicitString: String = assumedString
print(implicitString)


if assumedString != nil {
    print(assumedString)
}

if let definiteString = assumedString {
    print(definiteString)
}


/////////////////////////////////////           错误处理                 ////////////////////

func canThrowAnError() throws{
    
}

do {
    
    try canThrowAnError()
    
}catch {
    
    
}


//做三明治,在做三明治的过程中,如果没有错误产生会执行eat函数,如果有错误产生, 不会执行eat函数,会判断错误的类型,如果是盘子没有洗,会执行wash函数, 如果是缺少材料引起的错误,会执行buy函数

//func makeASandwich() throws{
//    
//}
//
//do {
//    try makeASandwich()
//    eatASandwich()
//} catch Error.OutOfCleanDishes {
//    washDishes()
//}catch Error.MissingIngredients(let ingredients){
//    buyGroceries(ingredients)
//}



/////////////////////////////////////           断言                 ////////////////////
//断言可能会终止程序
let age = 5
assert(age > 10, "年龄大于10的可以使用该应用")

/**
 *  断言的使用情况:
 当条件可能为假时使用断言,但是最终一定要保证条件为真 这样你的代码才能继续运行
 */



        
