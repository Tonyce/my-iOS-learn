//
//  TestViewController.swift
//  myTableView
//
//  Created by D_ttang on 15/6/26.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit
import Darwin

//let kMMRingStrokeAnimationKey = "mmmaterialdesignspinner.stroke"
//let kMMRingRotationAnimationKey = "mmmaterialdesignspinner.rotation"

class TestViewController: UIViewController {

    // let mmSpinner = MMSpinner()
    let ovalShapeLayer: CAShapeLayer = CAShapeLayer()
    let shapeView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        shapeView.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        shapeView.backgroundColor = UIColor.whiteColor()
        shapeView.layer.cornerRadius = CGRectGetHeight(shapeView.bounds) / 2
        
        shapeView.layer.shadowColor = UIColor.blackColor().CGColor
        shapeView.layer.shadowOffset = CGSize(width: 0, height: 0.5)
        shapeView.layer.shadowOpacity = 0.5

        self.view.addSubview(shapeView)
        

        ovalShapeLayer.strokeColor = UIColor.redColor().CGColor
        ovalShapeLayer.fillColor = UIColor.clearColor().CGColor
        ovalShapeLayer.lineWidth = 4.0
        ovalShapeLayer.frame = CGRectMake(0, 0, shapeView.frame.width, shapeView.frame.height)
//        ovalShapeLayer.backgroundColor = UIColor.orangeColor().CGColor
        let refreshRadius = shapeView.frame.size.height/2 * 0.5
        let path = UIBezierPath(ovalInRect: CGRect(
            x: shapeView.frame.size.width/2 - refreshRadius,
            y: shapeView.frame.size.height/2 - refreshRadius,
            width: 2 * refreshRadius,
            height: 2 * refreshRadius))
        
        // arc
//        let center: CGPoint = CGPointMake(CGRectGetMidX(self.shapeView.bounds), CGRectGetMidY(self.shapeView.bounds))
////        let radius: CGFloat  = min(CGRectGetWidth(self.shapeView.bounds) / 2, CGRectGetHeight(self.shapeView.bounds) / 2) - self.progressLayer.lineWidth / 2;
//        let startAngle:CGFloat = 0.0
//        let endAngle: CGFloat = CGFloat(2 * M_PI)
//        let path = UIBezierPath(arcCenter: center, radius: refreshRadius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        ovalShapeLayer.path = path.CGPath
//        ovalShapeLayer.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame))

//        shapeView.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame))
//        shapeView.bounds = CGRectMake(0,0, 100*0.8, 100*0.8)
        shapeView.layer.addSublayer(ovalShapeLayer)
        beginRefreshing()

//        stopAnimate()
//
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func beginRefreshing() {
//        isRefreshing = true
        
//        UIView.animateWithDuration(0.3, animations: {
//            var newInsets = self.scrollView!.contentInset
//            newInsets.top += self.frame.size.height
//            self.scrollView!.contentInset = newInsets
//        })
        
//        let strokeStartAnimation = CABasicAnimation(keyPath: "strokeStart")
//        strokeStartAnimation.fromValue = -0.5
//        strokeStartAnimation.toValue = 1.0
//        
//        let strokeEndAnimation = CABasicAnimation(keyPath: "strokeEnd")
//        strokeEndAnimation.fromValue = 0.0
//        strokeEndAnimation.toValue = 1.0
//        
//        let strokeAnimationGroup = CAAnimationGroup()
//        strokeAnimationGroup.duration = 1.5
//        strokeAnimationGroup.repeatDuration = 5.0
//        strokeAnimationGroup.animations = [strokeStartAnimation, strokeEndAnimation]
//        ovalShapeLayer.addAnimation(strokeAnimationGroup, forKey: nil)
        let animation = CABasicAnimation()
        //        CABasicAnimation *animation = [CABasicAnimation animation];
        animation.keyPath = "transform.rotation"
        animation.duration = 4.0;
        animation.fromValue = 0.0;
        animation.toValue = 2 * M_PI;
        animation.repeatCount = Float.infinity

        ovalShapeLayer.addAnimation(animation, forKey: kMMRingRotationAnimationKey)
        
        let headAnimation = CABasicAnimation()
        headAnimation.keyPath = "strokeStart"
        headAnimation.duration = 1.0;
        headAnimation.fromValue = 0.0;
        headAnimation.toValue = 0.25;

        
        let tailAnimation = CABasicAnimation()
        tailAnimation.keyPath = "strokeEnd"
        tailAnimation.duration = 1.0
        tailAnimation.fromValue = 0.0
        tailAnimation.toValue = 1.0
                tailAnimation.delegate = self
        
        
        let endHeadAnimation = CABasicAnimation()
        endHeadAnimation.keyPath = "strokeStart"
        endHeadAnimation.beginTime = 1.0
        endHeadAnimation.duration = 0.5
        endHeadAnimation.fromValue = 0.25
        endHeadAnimation.toValue = 1.0
        
        let endTailAnimation = CABasicAnimation()
        endTailAnimation.keyPath = "strokeEnd"
        endTailAnimation.beginTime = 1.0
        endTailAnimation.duration = 0.5
        endTailAnimation.fromValue = 1.0
        endTailAnimation.toValue = 1.0
        
        let animations = CAAnimationGroup()
        animations.duration = 1.5
        animations.animations = [headAnimation, tailAnimation, endHeadAnimation, endTailAnimation]
        animations.repeatCount = Float.infinity
        ovalShapeLayer.addAnimation(animations, forKey: kMMRingStrokeAnimationKey)
//        ovalShapeLayer.strokeColor = UIColor.blueColor().CGColor
    }
    
    func stopAnimate(){

        ovalShapeLayer.removeAnimationForKey(kMMRingRotationAnimationKey)
        ovalShapeLayer.removeAnimationForKey(kMMRingStrokeAnimationKey)
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
                ovalShapeLayer.strokeColor = UIColor.blueColor().CGColor
    }
}
