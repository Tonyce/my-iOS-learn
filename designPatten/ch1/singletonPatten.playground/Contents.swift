//: Playground - noun: a place where people can play

import UIKit

class BoardGameManager {
    static let sharedInstance = BoardGameManager()
    init() {
        print("Singleton initialized")
    }
}

/**
 Usage
 *
 */
let boardManaget = BoardGameManager.sharedInstance
let b = BoardGameManager.sharedInstance
