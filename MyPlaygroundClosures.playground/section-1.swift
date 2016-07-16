// Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var a: Int!
print("\(a)")

let animals = ["fish", "cat", "chicken", "dog"]

func isBefore(one:String, two:String) -> Bool {
    return one > two
}

animals.sort(isBefore)

animals.sort({
    (one: String, two:String) -> Bool in
        return one > two
})

animals.sort({
    (one, two) -> Bool in
    return one > two
})

/*
animals.sorted({
    (one, two) -> Bool in
//    one > two
})
*/
animals.sort(>)

class AA {
    var aa = 3
    var bb = "bb"
    var aaa:String {
        return "3" + self.bb
    }
}

var aa = AA()
aa.aaa

var events = [Int]()

for i in 1...10 {
    if(i % 2 == 0){
        events.append(i)
    }
}
events

func isEven(number: Int) -> Bool {
    return number % 2 == 0
}

events = Array(1...10).filter(isEven)


events = Array(1...10).filter {(number) in number % 2 == 0}
events


events = Array(1...10).filter { $0 % 2 == 0}
events

func myFilter<T>(source: [T], predicate:(T) -> Bool) -> [T] {
    var result = [T]()
    for i in source {
        if(predicate(i)){
            result.append(i)
        }
    }
    return result
}

events = myFilter(Array(1...10), predicate: isEven)
events = myFilter(Array(1...10)) { $0 % 2 == 0 }
events
//
//extension Array {
//    func myFilter<T>(predicate:(T) -> Bool) -> [T] {
//        var source = self
//        
//        var result = [T]()
//        for i in source {
//            if(predicate(i)){
//                result.append(i)
//            }
//        }
//        return result
//    }
//}
//
//events = Array(1...10).myFilter(<#source: [T]#>, predicate: <#(T) -> Bool##(T) -> Bool#>)

events = [Int]()

for i in 1...10 {
    if(i % 2 == 0){
        events.append(i)
    }
}

var eventSum = 0;

for i in events {
    eventSum += i
}
eventSum

eventSum = Array(1...10).filter() {$0 % 2 == 0}.reduce(0) {(total, number) in total + number}
eventSum

import Foundation

var words = ["Cat", "Chicken", "fish", "Dog", "Mouse", "Guinea Pig", "monkey"]
words.count

typealias Entry = (Character, [String])
//func buildIndex(words: [String]) -> [Entry]{
//    // return [Entry]()
//    var result = [Entry]()
//    
//    var letters = [Character]()
//    for word in words {
//        let firstLetter = Character(word.substringToIndex(advance(word.startIndex, 1)).uppercaseString)
//        
//        if( !contains(letters, firstLetter)){
//            letters.append(firstLetter)
//        }
//    }
//    
//    for letter in letters {
//        var wordsForLetter = [String]()
//        
//        for word in words {
//            let firstLetter = Character(word.substringToIndex(advance(word.startIndex, 1)).uppercaseString)
//            
//            if( firstLetter == letter) {
//                wordsForLetter.append(word)
//            }
//        }
//        result.append((letter, wordsForLetter))
//    }
//    return result
//}

//println(buildIndex(words))

func distinct<T: Equatable>(source: [T]) -> [T]{
    var unique = [T]()
    for item in source {
        if( !contains(unique, item) ){
            unique.append(item)
        }
    }
    return unique
}

func buildIndex(words: [String]) -> [Entry] {
    
    func firstLetter(str: String) -> Character {
        return Character(str.substringToIndex(advance(str.startIndex, 1)).uppercaseString)
    }

    let letters = words.map {(word) -> Character in Character(word.substringToIndex(advance(word.startIndex, 1)).uppercaseString)}
    let distinctLetters = distinct(letters)
    println(distinctLetters)
    // return [Entry]();
    // return distinctLetters.map {
    //    (letter) -> Entry in return (letter, [])
    //}
    // return distinctLetters.map {
    return distinct(words.map(firstLetter)).map{
        (letter) -> Entry in
        return (letter, words.filter {
            (word) -> Bool in
            firstLetter(word) == letter
            })
    }
    
}

println(buildIndex(words))

var sumWithMultiplication = 1 + 2 + 3 * 3
var sumArr = [1,2] + [2, 3]

func add(left:[Int], right: [Int]) -> [Int] {
    var sum = [Int]()
    assert(left.count == right.count, "vector of same length only")
    for (key, v) in enumerate(left){
        sum.append(left[key] + right[key])
    }
    return sum
}

var arr = add([1,2], [4,5])

func +(left:[Int], right: [Int]) -> [Int] {
    var sum = [Int]()
    assert(left.count == right.count, "vector of same length only")
    for (key, v) in enumerate(left){
        sum.append(left[key] + right[key])
    }
    return sum
}

var arr1 = [1,2,3] + [44,6,5]

func randomNumber0_1() -> CGFloat{
    return  CGFloat(Float( rand() % 10000 ) / 10000.0);
}

randomNumber0_1()

rand()  % 10000

