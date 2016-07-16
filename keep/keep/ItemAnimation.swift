//
//  ItemAnimationProtocal.swift
//  keep
//
//  Created by D_ttang on 15/5/16.
//  Copyright (c) 2015年 D_ttang. All rights reserved.
//

import UIKit
import Foundation

protocol ItemAnimationProtocal {

    func playAnimation(icon: UIImageView, textLabel: UILabel)
    func deselectAnimation(icon: UIImageView, textLabel: UILabel, defaultTextColor: UIColor)
    func selectedState(icon: UIImageView, textLabel: UILabel)
}

class ItemAnimation: NSObject, ItemAnimationProtocal {

    var duration: CGFloat = 0.5
//    var textSelectedColor: UIColor = UIColor.blackColor()
    var textSelectedColor: UIColor!
    var iconSelectedColor: UIColor!
    
    func playAnimation(icon: UIImageView, textLabel: UILabel){}
    func deselectAnimation(icon: UIImageView, textLabel: UILabel, defaultTextColor: UIColor){}
    func selectedState(icon: UIImageView, textLabel: UILabel){}
}
