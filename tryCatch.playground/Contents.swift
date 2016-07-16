//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

//func canThrowErrors() throw -> String

enum VendingMachineError: ErrorType {
    case InvalidSelection
    case InsufficientFunds(required: Double)
    case OutOfStock
}

struct Item {
    var price: Double
    var count: Int
}

var inventory = [
    "Candy Bar": Item(price: 1.25, count: 7),
    "Chips": Item(price: 1.00, count: 4),
    "Pretzels": Item(price: 0.72, count: 11)
]

var amountDeposited = 1.00

func vend(itemNamed name: String) throws {
    
    guard let item = inventory[name] else {
        throw VendingMachineError.InvalidSelection
    }
    
    guard item.count > 0 else {
        throw VendingMachineError.OutOfStock
    }
    
    if amountDeposited >= item.price {
        amountDeposited -= item.price
        item.count
        inventory[name] = item
    }else{
        let amountRequired = item.price - amountDeposited
        throw VendingMachineError.InsufficientFunds(required: amountRequired)
    }
}

//do{
//    try vend(itemNamed: "Candy Bar")
//} catch VendingMachineError.In



