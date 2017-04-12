//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


//可空链式调用来强制展开

class Person {
    var residence: Residence?
    
}

class Residence {
    var rooms = [Room]()
    
    var numberOfRooms: Int {
        return rooms.count
    }
    
    subscript(i: Int) -> Room {
        get {
            return rooms[i]
        }
        
        set {
            rooms[i] = newValue
        }
    }
    
    func printNumberOfRoom() -> Void {
        print("The number of rooms is \(numberOfRooms)")
    }
    
    var address: Address?
    
    
}

class Room {
    let name: String
    init(name: String) {
        self.name = name
    }
    
}



class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    
    func buildingIdentifier() -> String? {
        if buildingName != nil {
            return buildingName
        }else if buildingNumber != nil {
            return buildingNumber
        }
        return nil
    }
}



let john = Person()
//用!强制展开 报错
//let roomCount = john.residence!.numberOfRooms

if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) rooms")
}else {
    print("Unable to retrieve the number of rooms")
}

let someAddress = Address()
someAddress.buildingNumber = "29"
someAddress.street = "Acacia Road"
//residence是nil  所以显示nil
john.residence?.address = someAddress

//调用方法也可以判断
if john.residence?.printNumberOfRoom() != nil {
    print("It was possible to print the number of rooms")
}else {
    print("It was not possible to print the number o rooms")
}

//属性赋值也可以判断
if (john.residence?.address = someAddress) != nil {
    print("It was possible to set the address")
}else {
    print("It was not possible to set the address")
}

//可空链式调用来访问下标
if let firstRoomName = john.residence?[0].name {
    print("The first room name is \(firstRoomName)")
}else {
    print("Unable to retrieve the first room name")
}

//同样赋值失败
john.residence?[0] = Room(name: "Bathroom")



john.residence = Residence()
john.residence?.rooms.append(Room(name: "Livingroom"))
john.residence?.rooms.append(Room(name: "Kitchen"))

if let roomCount = john.residence?.numberOfRooms {
    print("John's residence has \(roomCount) rooms")
}else {
    print("Unable to retrieve the number of rooms")
}


if let firstRoomName = john.residence?[0].name {
    print("The first room name is \(firstRoomName)")
}else {
    print("Unable to retrieve the first room name")
}


//访问可空类型的下标
var testScores = ["Dave":[86, 82, 84], "Bev": [79, 94, 81]]
testScores["Dave"]?[0] = 91
testScores["Bev"]?[0] += 1
testScores["Brian"]?[0] = 72
testScores

if let johnStreet = john.residence?.address?.street {
    print("John's street name is \(johnStreet)")
}else {
    print("Unable to retrieve the address")
}


let  johnStreet = Address()
johnStreet.buildingName = "The Larches"
johnStreet.street = "Laurel Street"
john.residence?.address = johnStreet

if let johnStreet = john.residence?.address?.street {
    print("John's street name is \(johnStreet)")
}else {
    print("Unable to retrieve the address")
}

if let buildIdentifier = john.residence?.address?.buildingIdentifier() {
    print("John's building identifier is \(buildIdentifier)")
}


if let beginWithThe = john.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
    if beginWithThe {
        print("John's building identifier begins with \"The\"")
    }else {
        print("John's building identifier does not begin with \"The\"")
    }
}







