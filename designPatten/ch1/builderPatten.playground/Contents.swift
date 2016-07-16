//: Playground - noun: a place where people can play

import UIKit

enum WatchSize: String {
    case _38mm = "38mm", _42mm = "42mm"
}

enum BandSize: String {
    case SM = "SM", ML = "ML"
}

enum MaterialType: String {
    case Aluminium = "Aluminium", StainlessSteel = "Stainless Steel", Gold = "Gold"
}

enum BandType: String {
    case Milanese = "Milanese"
    case Classic  = "Classic"
    case Leather  = "Leather"
    case Modern   = "Modern"
    case LinkBracelet = "LinkBracelet"
    case SportBand = "SportBand"
}

protocol IWatchBand {
    var color: UIColor  {get set}
    var size : BandSize {get set}
    var type : BandType {get set}
    init(size: BandSize)
}

protocol IWatchDial {
    var material: MaterialType {get set}
    var size : WatchSize {get set}
    init(size: WatchSize)
}

class MilaneseBand: IWatchBand {
    var color = UIColor.yellowColor()
    var size: BandSize
    var type = BandType.Classic
    
    required init(size _size: BandSize) {
        self.size = _size
    }
}

class ClassicBand: IWatchBand {
    var color = UIColor.yellowColor()
    var size: BandSize
    var type  = BandType.Classic
    required init(size _size: BandSize) {
        self.size = _size
    }
}

class LeatherBand: IWatchBand {
    var color = UIColor.yellowColor()
    var size: BandSize
    var type  = BandType.Leather
    required init(size _size: BandSize) {
        self.size = _size
    }
}

class ModernBand: IWatchBand {
    var color = UIColor.yellowColor()
    var size: BandSize
    var type = BandType.Modern
    required init(size _size: BandSize) {
        self.size = _size
    }
}

class LinkBraceletBand: IWatchBand {
    var color = UIColor.yellowColor()
    var size: BandSize
    var type = BandType.LinkBracelet
    required init(size _size: BandSize) {
        self.size = _size
    }
}

class SportBand: IWatchBand {
    var color = UIColor.yellowColor()
    var size: BandSize
    var type = BandType.SportBand
    required init(size _size: BandSize) {
        self.size = _size
    }
}


class AluminiumDial: IWatchDial {
    var material = MaterialType.Aluminium
    var size: WatchSize
    required init(size _size: WatchSize) {
        self.size = _size
    }
}

class StainlessSteelDial: IWatchDial {
    var material = MaterialType.StainlessSteel
    var size: WatchSize
    required init(size _size: WatchSize) {
        self.size = _size
    }
}

class GoldDial: IWatchDial {
    var material = MaterialType.Gold
    var size: WatchSize
    required init(size _size: WatchSize) {
        self.size = _size
    }
}

class WatchFactory {
    func createBand(bandType: BandType) -> IWatchBand {
        fatalError("not implemented")
    }
    func createDial(materialType: MaterialType) -> IWatchDial {
        fatalError("not implemented")
    }
    
    final class func getFactory(size: WatchSize) -> WatchFactory {
        var factory: WatchFactory?
        switch size {
        case ._38mm:
            factory = Watch38mmFactory()
        case ._42mm:
            factory = Watch42mmFactory()
        }
        return factory!
    }
}

class Watch42mmFactory: WatchFactory {
    override func createBand(bandType: BandType) -> IWatchBand {
        switch bandType {
        case .Milanese:
            return MilaneseBand(size: .ML)
        case .Classic:
            return ClassicBand(size: .ML)
        case .Leather:
            return LeatherBand(size: .ML)
        case .LinkBracelet:
            return LinkBraceletBand(size: .ML)
        case .Modern:
            return ModernBand(size: .ML)
        case .SportBand:
            return SportBand(size: .ML)
        }
    }
    
    override func createDial(materialType: MaterialType) -> IWatchDial {
        switch materialType {
        case .Aluminium:
            return AluminiumDial(size: ._42mm)
        case .Gold:
            return GoldDial(size: ._42mm)
        case .StainlessSteel:
            return StainlessSteelDial(size: ._42mm)
        }
    }
}

class Watch38mmFactory: WatchFactory {
    override func createDial(materialType: MaterialType) -> IWatchDial {
        switch materialType {
        case .Aluminium:
            return AluminiumDial(size: ._38mm)
        case .Gold:
            return GoldDial(size: ._38mm)
        case .StainlessSteel:
            return StainlessSteelDial(size: ._38mm)
        }
    }
    
    override func createBand(bandType: BandType) -> IWatchBand {
        switch bandType {
        case .Classic:
            return ClassicBand(size: .SM)
        case .Leather:
            return LeatherBand(size: .SM)
        case .LinkBracelet:
            return LinkBraceletBand(size: .SM)
        case .Milanese:
            return MilaneseBand(size: .SM)
        case .Modern:
            return ModernBand(size: .SM)
        case .SportBand:
            return SportBand(size: .SM)
        }
    }
}

/*
class Watch {
    var dial: IWatchDial?
    var band: IWatchBand?
    init(){}
}

class AbstractWatchBuilder {
    private var watch: Watch = Watch()
    func buildBand() {
        fatalError("not implement")
    }
    func buildDail() {
        fatalError("not implement")
    }
    init(){}
    
    func getResult() -> Watch {
        return watch
    }
}

class BuilderGoldMilanese38mmWatch: AbstractWatchBuilder {
    override func buildBand() {
        watch.band = MilaneseBand(size: BandSize.SM)
    }
    override func buildDail() {
        watch.dial = GoldDial(size: WatchSize._38mm)
    }
}

class BuilderAluminiumSportBand42mmWatch: AbstractWatchBuilder {
    override func buildDail() {
        watch.dial = AluminiumDial(size: ._42mm)
    }
    override func buildBand() {
        watch.band = SportBand(size: BandSize.ML)
    }
}

class Director {
    var builder: AbstractWatchBuilder?
    init(){}
    
    func buildWatch(builder: AbstractWatchBuilder) {
        builder.buildBand()
        builder.buildDail()
    }
}
*/

/**
 Usage
 *
 
let director = Director()
var b1 = BuilderAluminiumSportBand42mmWatch()
director.buildWatch(b1)

var w1 = b1.getResult()
w1.band

var b2 = BuilderGoldMilanese38mmWatch()
director.buildWatch(b2)

var w2 = b2.getResult()
w2.band
*/


class Watch {
    var dial: IWatchDial?
    var band: IWatchBand?
    
    typealias buildWatchClosure = (Watch) -> Void
    
    init(build: buildWatchClosure) {
        build(self)
    }
}

let Gold42mmMilaneseWatch = Watch(build: {
    $0.band = MilaneseBand(size: .ML)
    $0.dial = GoldDial(size: ._42mm)
})

Gold42mmMilaneseWatch.band

let Aluminium38mmMilaneseWatch = Watch { (Watch) in
    Watch.band = MilaneseBand(size: .SM)
    Watch.dial = AluminiumDial(size: ._38mm)
}

Aluminium38mmMilaneseWatch.band