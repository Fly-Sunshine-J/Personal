//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

struct Bank {
    static var coinsInBank = 10000
    static func vendCoins(numberOfCoinsToVend: Int) -> Int {
        let numberOfCoinsToVend = min(numberOfCoinsToVend, coinsInBank)
        coinsInBank -= numberOfCoinsToVend
        return numberOfCoinsToVend
    }
    
    static func receiveCoins(coins: Int) {
        coinsInBank += coins
    }
}

class Player: NSObject {
    var coinsInPurse: Int
    init(coins: Int) {
        coinsInPurse = Bank.vendCoins(coins)
    }
    
    func winCoins(coins: Int) -> Void {
        coinsInPurse += Bank.vendCoins(coins)
    }
    
    deinit {
        Bank.receiveCoins(coinsInPurse)
    }
}

var playerOne: Player? = Player(coins: 100)
print("A new player has joined the game with \(playerOne!.coinsInPurse) coins")
print("There are now \(Bank.coinsInBank) coins left in the bank")
playerOne!.winCoins(2000)
print("A new player has joined the game with \(playerOne!.coinsInPurse) coins")
print("There are now \(Bank.coinsInBank) coins left in the bank")


playerOne = nil
print("There are now \(Bank.coinsInBank) coins left in the bank")









