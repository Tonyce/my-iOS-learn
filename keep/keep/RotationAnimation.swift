//
//  RotationAnimation.swift
//  keep
//
//  Created by D_ttang on 15/5/16.
//  Copyright (c) 2015年 D_ttang. All rights reserved.
//

import UIKit
import QuartzCore

enum RotationDirection {
    case Left
    case Right
}

class RotationAnimation: ItemAnimation {
   
    var direction: RotationDirection!
    
    override func playAnimation(icon: UIImageView, textLabel: UILabel) {
        playRoatationAnimation(icon)
        textLabel.textColor = textSelectedColor
    }
    
    override func deselectAnimation(icon: UIImageView, textLabel: UILabel, defaultTextColor: UIColor) {
        textLabel.textColor = defaultTextColor
        
        let renderImage = icon.image?.imageWithRenderingMode(.AlwaysTemplate)
        icon.image = renderImage
        icon.tintColor = defaultTextColor
    }
    
    override func selectedState(icon: UIImageView, textLabel: UILabel) {
        textLabel.textColor = textSelectedColor
        
        let renderImage = icon.image?.imageWithRenderingMode(.AlwaysTemplate)
        icon.image = renderImage
        icon.tintColor = textSelectedColor
    }
    
    
    func playRoatationAnimation(icon : UIImageView) {
        
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        
        var toValue = CGFloat(M_PI * 2.0)
        if direction != nil && direction == RotationDirection.Left {
            toValue = toValue * -1.0
        }
        
        rotateAnimation.toValue = toValue
        rotateAnimation.duration = NSTimeInterval(duration)
        
        icon.layer.addAnimation(rotateAnimation, forKey: "rotation360")
        
        let renderImage = icon.image?.imageWithRenderingMode(.AlwaysTemplate)
        icon.image = renderImage
        icon.tintColor = iconSelectedColor
    }
    
}

class LeftRotationAnimation: RotationAnimation {
    override init() {
        super.init()
        direction = RotationDirection.Left
    }
}


class RightRotationAnimation: RotationAnimation {
    override init() {
        super.init()
        direction = RotationDirection.Right
    }
}
