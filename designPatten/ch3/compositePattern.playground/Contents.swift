//: Playground - noun: a place where people can play

import UIKit

func ==(left: VODComponent, right: VODComponent) -> Bool {
    return left === right
}

class VODComponent: Equatable {
    
    func add(vodComponent: VODComponent) {
        assert(false, "This method is not supported")
    }
    
    func remove(vodComponent: VODComponent) {
        assert(false, "This method is not supported")
    }
    
    func getName() -> String {
        assert(false, "This method is not supported")
    }
    
    func getDescription() -> String {
        assert(false, "This method is not supported")
    }
    
    func getPrice() -> Double {
        assert(false, "This method is not supported")
    }
    
    func getChild(i: Int) -> VODComponent {
        assert(false, "This method is not supported")
    }
    
    func display() -> String{
        assert(false, "This method is not supported")
    }
}

class VODItem: VODComponent {
    private var name: String!
    private var description: String!
    private var price: Double!
    
    init(name: String!, description: String!, price: Double!) {
        self.name = name
        self.description = description
        self.price = price
    }
    
    override func getName() -> String {
        return name
    }
    
    override func getDescription() -> String {
        return description
    }
    
    override func getPrice() -> Double {
        return price
    }
    
    override func display() -> String {
        return "\(name), \(price), ---- \(description)"
    }
}

class VODCategory: VODComponent {
    var vodComponents = [VODComponent]()
    private var name: String!
    private var description: String!
    
    init(name: String!, description: String!) {
        self.name = name
        self.description = description
    }
    
    override func add(vodComponent: VODComponent) {
        vodComponents.append(vodComponent)
    }
    
    override func remove(vodComponent: VODComponent) {
        vodComponents.remove(vodComponent)
    }
    
    override func getChild(i:Int) -> VODComponent {
        return vodComponents[i]
    }
    
    override func getName() -> String {
        return name!
    }
    
    override func getDescription() -> String {
        return description
    }
    
    override func display() -> String {
        var text = "\(name), \(description) \r\n-----------"
        for e in vodComponents{
            text += "\r\n\(e.display()) \r\n"
        }
        return text
    }
}

extension Array {
    mutating func remove <T: Equatable> (object: T) {
        for i in (self.count - 1).stride(through: 0, by: -1) {
            if let element = self[i] as? T {
                if element == object {
                    self.removeAtIndex(i)
                }
            }
        }
    }
}

class VODManager {
    var catalog: VODComponent
    
    init(vod: VODComponent) {
        self.catalog = vod
    }
    
    func displayCatalog() {
        catalog.display()
    }
}

let horrorCategory = VODCategory(name: "Horror", description: "Horror movies category")
let tvSeriesCategory = VODCategory(name: "TV Series", description: "TV Series category")
let comedyCategory = VODCategory(name: "Comedy", description: "Comedy category")
let voSTTvSeries = VODCategory(name: "VOSTSeries", description: "VOST TV Series sub category")

let allVODComponents = VODCategory(name: "All VOD", description: "All vod components")
let vodManager = VODManager(vod: allVODComponents)

allVODComponents.add(horrorCategory)
allVODComponents.add(tvSeriesCategory)
allVODComponents.add(comedyCategory)
allVODComponents.add(voSTTvSeries)

horrorCategory.add(VODItem(name: "Scream", description: "Scream movie", price: 9.99))
horrorCategory.add(VODItem(name: "Paranormal Activity", description: "Paranormal Activity movie", price: 9.99))
horrorCategory.add(VODItem(name: "Blair Witch Project", description: "Blair Witch movie", price: 9.99))


tvSeriesCategory.add(VODItem(name: "Game of thrones S1E1", description: "Game of thrones Saison 1 episode 1", price: 1.99))
tvSeriesCategory.add(VODItem(name: "Deadwood", description: "Deadwood Saison 1 episode 1", price: 1.99))
tvSeriesCategory.add(VODItem(name: "Breaking Bad", description: "Breaking Bad Saison 1 Episode 1 " , price: 1.99))


vodManager.displayCatalog()
