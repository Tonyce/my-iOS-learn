//: Playground - noun: a place where people can play

import UIKit

let nums = [1, 2, 3, 4, 5, 6, 7]

//var strs = [String]()

//for i in 0 ..< nums.count {
//    strs.append(String(nums[i]))
//}
//strs

let strs = nums.map(String.init)

//struct
class User {
    func login(password: String) {
        print("....")
    }
}

let passwd = "Swift"
let usr = User()
usr.login(passwd)

User.login(usr)
//User.login(usr)("")

//var someArr: [Int]!
var someArr: [Int]?
someArr = [1, 2, 3]
let result = someArr.map({"No. \($0)"})
result

var dictionary: [String: String?] = [:]
dictionary = ["key":"value"]
func justReturnNil() -> String? {
    return nil
}

dictionary["key"] = justReturnNil()
dictionary

dictionary["key"] = nil
dictionary