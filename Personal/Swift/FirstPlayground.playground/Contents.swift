//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


let 显示浮点常量 : Float64 = 4.0

let label = "The width is "
let width = 94
let widthLable = label + String(width)

let apples = 3
let oranges = 5
let appleSummary = "I have \(apples) apples"
let orangeSummary = "I have \(oranges) oranges"

let x = 0.35
let labelx = "\(x)"
print("hello \(labelx) 哈哈哈")

var shoppingList = ["catfish", "water", "tulips", "blue paint"]
let water = shoppingList[1]
shoppingList[1] = "bottle of water"
print("\(shoppingList)")

var occupations = ["Malcolm" : "Captain",
                   "Kaylee" : "Mechainc"]

occupations["Jayne"] = "Public Relations"
print("\(occupations)")

let emptyArray = [String]()
var emptyDictionary = [String : Float]()
emptyDictionary["aa"] = 4.2


let individualScores = [75, 43, 103, 87, 12]
var teamScores = 0
for score in individualScores {
    if score > 50 {
        teamScores += 3
    }else {
        teamScores += 1
    }
}

print("teamScores:\(teamScores)")

var optionalString:String? = "Hello"
print(optionalString == nil)

var optionalName:String? = nil
//var optionalName:String? = "John"
if let name = optionalName {
    print("Hello, \(name)")
}else {
    print("Hello");
}


//let nickName : String? = "Tom"
let nickName : String? = nil
let fullName : String = "John"
let informalGreeting = "Hi, \(nickName ?? fullName)"


let vegetable = "red pepper"
switch vegetable {
    
    case "celery":
        print("Add some raisins adn make ants on a log")
    case "cucumber", "watercress":
        print("That would make a good tea sandwich")
    case let x where x.hasSuffix("pepper") :
        print("Is it a spicy \(x)?")
    default:
        print("Everything tastes good in soup")
}


let interestingNumbers = ["Prime":[2, 3, 5, 7, 11, 13], "Fibonacci":[1, 1, 2, 3, 5, 8], "Square":[1, 4, 9, 16, 25]]

var largest = 0
var kindOfLargest:String = ""
var smallest = 100
var kindOfSmallest:String = ""

for (kind, numbers) in interestingNumbers {
    
    for number in numbers {
        if number > largest {
            largest = number
            kindOfLargest = kind
        }else if number < smallest {
            smallest = number
            kindOfSmallest = kind
        }
    }
}
print("largest:\(largest) \nKidnOfLargest:\(kindOfLargest)")
print("smallest:\(smallest) \nkindOfSmallest:\(kindOfSmallest)")


var n = 2
while n < 100 {
    n = n * 2
}
print("n = \(n)")

var m = 2
repeat {
    m = m * 2
}while (m < 100)
print("m = \(m)")

// ..<不包含边界  ...包含边界
var firstForLoop = 0
for i in 0..<4 {
    firstForLoop += i
}
print("FirstForLoop = \(firstForLoop)")


/**
 *  ////////////////////////            函数和闭包            ////////////
 */

func greet(name: String, day:String) ->String {
    
    return "Hello \(name), today is \(day)"
}

greet("Tom", day: "Tuesday")

func eat(name: String, luanch:String) ->String {
    
    return "Hello \(name), 中午吃了\(luanch)"
}

eat("Jane", luanch: "米饭")


//使用元组返回多个参数
func caculateStatistics(scores:[Int]) ->(min:Int, max:Int, sum:Int) {
    
    var min = scores[0]
    var max = scores[0]
    var sum = 0
    for score in scores {
        if score < min {
            min = score
        }else if score > max{
            max = score
        }
        sum += score
    }
    
    return (min, max, sum)
    
}

var statistics = caculateStatistics([3, 34, 234, 23, 43])

print("min : \(statistics.min) max : \(statistics.max) sum : \(statistics.sum)")


func caculateAverage(scores:[Int]) -> Int {
    var sum = 0
    var i = 0
    
    for score in  scores{
        sum += score
        i += 1
    }
    return sum / i
}

var aveager = caculateAverage([12, 32, 32, 34, 23])


//函数可以嵌套  感觉像block
func returnFifteen()->Int {
    var y = 10
    func add() {
        y += 5
    }
    add()
    return y
}

returnFifteen()




//函数作为返回值
func makeIncrementer() -> (Int -> Int) {
    
    func incrementer(number:Int) -> Int {
        return 1 + number
    }
    return incrementer
}


var incerment = makeIncrementer()
incerment(7)


//函数作为参数传入
func hasAnyMatches(list:[Int], condition:Int->Bool)->Bool {
    
    for item in list {
        if condition(item) {
            return true
        }
    }
    return false
}


func condition(number:Int) -> Bool {
    return number > 12
}

var numbers = [1, 2, 3, 4, 12]
hasAnyMatches(numbers, condition: condition)


/**
 *  ////////////////////////            函数和闭包            ////////////
 */
numbers.map({(number:Int) -> Int in
    return 3 * number})

numbers.map({(number:Int) -> Int in
    if number % 2 != 1 {
        return number
    }else {
        return 0
    }
})

let mappedNumbers = numbers.map({number in 3 * number})
print("\(mappedNumbers)")

let sortedNumbers = numbers.sort{$0 > $1}
print("\(sortedNumbers)")



/**
 *  ////////////////////////            类和对象            ////////////
 */
class Shape: NSObject {
    var numberOfSides = 0
    func simpleDescription() -> String {
        return "A shape with \(numberOfSides) sides"
    }
    
    let width = 10
    func area(wdith:Float) -> Float {
        return wdith * wdith
    }
    
}

var shape = Shape()
shape.numberOfSides = 4;
var shapeDescription = shape.simpleDescription()
var area = shape.area(10)



class NameShape:NSObject {
    var numberOfSides = 0
    var name:String
    init(name: String) {
        self.name = name
    }
    func simpleDescritption() -> String {
        return "A shape with \(numberOfSides) sides"
    }
}


class Square: NameShape {
    var sideLength : Double
    init(sideLength:Double, name:String){
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 4
    }
    
    func area() -> Double {
        return sideLength * sideLength
    }
    
    override func simpleDescritption() -> String {
        return "A square with sides of length \(sideLength)"
    }
    
}

let square = Square(sideLength: 10.0, name: "Square")
square.area()
square.simpleDescritption()
square.sideLength


class Cicle: NameShape {
    var radius : Double
    init(radius:Double, name:String){
        self.radius = radius
        super.init(name: name)
    }
    
    func area() -> Double {
        return 3.141592654 * radius * radius
    }
    
    override func simpleDescritption() -> String {
        return "A Circle with radius \(radius)"
    }
}


let circle = Cicle(radius: 10, name: "Circel")
circle.area()
circle.simpleDescritption()



class EquilateralTriangle: NameShape {
    var sideLength : Double = 0
    
    init(sideLength:Double, name:String){
        self.sideLength = sideLength
        super.init(name: name)
        numberOfSides = 3
    }
    
    var perimeter : Double {
        
        get {
            return 3 * sideLength
        }
        
        set {
            sideLength = newValue / 3.0
        }
    }
    
    
    override func simpleDescritption() -> String {
        return "An equilateral triangle with side of length \(sideLength)"
    }
    
}


var triangle = EquilateralTriangle(sideLength: 10, name: "Triangle")
print(triangle.perimeter)
triangle.simpleDescritption()
triangle.perimeter = 9.9
print(triangle.sideLength)




//确保三角形的边长和正方形的变成相同
class TriangleAndSquare {
    var triangle:EquilateralTriangle {
        willSet {
            square.sideLength = newValue.sideLength
        }
    }
    
    var square : Square {
        willSet {
            
            triangle.sideLength = newValue.sideLength
        }
    }
    
    init(Size:Double, name:String){
        
        square = Square(sideLength: Size, name: name)
        triangle = EquilateralTriangle(sideLength: Size, name: name)
    }
    
}

var triangleAndSquare = TriangleAndSquare(Size: 10, name: "test Shape")
print(triangleAndSquare.square.sideLength)
print(triangleAndSquare.triangle.sideLength)
triangleAndSquare.square = Square(sideLength: 50, name: "lager Square")
print(triangleAndSquare.triangle.sideLength)

let optionalSquare:Square? = Square(sideLength: 2.5, name: "optional square")
let sidelegth = optionalSquare!.sideLength




/**
 *  ////////////////////////            枚举            ////////////
 */
enum Rank:Int {
    
    case Ace = 1
    case Tow, Three, Four, Five, Six, Seven, Eight, Nine, Ten
    case Jack, Queue, King
    
    func simpleDescription() -> String {
        switch self {
        case .Ace:
            return "ace"
        case .Jack:
            return "jack"
        case .Queue:
            return "queue"
        case .King:
            return "king"
        default:
            return String(self.rawValue)
        }
    }
    
    
    func compare(b:Int) -> String {
        
        if self.rawValue > b {
            return "\(self) > \(Rank(rawValue:b))"
        }else {
            return "\(self) < \(Rank(rawValue:b)))"
        }
        
    }
    
}


let ace = Rank.Ace
let aceRawValue = ace.rawValue

Rank.King.compare(3)


enum Suit:Int {
    case Spades, Hearts, Diamonds, Clubs
    func simpleDescription() -> String {
        switch self {
        case .Spades:
            return "spades"
        case .Hearts:
            return "hearts"
        case .Diamonds:
            return "diamonds"
        case .Clubs:
            return "clubs"
        }
    }
    
    func color() -> String {
        switch self {
        case .Spades, .Clubs:
            return "black"
        case .Hearts, .Diamonds:
            return "red"
        }
    }
}


let hearts = Suit.Hearts
let heartsDescription = hearts.simpleDescription()
hearts.color()



/**
 *  ////////////////////////            结构体            ////////////
 */

struct Card {
    var rank:Rank
    var suit:Suit
    func simpleDescription() -> String {
        return "The\(rank.simpleDescription()) of \(suit.simpleDescription())"
    }
    
    func AllCard() -> [String] {
        var cards = [String]()
        for i in 1...13 {
            let rank = Rank(rawValue:i)
            for k in 0..<4 {
                let suit = Suit(rawValue: k)
                
                let card = rank!.simpleDescription() + " " + suit!.simpleDescription()
                
                cards.append(card)
            }
        }
        return cards
    }
    
}

let threeOfSpades = Card(rank: .Three, suit: .Spades)
threeOfSpades.simpleDescription()

var allCards = threeOfSpades.AllCard()
print("\(allCards)")

enum ServerResponse {
    case Result(String, String)
    case Error(String)
    case Cloudy(String)
}

var success = ServerResponse.Result("6:00", "8:00")
let failure = ServerResponse.Error("Out of cheese")
let cloudy = ServerResponse.Cloudy("today is cloudy")


switch success {
    case let .Result(sunrise, sunset):
        let serverSponse = "Sunrise is at \(sunrise) and sunset is at \(sunset)"
    case let .Error(error):
        let serverSponse = "Failure...\(error)"
    case let .Cloudy(cloudy):
        let serverSponse = "Cloudy...\(cloudy)"
    
    
}


/**
 *  ////////////////////////            协议和扩展            ////////////
 */


//使用protocol声明一个协议
protocol ExampleProtocol {
    var simpleDescription : String{ get }
    mutating func adjust()
}

/**
 *  ////////////////////////            类遵守协议            ////////////
 */
class SimpleClass:ExampleProtocol {
    
    var simpleDescription: String = "A very simple class"
    var anotherProperty : Int = 10086
    func adjust() {
        simpleDescription += " Now 100% adjusted"
    }
}


var a = SimpleClass()
a.adjust()
let simpleD = a.simpleDescription

/**
 *  ////////////////////////            结构体遵守协议            ////////////
 */
struct simpleStruct:ExampleProtocol {
    var simpleDescription: String
    var rank:Rank
    //注意声明结构体的时候需要使用mutating关键字标记一个会修改结构体的方法  而simpleClass的声明不需要标记任何的方法,因为累中的方法通常是可以修改属性的
    mutating func adjust() {
        simpleDescription += " (adjusted)"
    }

}

var b = simpleStruct(simpleDescription: "A simple Struct", rank: ace)
b.adjust()
let bsimpleD = b.simpleDescription


protocol Togglable {
    mutating func toggle()
}


/**
 *  ////////////////////////            枚举遵守结构体            ////////////
 */
//枚举 遵守的协议里面不能有其他的属性 只能有方法(自己的理解)
enum OnOffSwitch: Togglable {
    
    case Off, On
    mutating func toggle() {
        switch self {
        case Off:
            self = On
        case .On:
            self = Off
            
        }
    }
}

var c = OnOffSwitch.On
c.toggle()


/**
 *  ////////////////////////            扩展extension          ////////////
 */
//extension扩展  遵守协议
extension Int:ExampleProtocol {
    var simpleDescription : String {
        
        return "The number \(self)"
    }
    
    mutating func adjust() {
        self += 10;
    }
    
}

var inta = 10
inta.adjust()
print(10.simpleDescription)


extension Double {
    
    func absoluteValue() ->Int {
        return Int(self)
    }
}

var doublea = 10.9
doublea.absoluteValue()

//
let protocolValue:ExampleProtocol = a;
print(protocolValue.simpleDescription)
//不能调用类在它实现的协议之外实现的方法或者属性
//print(protocolValue.anotherProperty)



/**
 *  ////////////////////////            泛型            ////////////
 */
//在尖括号里写一个名字来创建一个泛型函数或者类型
func repeatItem<Item>(item:Item, numberOfTimes:Int)->[Item] {
    
    var result = [Item]()
    for _ in 0..<numberOfTimes {
        result.append(item)
    }
    return result
}

repeatItem(4, numberOfTimes: 4)
repeatItem(4.5, numberOfTimes: 4)
repeatItem("knock", numberOfTimes: 4)


enum OptionalValue<Wrapped> {
    case None
    case Some(Wrapped)
}

var possibleInteger : OptionalValue<Int> = .None
possibleInteger = .Some(100)



func swapTowValue<T>(inout a:T, inout _ b:T) {
    let temp = a
    a = b;
    b = temp
}

var someInt = 10
var anotherInt = 20
swapTowValue(&someInt, &anotherInt)
print("someInt:\(someInt), anotherInt:\(anotherInt)")

var someString = "Hello"
var anotherString = "你好"
swapTowValue(&someString, &anotherString)
print("someString:\(someString), anotherString:\(anotherString)")


/**
 *  ////////////////////////            结构体和泛型            ////////////
 */
struct Stack<T> {
    var items = [T]()
    mutating func push(item:T){
        items.append(item)
    }
    
    mutating func pop() ->T {
       return items.removeLast()
    }
    
}

var stringStack = Stack<String>()
stringStack.push("a")
stringStack.push("b")
stringStack.push("c")
stringStack.push("d")
print("\(stringStack)")
stringStack.pop()
print("\(stringStack)")


extension Stack {
    var topItem :T? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
    
}

if let topItem = stringStack.topItem {
    print("topItem is \(topItem)")
}


func findStringIndex(array:[String], _ valueToFind:String) -> Int? {
    
    for (index, value) in array.enumerate() {
        
        if value == valueToFind {
            return index
        }
        
    }
    return nil
}

let strings = ["cat", "dog", "cow", "parakeet", "terrapin"]
if let index = findStringIndex(strings, "cow") {
    print("\(index)")
}


func findTIndex<T:Equatable>(array:[T], _ valueToFind:T) -> Int? {
    for (index, value) in array.enumerate() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

let doubleIndex = findTIndex([2.3, 3.2, 4.3, 4.1], 3.2)

let stringIndex = findTIndex(strings, "cow")

protocol Container {
    associatedtype ItemType
    mutating func append(item:ItemType)
    var count : Int { get }
    subscript(i:Int)->ItemType {get}
}



struct IntStack:Container {
    //最初的
    var items = [Int]()
    mutating func push(item:Int){
        items.append(item)
    }
    
    mutating func pop()->Int {
        return items.removeLast()
    }
    
    
    //遵循Container协议之后
    typealias ItemType = Int
    
    mutating func append(item: ItemType) {
        self.push(item)
    }
    
    var count: ItemType {
        
        return items.count
    }
    
    subscript(i :Int)->ItemType {
        return items[i]
    }
}


var Inta = IntStack(items: [3, 4, 6, 1, 21]);
Inta.count
Inta.append(4)
Inta.count
Inta[2]

struct StackGenerics<T>: Container {
    var items = [T]()
    
    mutating func push(item:T) {
        items.append(item)
    }
    
    mutating func pop() -> T{
        return items.removeLast()
        
    }
    
    
    //遵守协议之后
    typealias ItemType = T
    
    mutating func append(item: ItemType) {
        self.push(item)
    }
    
    var count: Int {
        return items.count
    }
    
    subscript(i: Int) ->ItemType {
        return items[i]
    }
}


var stringA = StackGenerics<String>()

stringA.append("a")
stringA.append("b")
stringA.push("c")
stringA.push("d")
print("\(stringA.items)")
stringA.count
stringA.pop()
stringA[2]

extension Array:Container {}
var doubleA = [2.3, 23.2, 34.1, 10.2]
doubleA.append(1.2)
doubleA.count
doubleA[2]

func allItemsMatch<C1:Container, C2:Container where C1.ItemType == C2.ItemType, C1.ItemType:Equatable>(someContainer:C1, anotherContainer:C2) -> Bool {
    
    if someContainer.count != anotherContainer.count {
        return false
    }
    
    for i in 0 ..< someContainer.count {
        if someContainer[i] != anotherContainer[i] {
            return false
        }
    }
    
    return true
}


var stringB = ["a", "b", "c"]
if allItemsMatch(stringA, anotherContainer: stringB) {
    print("All items match")
}else {
    print("Not All items macth")
}



class SomeBaseClass {
    class func printClassName() {
        print("SomeBaseClass")
    }
}

class SomeSubClass: SomeBaseClass {
    override class func printClassName() {
        print("SomeSubClass")
    }
}


let someInstance: SomeBaseClass = SomeSubClass()
someInstance.dynamicType.printClassName()
someInstance.self
someInstance.dynamicType
someInstance.dynamicType === someInstance.self

final class AnotherSubClass: SomeBaseClass {
    
    let string: String
    init(string: String) {
        self.string = string
    }
    
    
    override class func printClassName() {
        print("AnotherSubClass")
        
    }
    
}


let metatype: AnotherSubClass.Type = AnotherSubClass.self
let anotherInstance = metatype.init(string: "some string")

//字符表达
func primaryExpression() -> Void {
    print("\(#file, #line, #column, #function)")
}

primaryExpression()


class SomeClass: NSObject {
    let property: String
    @objc(doSomethingWithInt:)
    
    func doSomething(x: Int)  {
        
    }
    
    init(property: String) {
        self.property = property
    }
    
}


let selectorForMethod = #selector(SomeClass.doSomething(_:))
//let selectorForPropertyGetter = #selector(getter: SomeClass.property)


@objc class SomeClass1: NSObject {
    var someProperty: Int
    init(someProperty: Int) {
        self.someProperty = someProperty
    }
    
//    func keyPathTest() -> String {
//        return #keyPath(someProperty)
//    }
    
}

let some = SomeClass1(someProperty: 12)
//let keyPath = #ketPath(SomeClass1.someProperty)

SomeClass1.self
some.self
some.dynamicType

//SomeClass1.dynamicType












