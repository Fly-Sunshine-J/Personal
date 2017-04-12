//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

//下标脚本语法
struct TimesTable {
    let multiplier: Int
    subscript (index: Int) -> Int {
        return multiplier * index
    }
    
}


let threeTimesTable = TimesTable(multiplier: 3)
print("3的6倍是\(threeTimesTable[6])")

var numberOfLegs = ["spider": 8, "ant": 6, "cat": 4]
numberOfLegs["bird"] = 2


struct Matrix {
    let rows: Int, columns: Int
    var grid: [Double]
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(count: rows * columns, repeatedValue: 0.0)
    }
    
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column <= columns
    }
    
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValid(row, column: column), "Index out of range")
            return grid[row * column + column]
        }
        
        set {
            assert(indexIsValid(row, column: column), "Index out of range")
            grid[row * column + column] = newValue
        }
    }
    
}


var matrix = Matrix(rows: 2, columns: 2)
matrix[1, 1] = 2
matrix[0, 0] = 2
matrix.grid

//let someValue = matrix[2, 2]



