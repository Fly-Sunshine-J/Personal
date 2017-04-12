//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

//协议的语法

protocol FirstProtocol {
    //协议的内容
}

protocol AnotherProtocol {
    //协议的内容
}

//遵守协议
struct SomeStructure: FirstProtocol, AnotherProtocol {
    //结构体内容
}

class SomeSuperClass {
    
}

//如果类在遵循协议的同时拥有父类 父类应该写在协议之前
class SomeClass: SomeSuperClass, FirstProtocol, AnotherProtocol {
    //类的内容
}


//协议的属性 (必须指定是set get 还是 get)

protocol SomeProtocol {
    var mustBeSettable: Int { get set }
    var doesNotNeedToBeSettable: Int { get }
    
    //类型属性
    static var sometypeProperty: Int {get set}
}


protocol FullyNamed {
    var fullyName: String { get }
    
}

struct Person: FullyNamed {
    var fullyName: String
}


let john = Person(fullyName: "John Appleseed")


class Starship: FullyNamed {
    var prefix: String?
    var name: String
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    
    var fullyName: String {
        return (prefix != nil ? prefix! + " " : " ") + name
    }
    
    
}

var ncc1701 = Starship(name: "Enterprise", prefix: "USS")
ncc1701.fullyName


//协议的方法

protocol methodTypeProtocol {
    static func someTypeMethod()
}


protocol RandomNumberGenerator {
    func random() -> Double
}


class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    
    func random() -> Double {
        lastRandom = ((lastRandom * a + c) % m)
        return lastRandom / m
    }
    
}

let generator = LinearCongruentialGenerator()
print("Here's a random number: \(generator.random())")
print("Here's a random number: \(generator.random())")


//协议中动态方法的实现

/***********************************************************************************
*类实现协议中的mutating的方法时 不用写mutating关键字  但是结构体和枚举实现协议中mutating方法时 必须写mutating关键字
*
************************************************************************************/

protocol Toggable {
    mutating func toggle()
}

enum OnOffSwitch: Toggable {
    case off, on
    
    mutating func toggle() {
        switch self {
        case .off:
            self = .on
        case .on:
            self = .off
        }
    }
}

var lightSwitch = OnOffSwitch.off
lightSwitch.toggle()


//协议中构造器的实现 (required 关键字)
protocol InitProtocol {
    init(someParameter: Int)
}

class SuperClass {
    init(someParameter: Int) {
        
    }
}


// 如果重写了父类的方法还要加上override关键字
class someClass: SuperClass, InitProtocol {
    required override init(someParameter: Int) {
        super.init(someParameter: someParameter)
    }
}



//协议类型 即协议是一种类型

class Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    
    init(sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}

var d6 = Dice(sides: 6, generator: LinearCongruentialGenerator())

for _ in 1...5 {
    print("Random dice roll is \(d6.roll())")
}


//代理模式

protocol DiceGame {
    var dice: Dice { get }
    func play() -> Void
}

protocol DiceGameDelegate {
    func gameDidStart(game: DiceGame)
    func game(game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int)
    func gameDidEnd(game: DiceGame)
}


class SnakesAndLadders: DiceGame {
    let finalSquare = 25
    let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
    var square = 0
    var board: [Int]
    
    init() {
        board = Array(count: finalSquare + 1, repeatedValue: 0)
        board[03] = +08; board[06] = +11; board[09] = +09; board[10] = +02
        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    }
    
    var delegate: DiceGameDelegate?
    
    func play() {
        square = 0
        delegate?.gameDidStart(self)
        gameLoop: while square != finalSquare {
            let diceRoll = dice.roll()
            delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
            switch square + diceRoll {
            case finalSquare:
                break gameLoop
            case let newSquare where newSquare > finalSquare:
                continue gameLoop
            default:
                square += diceRoll
                square += board[square]
            }
        }
        
        delegate?.gameDidEnd(self)
    }
    
}


class DiceGameTacker: DiceGameDelegate {
    var numberOfTurns = 0
    func gameDidStart(game: DiceGame) {
        numberOfTurns = 0
        
        if game is SnakesAndLadders {
            print("Start a new game of snakes and Ladders")
        }
        print("The game is using a \(game.dice.sides) -sides dice")
    }
    
    func game(game: DiceGame, didStartNewTurnWithDiceRoll diceRoll: Int) {
        numberOfTurns += 1
        print("Roll a \(diceRoll)")
    }
    
    func gameDidEnd(game: DiceGame) {
        print("The game lasted for \(numberOfTurns) turns")
    }
}

let tracker = DiceGameTacker()
let game = SnakesAndLadders()
game.delegate = tracker
game.play()





//在扩展中添加协议成员

protocol TextReoresentable {
    func asText() -> String
}

extension Dice: TextReoresentable {
    func asText() -> String {
        return "A \(sides) -sides dice"
    }
}


let d12 = Dice(sides: 12, generator: LinearCongruentialGenerator())
d12.asText()

extension SnakesAndLadders: TextReoresentable {
    func asText() -> String {
        return "A game of Snakes and Ladders with \(finalSquare) squares"
    }
}
game.asText()



//通过扩展协议补充协议声明  (前提是类型中已经实现了协议中的要求)

struct Hamster {
    var name: String
    func asText() -> String {
        return "A hamster named \(name)"
    }
    
}

extension Hamster: TextReoresentable {}
//现在Hamster的实例可以作为TextRepresentable使用
let simonTheHamster = Hamster(name: "Simon")
//即使满足了协议中的所有要求 类型也不会自动转变  必须要做出显示的协议声明
let somethingTextRepresentable: TextReoresentable = simonTheHamster
somethingTextRepresentable.asText()


//集合中的协议类型
let things: [TextReoresentable] = [game, d12, simonTheHamster]
for thing in things {
    print(thing.asText())
}


//协议的继承

protocol InheritingProtocol: SomeProtocol, AnotherProtocol {
    
}


protocol PrettyTextRepresentable: TextReoresentable {
    var prettyTextualDescription: String { get }
    
}

extension SnakesAndLadders: PrettyTextRepresentable {
    var prettyTextualDescription: String {
        var output = asText() + ":\n"
        for index in 1 ... finalSquare {
            switch board[index] {
            case let ladder where ladder > 0:
                output += "▲ "
            case let snake where snake < 0:
                output += "▼ "
            default:
                output += "○ "
            }
        }
        return output
    }
    
}

print(game.prettyTextualDescription)


//类的专属协议 通过添加class关键字限制该协议只能用在类中
protocol SomeClassOnlyProtocol: class, SomeProtocol {
    
}


//协议合成 <>

protocol Named {
    var name: String { get }
    
}

protocol Aged {
    var age: Int { get }
    
}

struct Person1: Named, Aged {
    var name: String
    var age: Int
    
    
}

func wishHappyBirthday(celebrator: protocol<Named, Aged>) -> Void {
    print("Happy birthday \(celebrator.name) - you're \(celebrator.age)!")
}

let birthdayPerson = Person1(name: "John", age: 20)
wishHappyBirthday(birthdayPerson)



//检验协议的一致性
//is 检查实例是否遵循某一个协议
//as? 返回一个可选值, 当遵循协议时, 返回改协议类型 否则返回nil
//as 用以强制向下转型 如果强转失败会引起运行时错误

protocol HasArea {
    var area: Double { get }
    
}

class Circle: HasArea {
    let pi = 3.1415936
    var radius: Double
    var area: Double {
        return pi * radius * radius
    }
    init (radius: Double) {
        self.radius = radius
    }
}

class Country: HasArea {
    var area: Double
    init(area: Double) {
        self.area = area
    }
}

class Animal {
    var legs: Int
    init(legs: Int) {
        self.legs = legs
    }
    
}

let objects: [AnyObject] = [Circle(radius: 2), Country(area: 223453), Animal(legs: 4)]

for object in objects {
    if let objectWithArea = object as? HasArea {
        print("Area is \(objectWithArea.area)")
    }else {
        print("Something that doesn't have an area")
    }
}



//可选协议的规定(optional)
//可选协议只能在含有@objc前缀的协议中生效 而且@objc协议只能被类遵循 @objc的表示将协议暴露给OC代码

@objc protocol CounterDataSource {
    @objc optional func increment(forCount count: Int) -> Int
    @objc optional var fixedIncrement: Int { get }
}


class Counter {
    var count = 0
    var dataSource: CounterDataSource?
    func increment() -> Void {
        if  let amount = dataSource?.increment?(forCount: count) {
            count += amount
        }else if let amount = dataSource?.fixedIncrement {
            count += amount
        }
    }
    
}


class ThreeSource: NSObject, CounterDataSource {
    let fixedIncrement: Int = 3
    
}


var counter = Counter()
counter.dataSource = ThreeSource()
for _ in 1 ... 4 {
    counter.increment()
    print(counter.count)
}


@objc class TowardsZeroSource: NSObject, CounterDataSource {
    func increment(forCount count: Int) -> Int {
        if count == 0 {
            return 0
        }else if count > 0 {
            return -1
        }else {
            return 1
        }
    }
}


counter.count = -4
counter.dataSource = TowardsZeroSource()
for _ in 1...5 {
    counter.increment()
    print(counter.count)
}



//协议扩展
extension RandomNumberGenerator {
    func randomBool() -> Bool {
        return random() > 0.5
    }
}


let generator1 = LinearCongruentialGenerator()
generator1.random()
generator1.randomBool()
generator1.lastRandom


//提供默认的实现 (可以通过扩展协议规定属性和方法提供默认的实现)
extension PrettyTextRepresentable {
    func asPrettyText() -> String {
        return asText()
    }
}


//为协议扩展添加限制条件(where)
extension CollectionType where Generator.Element: TextReoresentable {
    
    
    
}



