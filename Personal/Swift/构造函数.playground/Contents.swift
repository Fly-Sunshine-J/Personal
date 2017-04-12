//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


struct Fahrenheit {
    var temperature: Double
    init() {
        temperature = 32.0
    }
    
}

var f = Fahrenheit()
f.temperature

struct Celsius {
    var tempertureInCelsius: Double = 0.0
    init (fomeFahrenheit fahrenheit: Double) {
        tempertureInCelsius = (fahrenheit - 32) / 1.8
    }
    
    init (fromKelvin kelvin: Double) {
        tempertureInCelsius = kelvin - 237.15
    }
}

let boilingPointOfWater = Celsius(fomeFahrenheit: 212)
boilingPointOfWater.tempertureInCelsius
let freezingPointOfWater = Celsius(fromKelvin: 237.15)
freezingPointOfWater.tempertureInCelsius


//参数的内部名称和外部名称
struct Color {
    let red, green, blue: Double
    init(red: Double, green: Double, blue: Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    
    init(white: Double) {
        red = white
        green = white
        blue = white
    }
}

let magenta = Color(red: 1, green: 0, blue: 1)
let halfGray = Color(white: 0.5)

//不带外部名称的构造器参数
struct Celsius2{
    var temperatureInCelsius: Double = 0.0
    init(fromFahrenheit fahrenheit: Double) {
        temperatureInCelsius = (fahrenheit - 32) / 1.8
    }
    
    init(fromKelvin kelvin: Double) {
        temperatureInCelsius = kelvin - 273.15
    }
    
    init(_ celsius: Double) {
        temperatureInCelsius = celsius
    }
    
}

let bodyTemprature = Celsius2(37.0)
bodyTemprature.temperatureInCelsius


//可选属性类型
class SurveyQuestion {
    var text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    
    func ask() -> Void {
        print(text)
    }
    
}

let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
cheeseQuestion.ask()
cheeseQuestion.response = "Yes, I do like cheese"


//构造过程中常量的属性修改  只要在构造函数结束前常量的值能确定, 你可以在构造过程中的任意时间点修改常量属性

class SurveyQuestion1 {
    let text: String
    var response: String?
    init(text: String) {
        self.text = text
    }
    
    func ask() -> Void {
        print(text)
    }
    
}

let beetsQuestion = SurveyQuestion(text: "How about beets?")
beetsQuestion.ask()
beetsQuestion.response = "I also like beets"


//默认构造器
class ShoppingListItem {
    var name: String?
    var quantity = 1
    var purchased = false
}

var item = ShoppingListItem()

//结构体的逐一成员构造器
struct Size {
    var width = 0.0, height = 0.0
}

let twoByTwo = Size(width: 2, height: 2)


//值类型的构造器代理
struct Point {
    var x = 0.0, y = 0.0
    
}

struct Rect {
    var origin = Point()
    var size = Size()
    init() {}
    init (origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
    
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin:Point(x: originX, y: originY), size: size)
        
    }
}

let basecRect = Rect()
let originRect = Rect(center: Point(x: 0, y: 0), size: Size(width: 5, height: 5))
let centerRect = Rect(center: Point(x: 4, y: 4), size: Size(width: 3, height: 3))


//类的继承和构造过程
//便利构造器 (convenience)
//类的构造器代理规则:
/**
 *  1.指定构造器必须调用其他直接父类的指定构造器
    2.便利构造器必须调用同一类中定义的其他构造器
    3.便利构造器必须最终调用一个指定构造器
 */


//构造器的继承和重载
class Vehicle {
    var numberOfWheels = 0
    var description: String {
        return "\(numberOfWheels) wheels"
    }
    
}

let vehicle = Vehicle()
vehicle.numberOfWheels

class Bicycle: Vehicle {
    override init() {
        super.init()
        numberOfWheels = 2
    }
}

let bicycle = Bicycle()
bicycle.numberOfWheels
/////////////////////////////     注意      ///////////////////////
////子类可以初始化时修改继承变量属性不是常量属性

//指定构造器和便利构造器操作
class Food {
    var name: String
    init (name: String) {
        self.name = name
    }
    
    convenience init() {
        self.init(name: "[Unnamed]")
    }
    
}

let namedMeat = Food(name: "Bacon")
namedMeat.name
let mysteryMeat = Food()
mysteryMeat.name


class RecipeIngredient: Food {
    var quantity: Int
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
}


let oneMysteryMeat = RecipeIngredient()
oneMysteryMeat.name
oneMysteryMeat.quantity

let oneBacon = RecipeIngredient(name: "Bacon")
oneBacon.name
oneBacon.quantity

let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)
sixEggs.name
sixEggs.quantity


class ShoppingListItem1: RecipeIngredient {
    var purchased = false
    var description : String {
        var output = "\(quantity) x \(name.lowercaseString)"
        output += purchased ? " ✔" : " ✘"
        return output
        
    }
}


var breakfastList = [ShoppingListItem1(), ShoppingListItem1(name: "Bacon"), ShoppingListItem1(name: "Eggs", quantity: 6)]
breakfastList[0].name = "Orange juice"
breakfastList[0].purchased = true
for item in breakfastList {
    print(item.description)
}


//可失败的构造器
/**
 *  ////////////////////////////////////////    结构体
 */
struct Animal {
    var species: String
    init?(species: String) {
        if species.isEmpty {
            return nil
        }
        self.species = species
    }
    
}

let someCreature = Animal(species: "Giraffe")
if let giraffe = someCreature {
    print(giraffe.species)
}

let anotherCreature = Animal(species: "")
if anotherCreature == nil {
    print("创建失败!!!")
}


/**
 *  ////////////////////////////////////////    枚举
 */

//枚举类型的可失败构造器
enum TemperatureUnit {
    case Kelvin, Celsius, Fahrenheit
    init?(symbol: Character) {
        switch symbol {
        case "k", "K":
            self = .Kelvin
        case "c", "C":
            self = .Celsius
        case "f", "F":
            self = .Fahrenheit
        default:
            return nil
        }
    }
}

let fahrenheitUnit = TemperatureUnit(symbol: "f")
if let fahrenhert = fahrenheitUnit {
    print("构造成功!!!")
}

let unknowUnit = TemperatureUnit(symbol: "x")
if unknowUnit == nil {
    print("构造失败!!!!!")
}


//带初始值的枚举类型的可失败构造器
//带原始值的枚举类型会自带一个可失败构造器init?(rawValue:)
enum TemperatureUnit1: Character {
    case Kelvin = "K", Celsius = "C", Fahrenheit = "F"
}

let farenheitUnit1 = TemperatureUnit1(rawValue: "F")
if let farenheit = farenheitUnit1 {
    print("构造成功!!!!")
}

let unknowUnit1 = TemperatureUnit1(rawValue: "X")
if unknowUnit1 == nil {
    print("构造失败!!!!!!!")
}



/**
 *  ////////////////////////////////////////    类
 */
//类的可失败构造器
class Product {
    let name: String!  //隐式解析可选类型
    init?(name :String) {
        if name.isEmpty {
            return nil
        }
        self.name = name
    }
}

//如果类构造成功  name一定是非nil的
if let bowTie = Product(name: "bow Tie") {
    print(bowTie.name)
}


class CarItem: Product {
    let quantity: Int
    init?(name: String, quantity: Int) {
        if quantity < 1 {
            return nil
        }
        self.quantity = quantity
        super.init(name: name)
    }
}

if let towSocks = CarItem(name: "sock", quantity: 2){
    print("Item: \(towSocks.name), quantity: \(towSocks.quantity)")
}

if let zeroShirts = CarItem(name: "shirt", quantity: 0) {
    print("Item: \(zeroShirts.name), quantity: \(zeroShirts.quantity)")
}else {
    print("创建失败!!!!!")
}


if let oneUnnamed = CarItem(name: "", quantity: 1) {
    print("Item: \(oneUnnamed.name), quantity: \(oneUnnamed.quantity)")
}else {
    print("创建失败!!!!!")
}



//重写一个可失败构造器
class Document {
    var name: String?
    init() {
        
    }
    
    init?(name: String) {
        if name.isEmpty {
            return nil
        }
        self.name = name
    }
}


class AutoMaticallyNamedDocument: Document {
    override init() {
        super.init()
        self.name = "[Untitled]"
    }
//    用一个不可失败的构造方法重写父类的可失败的方法
    override init(name: String) {
         super.init()
        if name.isEmpty {
            self.name = "[Untitled]"
        }else {
            self.name = name
        }
    }
}


//必要构造器  子类必须实现的构造器
class SomeClass {
    required init() {
        
    }
}



//通过闭包或者函数来设置属性的默认值
class anotherClass {
    let someProperty: String = {
//        创建临时变量  返回这个临时变量即可
        var str = "hello"
        return str
    }()
//    ()的作用是告诉swift立即执行此闭包 如果忽略是将闭包本身赋值给属性  不是将返回值赋给属性
//    而且闭包的执行实例的其他部分还没有初始化,也就是说你不能再闭包内访问其他属性,就算有默认值也不能  也不能使用隐式的self属性  或者调用其他的实例方法
}


struct Checkerboard {
    let boardColors: [Bool] = {
        var temp = [Bool]()
        var isBlack = false
        for i in 1...10 {
            for j in 1...10 {
                temp.append(isBlack)
                isBlack = !isBlack
            }
            isBlack = !isBlack
        }
        return temp
    }()
    
    func squareIsBlackAtRow(row: Int, column: Int) -> Bool {
        return boardColors[row * 10 + column]
    }
    
}

let board = Checkerboard()
print(board.squareIsBlackAtRow(0, column: 1))
print(board.squareIsBlackAtRow(6, column: 6))

