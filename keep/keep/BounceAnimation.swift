//
//  BounceAnimation.swift
//  keep
//
//  Created by D_ttang on 15/5/16.
//  Copyright (c) 2015年 D_ttang. All rights reserved.
//

import UIKit

class BounceAnimation: ItemAnimation {
   
    override func playAnimation(icon: UIImageView, textLabel: UILabel) {
        playBounceAnimation(icon)
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
    
    func playBounceAnimation(icon: UIImageView){
        
        let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        bounceAnimation.values = [1.0 ,1.4, 0.9, 1.15, 0.95, 1.02, 1.0]
        bounceAnimation.duration = NSTimeInterval(duration)
        bounceAnimation.calculationMode = kCAAnimationCubic
        
        icon.layer.addAnimation(bounceAnimation, forKey: "bounceAnimation")
        
        let renderImage = icon.image?.imageWithRenderingMode(.AlwaysTemplate)
        icon.image = renderImage
        icon.tintColor = iconSelectedColor
        
    }
    
}
