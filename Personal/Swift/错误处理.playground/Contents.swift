//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

enum VendingMachineError: ErrorType {
    case InvalidSelection
    case InsufficientFunds(required: Double)
    case OutOfStrock
}

struct Item {
    var price: Double
    var count: Int
    
}

class VendingMachine {
    var inventory  = ["Candy Bar": Item(price: 1.25, count: 7), "Chips": Item(price: 1, count: 4), "Pretzels": Item(price: 0.75, count: 11)]
    
    var amountDeposited = 0.0
    
    func vend(itemNamed name: String) throws -> Void {
        guard let item = inventory[name] else {
            throw VendingMachineError.InvalidSelection
        }
        
        guard item.count > 0 else {
            throw VendingMachineError.OutOfStrock
        }
        
        guard item.price <= amountDeposited else {
            throw VendingMachineError.InsufficientFunds(required: item.price - amountDeposited)
        }
        
        amountDeposited -= item.price
        
        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem
        
        print("Dispensing \(name)")
        
        
    }
}


let favoriteSnacks = ["Alice": "Chips", "Bob": "Licorice", "Eve": "Pretzels"]

func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    try vendingMachine.vend(itemNamed: snackName)
}

struct PurchasedSnack {
    let name: String
    init(name: String, vendingMachine: VendingMachine) throws {
        try vendingMachine.vend(itemNamed: name)
        self.name = name
    }
    
}

//do catch

var vendingMachine = VendingMachine()
vendingMachine.amountDeposited = 0.8

do {
    try buyFavoriteSnack("Alice", vendingMachine: vendingMachine)
}catch VendingMachineError.InvalidSelection{
    print("Invalid selection")
}catch VendingMachineError.OutOfStrock {
    print("Out of Stock")
}catch VendingMachineError.InsufficientFunds(let coinsNeeded) {
    print("Insufficient funds. Please insert an additional \(coinsNeeded) coins")
}


//转换错误为可选类型

struct Data {
    
}

func fetchDataFromDisk() throws -> Data {
    return Data()
}

func fetchDataFromSever() throws -> Data {
    return Data()
}

func fetchData() -> Data? {
    if let data = try? fetchDataFromDisk() {
        return data
    }
    
    if let data = try? fetchDataFromSever() {
        return data
    }
    
    return nil
}


//使用defer做收尾 不管有没有抛出错误 都会执行的代码
/*
func processFile(filename: String) throws -> Void {
    if exists(filename) {
        let file = open(filename)
        
    }
    
    defer {
        close(file)
    }
    
    while let line = try file.readline() {
        // work file
    }
    
//    close(file) is called here
    
}

*/
