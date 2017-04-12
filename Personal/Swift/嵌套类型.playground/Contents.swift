//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


struct BlackJackCard {
    
    //嵌套Suit枚举
    enum Suit: Character {
        case spades = "♠", hearts = "♡", diamonds = "♢", clubs = "♣"
    }
    
    //嵌套Rank枚举
    enum Rank: Int {
        case two = 2, three, four, five, six, seven, eight, nine, ten
        case jack, queue, king, ace
        
        struct Values {
            let first: Int, second: Int?
            
        }
        
        var values: Values {
            switch self {
            case .ace:
                return Values(first: 1, second: 11)
            case .jack, .queue, .king:
                return Values(first: 10, second: nil)
            default:
                return Values(first: self.rawValue, second: nil)
            }
        }
        
    }
    
    //BlackJackCard的属性和方法
    let  rank: Rank, suit: Suit
    var description: String {
        var output = "suit is \(suit.rawValue),"
        output += " Value is \(rank.values.first)"
        
        if let second = rank.values.second {
            output += "or \(second)"
        }
        
        return output
    }
    

    
}

let theAceOfSpades = BlackJackCard(rank: .ace, suit: .spades)
print(theAceOfSpades.description)


//嵌套类型的引用

let heartsSymbol = BlackJackCard.Suit.hearts.rawValue












