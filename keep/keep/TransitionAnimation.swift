//
//  TransitionAnimation.swift
//  keep
//
//  Created by D_ttang on 15/5/16.
//  Copyright (c) 2015年 D_ttang. All rights reserved.
//

import UIKit

class TransitionAnimation: ItemAnimation {
    
    var transitionOptions: UIViewAnimationOptions!
    
    override init() {
        super.init()
        transitionOptions = UIViewAnimationOptions.TransitionNone
    }
 
    override func playAnimation(icon: UIImageView, textLabel: UILabel) {
        selectedColor(icon, textLabel: textLabel)
        
        UIView.transitionWithView(icon,
            duration: NSTimeInterval(duration),
             options: transitionOptions,
          animations: {},completion: { finished in })
    }
    
    override func deselectAnimation(icon: UIImageView, textLabel: UILabel, defaultTextColor: UIColor) {
        let renderImage = icon.image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal)
        icon.image = renderImage;
        textLabel.textColor = defaultTextColor
    }
    
    override func selectedState(icon: UIImageView, textLabel: UILabel) {
        selectedColor(icon, textLabel: textLabel)
    }
    
    func selectedColor(icon : UIImageView, textLabel : UILabel) {
        
//        if iconSelectedColor == nil {
            let renderImage = icon.image?.imageWithRenderingMode(UIImageRenderingMode.AlwaysTemplate)
            icon.image = renderImage;
            icon.tintColor = iconSelectedColor
//        }
        
        textLabel.textColor = textSelectedColor
    }
}

class FlipLeftTransitionAniamtion : TransitionAnimation {
    
    override init() {
        super.init()
        
        transitionOptions = UIViewAnimationOptions.TransitionFlipFromLeft
    }
}


class FlipRightTransitionAniamtions: TransitionAnimation {
    
    override init() {
        super.init()
        
        transitionOptions = UIViewAnimationOptions.TransitionFlipFromRight
    }
}

class FlipTopTransitionAniamtion: TransitionAnimation {
    
    override init() {
        super.init()
        
        transitionOptions = UIViewAnimationOptions.TransitionFlipFromTop
    }
}

class FlipBottomTransitionAniamtion: TransitionAnimation {
    
    override init() {
        super.init()
        
        transitionOptions = UIViewAnimationOptions.TransitionFlipFromBottom
    }
}
