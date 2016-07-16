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
//        default:
//            return SportBand(size: .ML)
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

/**
 Usage
 *
 */
let manufacture1 = WatchFactory.getFactory(WatchSize._38mm)
let productA = manufacture1.createBand(BandType.Milanese)
productA.color
productA.size
productA.type

let productB = manufacture1.createDial(MaterialType.Gold)
productB.material
productB.size


let manufacture2 = WatchFactory.getFactory(WatchSize._42mm)
let productC = manufacture2.createBand(BandType.LinkBracelet)
productC.color
productC.size
productC.type

let productD = manufacture2.createDial(MaterialType.Gold)
productD.material
productD.size