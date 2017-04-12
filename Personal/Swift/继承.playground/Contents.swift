//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"


class Vehicle {
    var currentSpeed = 0.0
    var description: String {
        return "traveling at \(currentSpeed) miles per hour"
    }
    
    func makeNoise() -> Void {
        
    }
    
}

let  someVehicle = Vehicle()
someVehicle.description

class Bicycle: Vehicle {
    var hasBasket = false
    
}

let bicycle = Bicycle()
bicycle.hasBasket = true
bicycle.currentSpeed = 15
bicycle.description

class Tandem: Bicycle {
    var currentNumberOfPassenger = 0
    
}

let tandem = Tandem()
tandem.hasBasket = true
tandem.currentNumberOfPassenger = 2
tandem.currentSpeed = 20
tandem.description


//重写
class Train: Vehicle {
    override func makeNoise() {
        print(" Choo Choo")
    }
}

let train = Train()
train.makeNoise()


//重写属性
class Car: Vehicle {
    var gear = 1
    override var description: String {
        return super.description + " in gear \(gear)"
    }
    
}

let car = Car()
car.currentSpeed = 90
car.gear = 3
car.description


class AutomaticCar: Car {
    override var currentSpeed: Double {
        didSet {
            gear = Int(currentSpeed / 10) + 1
        }
    }
}

let automatic = AutomaticCar()
automatic.currentSpeed = 44
automatic.description














