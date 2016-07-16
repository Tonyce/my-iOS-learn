//: Playground - noun: a place where people can play

import UIKit

protocol ImplementationBase {
    func run()
}

protocol IAbstractBridge {
    var concreteImpl: ImplementationBase {get set}
    func turnOn()
}

class RemoteControl: IAbstractBridge {
    var concreteImpl: ImplementationBase
    
    func turnOn() {
        self.concreteImpl.run()
    }
    
    init(concreteImpl: ImplementationBase) {
        self.concreteImpl = concreteImpl
    }
}

class TV: ImplementationBase {
    func run() {
        print("TV turned on")
    }
}

class Light: ImplementationBase {
    func run() {
        print("Light turned on")
    }
}

let tvRemoteControl = RemoteControl(concreteImpl: TV())
tvRemoteControl.turnOn()

let lightRemoteControl = RemoteControl(concreteImpl: Light())
lightRemoteControl.turnOn()