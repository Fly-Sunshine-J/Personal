//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

///////////////////////////////////////////       数组       ////////////////////////////////////////////
//创建一个空数组
var someInt = [Int]()
print("someInt is of type [Int] with \(someInt.count) items")

someInt.append(3)
someInt = []


//创建一个带有默认值的数组
var threeDoubles = [Double](count:3, repeatedValue:0.0)

var fourDoubles = [Double](count:4, repeatedValue:2.0)
var sevenDoubles = threeDoubles + fourDoubles

var shoppinglist :[String] = ["Eggs", "Milk"]
var shoppingList = ["Eggs", "Milk"];

print("The shoppinglist contains \(shoppinglist.count) items")
if shoppinglist.isEmpty {
    print("shoppinglist is empty")
}else {
    print("shoppinglist is not empty")
}

shoppinglist += ["baking powder", "a", "b"]

var firstItem = shoppinglist[0]

shoppinglist[0] = "hot dog"

shoppinglist[1...2] = ["vegetable"]

shoppinglist.insert("Maple Syrup", atIndex: 0)

let mapleSyrup = shoppinglist.removeAtIndex(0)
shoppinglist.removeFirst()
shoppinglist.removeLast()


for item in shoppinglist {
    print(item)
}

for (index, value) in shoppinglist.enumerate() {
    print("Item \(String(index + 1)):\(value)")
}



///////////////////////////////////////////       集合       ////////////////////////////////////////////
//创建一个空的Set
var letters = Set<Character>()

letters.insert("a")
letters = []

var favotiteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]
var favoriteGenres: Set = ["Rock", "Classical", "Hip hop"]

print("I have \(favoriteGenres.count) favorite music genres")

if favoriteGenres.isEmpty {
    print("As far as music goes, I'm not picky")
}else {
    print("I have particular music preference")
}

favoriteGenres.insert("Jazz")

if let removeGenre = favoriteGenres.remove("Rock") {
    print("\(removeGenre) I'm over it")
}else {
    print("I never much cared for that")
}

if favoriteGenres.contains("Funk") {
    print("I get up on the good foot")
}else {
    print("It's too funky in here")
}

for genre in favoriteGenres {
    print(genre)
}

for genre in favoriteGenres.sort() {
    print(genre)
}
print("")

for genre in favoriteGenres.sort({$0 > $1}) {
    print(genre)
}

let oddDigits: Set = [1, 3, 5, 7, 9]
let evenDigits: Set = [0, 2, 4, 6, 8]
let singleDigitPrimeNumber: Set = [2, 3, 5, 7]
///并集
oddDigits.union(evenDigits).sort()
//交集
oddDigits.intersect(singleDigitPrimeNumber).sort()
//并集-交集
oddDigits.exclusiveOr(singleDigitPrimeNumber).sort()
//并集-b
oddDigits.subtract(singleDigitPrimeNumber).sort()

//使用==判断两个集合是否包含全部相同的值
//使用isSubsetOf(_:)判断一个集合中的值是否也在另外一个集合中
//使用isSupersetOf(_:)判断一个集合中包含另一个集合中所有的值
//使用isStrictSubsetOf(_:)或使用isStrictSupersetOf(_:)判断一个集合是否是另外一个集合的子集或是父集合并且和特定集合不相等
//使用isDisjointWith(_:)判断两个集合是否不含有相同的值

let houseAnimals: Set = ["🐶", "🐱"]
let farmAnimals: Set = ["🐮", "🐔", "🐑", "🐶", "🐱"]
let cityAnimals: Set = ["🐦", "🐭"]

houseAnimals.isSubsetOf(farmAnimals)

farmAnimals.isSupersetOf(houseAnimals)

farmAnimals.isDisjointWith(cityAnimals)





///////////////////////////////////////////       集合       ////////////////////////////////////////////
//创建一个字典
var namesOFIntegers = [Int: String]()
namesOFIntegers[16] = "sixteen"
//namesOFIntegers又变成一个key为Int  value为String的空字典
namesOFIntegers = [:]

//var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
var airports = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]

print("The dictionary of airports contains \(airports.count) items")

if airports.isEmpty {
    print("The airports dictionary is empty")
}else {
    
    print("The airports dictionary is not empty")
}

airports["LHR"] = "London"
//取值
if let oldValue = airports.updateValue("Dublin Airport", forKey: "DUB") {
    
    print("The old value for DUB was \(oldValue)")
}


if let airportName = airports["DUB"] {
    print("The name of the airport is \(airportName)")
}else {
    print("That airport is not in the airports dictionary")
}

//通过键对value赋值nil可以移除一个键值对
airports["APL"] = "Apple Internation"
airports["APL"] = nil


if let oldValue = airports.removeValueForKey("DUB") {
    print("The removed airport's name is \(oldValue)")
}else {
    print("The airports dictionary does not contain a value for DUB")
}

/**
 *  字典的遍历
 */

for (ariport, airportName) in airports {
    print("\(ariport) = \(airportName)")
}


for key in airports.keys {
    print("airportKey:\(key)")
}

for value in airports.values {
    print("airportValue:\(value)")
}

for key in airports.keys.sort() {
    print(key)
}
