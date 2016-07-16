//
//  MMSpinner.swift
//  myTableView
//
//  Created by D_ttang on 15/6/26.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit

let kMMRingStrokeAnimationKey = "mmmaterialdesignspinner.stroke"
let kMMRingRotationAnimationKey = "mmmaterialdesignspinner.rotation"


class MMSpinner: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    var lineWidth: CGFloat!
    var hidesWhenStopped: Bool!
    var timingFunction: CAMediaTimingFunction!
    var isAnimating: Bool = true
    
    var progressLayer: CAShapeLayer!
    
    func setAnimatin(animate:Bool){
        if animate {
            self.startAnimating()
        }else {
            self.stopAnimating()
        }
    }
    
    func startAnimating(){
        
        
//        if (self.isAnimating == true) {
//            return
//        }
        
        self.progressLayerInit()
        
        var animation = CABasicAnimation()
//        CABasicAnimation *animation = [CABasicAnimation animation];
        animation.keyPath = "transform.rotation"
        animation.duration = 4.0;
        animation.fromValue = 0.0;
        animation.toValue = 2 * M_PI;
        animation.repeatCount = Float.infinity
        progressLayer.addAnimation(animation, forKey: kMMRingRotationAnimationKey)
        
        var headAnimation = CABasicAnimation()
        headAnimation.keyPath = "strokeStart"
        headAnimation.duration = 1.0;
        headAnimation.fromValue = 0.0;
        headAnimation.toValue = 0.25;
        headAnimation.timingFunction = self.timingFunction;
        
        var tailAnimation = CABasicAnimation()
        tailAnimation.keyPath = "strokeEnd"
        tailAnimation.duration = 1.0
        tailAnimation.fromValue = 0.0
        tailAnimation.toValue = 1.0
        tailAnimation.timingFunction = self.timingFunction;
        
        
        var endHeadAnimation = CABasicAnimation()
        endHeadAnimation.keyPath = "strokeStart"
        endHeadAnimation.beginTime = 1.0
        endHeadAnimation.duration = 0.5
        endHeadAnimation.fromValue = 0.25
        endHeadAnimation.toValue = 1.0
        endHeadAnimation.timingFunction = self.timingFunction;
        
        var endTailAnimation = CABasicAnimation()
        endTailAnimation.keyPath = "strokeEnd"
        endTailAnimation.beginTime = 1.0
        endTailAnimation.duration = 0.5
        endTailAnimation.fromValue = 1.0
        endTailAnimation.toValue = 1.0
        endTailAnimation.timingFunction = self.timingFunction;
        
        var animations = CAAnimationGroup()
        animations.duration = 1.5
        animations.animations = [headAnimation, tailAnimation, endHeadAnimation, endTailAnimation]
        animations.repeatCount = Float.infinity
        progressLayer.addAnimation(animations, forKey: kMMRingStrokeAnimationKey)
        
        
        self.isAnimating = true
        
    }
    
    func stopAnimating(){
        
    }
    
    func progressLayerInit(){
        progressLayer = CAShapeLayer()
        progressLayer.strokeColor = UIColor.blueColor().CGColor
        progressLayer.fillColor = UIColor.clearColor().CGColor
        progressLayer.lineWidth = 1.5
        self.layer.addSublayer(progressLayer)
        self.updatePath()
    }
    
    func updatePath(){
        
        var center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds))

        var radius:CGFloat = min(CGRectGetWidth(self.bounds) / 2, (CGRectGetHeight(self.bounds) / 2) - self.progressLayer.lineWidth / 2)
        var startAngle:CGFloat = 0.0
        let endAngle:CGFloat = CGFloat(2*M_PI)
        
//        convenience init(arcCenter center: CGPoint, radius: CGFloat, startAngle: CGFloat, endAngle: CGFloat, clockwise: Bool)
        var path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true)
//        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
        //    self.progressLayer.path = path.CGPath;
        progressLayer.path = path.CGPath
        progressLayer.strokeStart = 0.0
        progressLayer.strokeEnd = 0.0
    }
    
//    - (void)updatePath {
//    CGPoint center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
//    CGFloat radius = MIN(CGRectGetWidth(self.bounds) / 2, CGRectGetHeight(self.bounds) / 2) - self.progressLayer.lineWidth / 2;
//    CGFloat startAngle = (CGFloat)(0);
//    CGFloat endAngle = (CGFloat)(2*M_PI);
//    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
//    self.progressLayer.path = path.CGPath;
//    
//    self.progressLayer.strokeStart = 0.f;
//    self.progressLayer.strokeEnd = 0.f;
//    }
//    - (CAShapeLayer *)progressLayer {
//    if (!_progressLayer) {
//    _progressLayer = [CAShapeLayer layer];
//    _progressLayer.strokeColor = self.tintColor.CGColor;
//    _progressLayer.fillColor = nil;
//    _progressLayer.lineWidth = 1.5f;
//    }
//    return _progressLayer;
//    }
}
