//
//  Transition.swift
//  myMaterialTransition
//
//  Created by D_ttang on 15/6/24.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit

let UIViewMaterialDesignTransitionDurationCoeff			= 0.65;

class Transition: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration    = 0.2
    var presenting  = true
    var originFrame = CGRectZero
    
    var topImageHeight:CGFloat = 0.0
    var dismissCompletion: (()->())?
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return duration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView()
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! ViewController
        let fromView = fromViewController.view
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        
        let shapeLayer = CAShapeLayer()
        let diameter:CGFloat = 20.0
        shapeLayer.frame = CGRectMake(CGFloat(100.0), CGFloat(100.0), diameter, diameter)
        shapeLayer.path = UIBezierPath(ovalInRect: CGRectMake(0.0, 0.0, diameter, diameter)).CGPath
        shapeLayer.fillColor = UIColor.blueColor().CGColor
        
        toView.layer.insertSublayer(shapeLayer, atIndex: 0)
        
        
        fromView.alpha = 0.5
        let finalFrame = toView.frame
        
        let scaleTransform = CGAffineTransformMakeScale(1, 0.5)
        
        let animation = CABasicAnimation(keyPath: "transform")

                //    animation.toValue = NSValue(CATransform3D: CATransform3DMakeScale(1.0, 1.0, 1.0))
                //    animation.fromValue = NSValue(CATransform3D: CATransform3DMakeScale(scale, scale, 1.0))

        animation.toValue = NSValue(CATransform3D: CATransform3DMakeScale(9.0, 2.0, 1.0))
        animation.fromValue = NSValue(CATransform3D:CATransform3DMakeScale(0.1, 1.0, 1.0))
    
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault);
        animation.removedOnCompletion = true;

        animation.duration = 3.0
        
        shapeLayer.transform = (animation.toValue?.CATransform3DValue)!
//        toView.transform = scaleTransform
//        toView.center = CGPoint(
//            x: CGRectGetMidX(finalFrame),
//            y: CGRectGetMidY(finalFrame))
        
        containerView!.addSubview(toView)
        
        CATransaction.begin()
        shapeLayer.addAnimation(animation, forKey: "shapeBackgroundAnimation")
        CATransaction.commit()
        
//        UIView.animateWithDuration(3,
//            animations: {
//
//                shapeLayer.transform = CGAffineTransformIdentity
//                toView.center = CGPoint(x: CGRectGetMidX(finalFrame), y: CGRectGetMidY(finalFrame))
//                
//            }, completion:{_ in
//                fromView.alpha = 1.0
//                transitionContext.completeTransition(true)
//        })
    }
    
}
//    func mdShapeLayerForAnimationAtPoint(point: CGPoint) -> CAShapeLayer {
//        let shapeLayer = CAShapeLayer()
//        let diameter = self.mdShapeDiameterForPoint(point)
//        shapeLayer.frame = CGRectMake(floor(point.x - diameter * 0.5), floor(point.y - diameter * 0.5), diameter, diameter)
//        shapeLayer.path = UIBezierPath(ovalInRect: CGRectMake(0.0, 0.0, diameter, diameter)).CGPath
//        return shapeLayer
//    }

//    func mdInflateAnimatedFromPoint(point: CGPoint, background: UIColor, duration: NSTimeInterval, completion: (()->Void)){
//        self.mdAnimateAtPoint(point, backgroundColor: backgroundColor!, duration: duration, inflating: true, zTopPosition: false, shapeLayer: nil, completion: completion)
//    }
//    
//    func mdDeflateAnimatedToPoint(point: CGPoint, backgroundColor: UIColor, duration: NSTimeInterval, completion: (()->Void)){
//        self.mdAnimateAtPoint(point, backgroundColor: backgroundColor, duration: duration, inflating: false, zTopPosition: false, shapeLayer: nil, completion: completion)
//    }
//    
//    
//    //MARK: - helpers
//    
//    func mdShapeDiameterForPoint(point: CGPoint) -> CGFloat {
//        var cornerPoints:[CGPoint] = [ CGPoint(x: 0.0, y: 0.0), CGPoint(x:0.0, y:self.bounds.size.height),
//            CGPoint(x:self.bounds.size.width, y:self.bounds.size.height), CGPoint(x:self.bounds.size.width, y:0.0)]
//        var radius:CGFloat = 0.0
//        for var i = 0; i < cornerPoints.count / sizeofValue(CGPoint); i++ {
//            let p = cornerPoints[i]
//            let d = sqrt( pow(p.x - point.x, 2.0) + pow(p.y - point.y, 2.0))
//            if d > radius {
//                radius = d
//            }
//        }
//        return radius * 2.0
//    }
//
//   
//    
//    func shapeAnimationWithTimingFunction(timingFunction: CAMediaTimingFunction, scale: CGFloat, inflating: Bool) -> CABasicAnimation {
//        let animation = CABasicAnimation(keyPath: "transform")
//        if inflating {
//            animation.toValue = NSValue(CATransform3D: CATransform3DMakeScale(1.0, 1.0, 1.0))
//            animation.fromValue = NSValue(CATransform3D: CATransform3DMakeScale(scale, scale, 1.0))
//        } else {
//            animation.toValue = NSValue(CATransform3D: CATransform3DMakeScale(scale, scale, 1.0))
//            animation.fromValue = NSValue(CATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0))
//        }
//        animation.timingFunction = timingFunction;
//        animation.removedOnCompletion = true;
//        return animation;
//    }

    //MARK: - animation
//    
//    func mdAnimateAtPoint(point: CGPoint, backgroundColor: UIColor, duration: NSTimeInterval, inflating: Bool, zTopPosition: Bool, var shapeLayer: CAShapeLayer?, completion: (()-> Void)){
//        
//        if shapeLayer == nil {
//            shapeLayer = self.mdShapeLayerForAnimationAtPoint(point)
//            self.layer.masksToBounds = true
//            if zTopPosition {
//                self.layer.addSublayer(shapeLayer!)
//            }else {
//                self.layer.insertSublayer(shapeLayer!, atIndex: 0)
//            }
//            
//            if inflating {
//                shapeLayer?.fillColor = self.backgroundColor!.CGColor
//                self.backgroundColor = backgroundColor
//            }else {
//                shapeLayer?.fillColor = backgroundColor.CGColor
//            }
//        }
//        
//        let scale = 1.0 / (shapeLayer?.frame.size.width)!
//        let timingFunctionName = kCAMediaTimingFunctionDefault
//        let animation:CABasicAnimation = self.shapeAnimationWithTimingFunction(CAMediaTimingFunction(name:timingFunctionName), scale: scale, inflating: inflating)
//        animation.duration = duration
//        shapeLayer?.transform = (animation.toValue?.CATransform3DValue)!
//        
//        CATransaction.begin();
//        CATransaction.setCompletionBlock({
//            _ in
//            if inflating {
//                self.backgroundColor = backgroundColor
//            }
//            
//            shapeLayer?.removeFromSuperlayer()
//            shapeLayer?.addAnimation(animation, forKey: "shapeBackgroundAnimation")
//            
//            completion()
//        })
//        
//        CATransaction.commit()
//    }
//}
