//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


//初始化字符串
var someSting = "someString"
//空串的两种写法
var emptyString = ""
var anotherEmptyString = String()

//字符串是否为空的判断
if emptyString.isEmpty {
    print("Nothing to see here")
}

//字符串的可变性
var variableString = "Horse"
variableString += " and carriage"

let constantString = "Highlander"
//constantString += "a"

//字符的使用
for char in "Dog!  ".characters {
    print(char)
}


let exclamationMark: Character = "!"

let catCharacters:[Character] = ["C", "a", "t", "!", " "]
let catString = String(catCharacters)


//连接字符串和字符
let string1 = "hello"
let string2 = " 你好"
var welcome = string1 + string2

var instruction = "look over"
instruction += string2

welcome.append(exclamationMark)

//字符串插值
let mutiplier = 3
let message = "\(mutiplier) timers 2.5 is \(Double(mutiplier) * 2.5)"


let dollarSign = "\u{24}"
let blackHeart = "\u{2665}"
let sparklingHert = "\u{1F496}"
let chick = "\u{1F425}"

let combinedEAcute: Character = "\u{65}\u{300}"


//计算字符数量
print("string1 的字符数量是:\(string1.characters.count)")


//访问和修改字符串
let greeting = "Guten Tag"
greeting[greeting.startIndex]
greeting[greeting.startIndex.successor()]
greeting[greeting.endIndex.predecessor()]
let index = greeting.endIndex.advancedBy(-3)
greeting[index]

for index in greeting.characters.indices {
    print("\(greeting[index])", terminator:"")
}


//插入和删除
var wel = "hello"
//插入字符
wel.insert("!", atIndex: wel.endIndex)
//插入字符串
wel.insertContentsOf(" there".characters, at: wel.endIndex.predecessor())


wel.removeAtIndex(wel.endIndex.predecessor())

let range = wel.endIndex.advancedBy(-6)..<wel.endIndex
wel.removeRange(range)


//字符串比较
let quotation = "hello!"
let sameQuotation = "hello!"
if quotation == sameQuotation {
    print("Tow strings are considered equal")
}

//由Unicode标量构成的只要它们有同样的语言意义和外观,就认为它们是相等的
let eAcuteQuestion = "Voulez-vous un caf\u{E9}"
let combinedEAcuteQuestion = "Voulez-vous un caf\u{65}\u{301}"
if eAcuteQuestion == combinedEAcuteQuestion {
    print("Tow strings are considered equal")
}


//前缀和后缀相等
let remeoAndJuliet = [
    "Act 1 Scene 1: Verona, A public place",
    "Act 1 Scene 2: Capulet's mansion",
    "Act 1 Scene 3: A room in Capulet's mansion",
    "Act 1 Scene 4: A street outside Capulet's mansion",
    "Act 1 Scene 5: The Great Hall in Capulet's mansion",
    "Act 2 Scene 1: Outside Capulet's mansion",
    "Act 2 Scene 2: Capulet's orchard",
    "Act 2 Scene 3: Outside Friar Lawrence's cell",
    "Act 2 Scene 4: A street in Verona",
    "Act 2 Scene 5: Capulet's mansion",
    "Act 2 Scene 6: Friar Lawrence's cell"
]



var hasAct1Prefix = 0
var hasMansionSuffix = 0
for scence in remeoAndJuliet {
    if scence.hasPrefix("Act 1") {
        hasAct1Prefix += 1
    }
    if scence.hasSuffix("mansion"){
        hasMansionSuffix += 1
    }
}
print("\(hasAct1Prefix), \(hasMansionSuffix)")




let dogString = "Dog‼🐶"
for codeUnit in dogString.utf8 {
    print("\(codeUnit)", terminator:" ")
    
}
print("")
for codeUnit in dogString.utf16 {
    print("\(codeUnit)", terminator:" ")
}
print("")
for codeUnit in dogString.unicodeScalars {
    print("\(codeUnit.value)", terminator:" ")
}
print("")
for codeUnit in dogString.unicodeScalars {
    print("\(codeUnit)", terminator:" ")
}
print("")






        