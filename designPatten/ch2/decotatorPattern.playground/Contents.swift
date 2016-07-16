//: Playground - noun: a place where people can play

import UIKit

protocol IShape {
    func draw() -> String
}

class Square: IShape {
    func draw() -> String {
        return "drawing Shape: Square"
    }
}

class Rectangle: IShape {
    func draw() -> String {
        return "drawing Shape: Rectangle"
    }
}

class ShapeDecorator: IShape {
    private let decoratedShape: IShape
    
    required init(decoratedShape: IShape) {
        self.decoratedShape = decoratedShape
    }
    
    func draw() -> String {
        fatalError("Not implemented")
    }
}

class RoundedCornerShapeDecorator: ShapeDecorator {
    required init(decoratedShape: IShape) {
        super.init(decoratedShape: decoratedShape)
    }
    
    override func draw() -> String {
        return decoratedShape.draw() + "," + setRoundedCornerShape(decoratedShape)
    }
    
    func setRoundedCornerShape(decoratedShape: IShape) -> String {
        return "Conners are rounded"
    }
}

let rectangle = Rectangle()
let square = Square()

let roundedRectangle = RoundedCornerShapeDecorator(decoratedShape: Rectangle())
let roundedSquare = RoundedCornerShapeDecorator(decoratedShape: Square())

print("rectangle with Normal Angles")
rectangle.draw()
roundedRectangle.draw()

print("square with Normal Angles")
square.draw()
roundedSquare.draw()



