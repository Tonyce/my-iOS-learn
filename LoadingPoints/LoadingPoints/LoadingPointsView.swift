//
//  LoadingPointsView.swift
//  LoadingPoints
//
//  Created by D_ttang on 2016/6/22.
//  Copyright © 2016年 D_ttang. All rights reserved.
//

import UIKit
import QuartzCore

class LoadingPointsView: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    var colors: [UIColor] = []
    var pointWidth: CGFloat = 0
    var interval: CGFloat = 0
    convenience init(colors: [UIColor], frame: CGRect) {
        
        self.init(frame: CGRectZero)
        self.colors = colors
        self.frame = frame
        self.pointWidth = frame.width / 2 / CGFloat(colors.count)
        self.interval = self.pointWidth / 3
    }
    
    override func layoutSubviews() {
        let begin = frame.width / 2 - ((pointWidth + interval) * CGFloat(colors.count) - interval) / 2
        for i in 0 ..< colors.count {
            let beginX = begin + CGFloat(i) * (pointWidth + interval)
            let rect = CGRect(x: beginX, y: frame.height / 2, width: pointWidth, height: pointWidth)
            let pointView = UIView(frame: rect)
            pointView.layer.cornerRadius = pointWidth / 2
            pointView.backgroundColor = colors[i]
            
            pointView.transform = CGAffineTransformMakeScale(0, 0)
            let anim = transAnimation(0.8, delay: (0.2 * Double(i)))
            pointView.layer.addAnimation(anim, forKey: "scale")
            
            addSubview(pointView)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    func transAnimation(duration: NSTimeInterval, delay: CFTimeInterval) -> CABasicAnimation {
        let anim = CABasicAnimation(keyPath: "transform.scale")
        anim.delegate = self
        anim.fromValue = 0.0
        anim.toValue = 1.0
        anim.autoreverses = true
        anim.duration = duration
        anim.removedOnCompletion = false
        anim.beginTime = CACurrentMediaTime() + delay
        anim.repeatCount = Float.infinity
        anim.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        return anim
    }
}
