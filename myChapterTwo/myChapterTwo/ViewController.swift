//
//  ViewController.swift
//  myChapterTwo
//
//  Created by D_ttang on 14/12/21.
//  Copyright (c) 2014年 D_ttang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let words = ["Cat", "Chicken", "fish", "Dog", "Mouse", "Guinea Pig", "monkey"]
        typealias Entry = (Character, [String])
        func buildIndex(words: [String]) -> [Entry] {
            var result = [Entry]()
            var letters = [Character]()
            
            for word in words {
                println("----")
                let firstLetter = Character(word.substringToIndex(advance(word.startIndex, 1)).uppercaseString)
                println("\(firstLetter)")
                if !contains(letters, firstLetter) {
                    letters.append(firstLetter)
                }
            }
            
            for letter in letters {
                var wordsForLetter = [String]()
                for word in words {
                    let firstLetter = Character(word.substringToIndex(advance(word.startIndex, 1)).uppercaseString)
                    if firstLetter == letter {
                        wordsForLetter.append(word)
                    }
                }
                result.append((letter, wordsForLetter))
            }
            println(result)
            return result
        }
        buildIndex(words)
        println(buildIndex(words))
        
    }
    
    override func didReceiveMemoryWarning() {
                super.didReceiveMemoryWarning()
                // Dispose of any resources that can be recreated.
    }
    
    
}

