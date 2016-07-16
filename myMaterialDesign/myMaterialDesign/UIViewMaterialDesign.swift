//
//  UIViewMaterialDesign.swift
//  myMaterialDesign
//
//  Created by D_ttang on 15/5/19.
//  Copyright (c) 2015年 D_ttang. All rights reserved.
//

import UIKit

protocol MaterialDesign {

    func mdInflateAnimatedFromPoint(point: CGPoint, backgroundColor: UIColor, duration: NSTimeInterval, completion: ()->())
    func mdDeflateAnimatedToPoint(point: CGPoint, backgroundColor: UIColor, duration: NSTimeInterval, completion: ()->())
    
    func mdInflateTransitionFromView(view: UIView, toView: UIView, originalPoint: CGPoint, duration: NSTimeInterval, completion: ()->())
    func mdDeflateTransitionFromView(view: UIView, toView: UIView, originalPoint: CGPoint, duration: NSTimeInterval, completion: ()->())
    

}

let UIViewMaterialDesignTransitionDurationCoeff:Double = 0.65
extension UIView: MaterialDesign {
    func mdInflateAnimatedFromPoint(point: CGPoint, backgroundColor: UIColor, duration: NSTimeInterval, completion: ()->()){
        self.mdAnimateAtPoint(point, backgroundColor: backgroundColor, duration: duration, inflating: true, zTopPosition: false, shapeLayer: nil, completion: completion)
    }
    
    func mdDeflateAnimatedToPoint(point: CGPoint, backgroundColor: UIColor, duration: NSTimeInterval, completion: ()->()){
        self.mdAnimateAtPoint(point, backgroundColor: backgroundColor, duration: duration, inflating: false, zTopPosition: false, shapeLayer: nil, completion: completion)
    }
    
    func mdInflateTransitionFromView(view: UIView, toView: UIView, originalPoint: CGPoint, duration: NSTimeInterval, completion: ()->()){
        
        if let _containerView: UIView = view.superview {
            let containerView = _containerView;
            let convertedPoint: CGPoint = view.convertPoint(originalPoint, fromView: view)
            containerView.layer.masksToBounds = true

            var finished: Bool
            containerView.mdAnimateAtPoint(convertedPoint,
                      backgroundColor: toView.backgroundColor!,
                             duration: duration * Double(UIViewMaterialDesignTransitionDurationCoeff),
                            inflating: true,
                         zTopPosition: true,
                            shapeLayer: nil,
                            completion: {
                                toView.alpha = 0.0;
                                toView.frame = view.frame
                                containerView.addSubview(toView)
                                view.removeFromSuperview()
                                
                                let animationDuration:NSTimeInterval = (duration - duration * Double(UIViewMaterialDesignTransitionDurationCoeff))
                                
                                UIView.animateWithDuration(animationDuration,
                                    animations: {
                                        toView.alpha = 1.0
                                    }, completion: {
                                        _ in
                                        completion()
                                })
            })
        }else{
            completion()
        }
    }
    
    func mdDeflateTransitionFromView(view: UIView, toView: UIView, originalPoint: CGPoint, duration: NSTimeInterval, completion: ()->()){
        
        if let _containerView = view.superview {
            let containerView = _containerView
            containerView.insertSubview(toView, belowSubview: view)
            toView.frame = view.frame
            
            let convertedPoint: CGPoint = toView.convertPoint(originalPoint, fromView: view)
            
            let layer: CAShapeLayer = toView.mdShapeLayerForAnimationAtPoint(convertedPoint)
            layer.fillColor = view.backgroundColor!.CGColor
            
            toView.layer.addSublayer(layer)
            toView.layer.masksToBounds = true
            
            let animationDuration: NSTimeInterval = duration - duration * UIViewMaterialDesignTransitionDurationCoeff
            
            UIView.animateWithDuration(animationDuration,
                animations: {
                    view.alpha = 0.0
                },
                completion:{
                        _ in
                    toView.mdAnimateAtPoint(convertedPoint, backgroundColor: view.backgroundColor!, duration: duration * UIViewMaterialDesignTransitionDurationCoeff, inflating: false, zTopPosition: true, shapeLayer: nil, completion: {
                            completion()
                    })
            })
            
        } else {
            completion()
        }
        
    }

}

extension UIView {
    func mdAnimateAtPoint(point: CGPoint, backgroundColor: UIColor, duration: NSTimeInterval, inflating: Bool, zTopPosition: Bool, shapeLayer: CAShapeLayer?, completion: () -> ()){
        var _shapeLayer : CAShapeLayer!
        if let shapeLayer = shapeLayer {
            _shapeLayer = shapeLayer
        }else {
            _shapeLayer = self.mdShapeLayerForAnimationAtPoint(point)
            self.layer.masksToBounds = true
            if (zTopPosition) {
                self.layer.addSublayer(shapeLayer!)
            } else {
                self.layer.insertSublayer(shapeLayer!, atIndex: 0)
            }
            
            if (!inflating) {
                _shapeLayer.fillColor = self.backgroundColor!.CGColor
                self.backgroundColor = backgroundColor
            } else {
                _shapeLayer.fillColor = backgroundColor.CGColor
            }
        }
        
        // animate
        var scale:CGFloat = 1.0 / _shapeLayer!.frame.size.width;
        var timingFunctionName: NSString  = kCAMediaTimingFunctionDefault; //inflating ? kCAMediaTimingFunctionDefault : kCAMediaTimingFunctionDefault;
        var animation: CABasicAnimation = self.shapeAnimationWithTimingFunction(CAMediaTimingFunction(name:timingFunctionName as String), scale: scale, inflating: inflating)
        animation.duration = duration
        _shapeLayer!.transform = CATransform3DIdentity
        CATransaction.begin()
        
        CATransaction.setCompletionBlock({
            if (inflating) {
                self.backgroundColor = backgroundColor;
            }
            _shapeLayer!.removeFromSuperlayer()
            
            completion()
        })
        _shapeLayer!.addAnimation(animation, forKey: "shapeBackgroundAnimation")
        CATransaction.commit()
    }
    
    func mdShapeLayerForAnimationAtPoint(point:CGPoint) -> CAShapeLayer {
        let shapeLayer: CAShapeLayer = CAShapeLayer()
        let diameter: CGFloat = self.mdShapeDiameterForPoint(point)
        
        shapeLayer.frame = CGRectMake(floor(point.x - diameter * 0.5), floor(point.y - diameter * 0.5), diameter, diameter);
        shapeLayer.path = UIBezierPath(ovalInRect: CGRectMake(0.0, 0.0, diameter, diameter)).CGPath
        return shapeLayer
    }
    
    func mdShapeDiameterForPoint(point: CGPoint) -> CGFloat {
        var cornerPoints: [CGPoint] = [ CGPoint(x: 0.0, y: 0.0), CGPoint(x:0.0, y: self.bounds.size.height), CGPoint(x:self.bounds.size.width, y: self.bounds.size.height), CGPoint(x:self.bounds.size.width, y: 0.0) ]
        var radius: CGFloat  = 0.0
        for var i = 0; i < cornerPoints.count / sizeof(CGPoint); i++ {
            let p:CGPoint = cornerPoints[i]
            let d:CGFloat = sqrt( pow(p.x - point.x, 2.0) + pow(p.y - point.y, 2.0))
            if d > radius {
                radius = d
            }
        }
        return radius * 2.0;
    }
    
    func shapeAnimationWithTimingFunction(timingFunction: CAMediaTimingFunction, scale: CGFloat, inflating: Bool) -> CABasicAnimation{
        var animation: CABasicAnimation!
        animation = CABasicAnimation(keyPath: "transform")
        if inflating {
            animation.toValue = NSValue(CATransform3D: CATransform3DMakeScale(1.0, 1.0, 1.0))
            animation.fromValue = NSValue(CATransform3D: CATransform3DMakeScale(scale, scale , 1.0))
        } else {
            animation.toValue = NSValue(CATransform3D: CATransform3DMakeScale(scale, scale, 1.0))
                animation.fromValue = NSValue(CATransform3D: CATransform3DMakeScale(1.0, 1.0, 1.0))
        }
        animation.timingFunction = timingFunction
        animation.removedOnCompletion = true
        return animation
    }
    
}
