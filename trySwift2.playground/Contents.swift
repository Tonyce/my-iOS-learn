//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var index = 0
repeat {
    index++
} while index < 100
index

//-----------------------------

func greetingsForOptionals(name: String?) {
    
    guard let unwrappedName = name where unwrappedName.characters.count != 0 else {
        return
    }
    print("Greetings \(unwrappedName)")
}

var name: String? = "FooBar"
greetingsForOptionals(name)

//-----------------------------

enum CustomError : ErrorType {
    case ErrorWithMessage(message: String)
}

func loginUserWithName(username: String?) throws -> String {
    guard let username = username where username.characters.count != 0 else {
        throw CustomError.ErrorWithMessage(message: "No username provided")
    }
    return "token:" + username
}

func login() {
    
    do {
        let token = try loginUserWithName(nil)
        print("user logged in \(token)")
    } catch {
        print("An error occurred \(error)")
    }
}

login()

//----------------------------

enum TextCase {
    case Uppercase(String)
    case Lowercase(String)
}

let values: [TextCase] = [
    .Uppercase("FOO"),
    .Lowercase("iamlow"),
    .Uppercase("BAR"),
]

//Print all of some case
for case let .Uppercase(value) in values {
    print(value)
}

let number:Int? = 30
if case .Some(let value) = number where value > 20 {
    print(value)
}

//Print all unwrapped values
let optionals: [Int?] = [nil, 10, 20, 30, nil, 40]
for case let number? in optionals {
    print(number)
}