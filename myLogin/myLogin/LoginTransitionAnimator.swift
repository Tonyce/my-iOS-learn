//
//  LoginAnimator.swift
//  myLogin
//
//  Created by D_ttang on 15/6/19.
//  Copyright © 2015年 D_ttang. All rights reserved.
//
import UIKit

class LoginTransitionAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    var transitionContext: UIViewControllerContextTransitioning?
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 1
    }
    
    /**
    With masking transition
    */
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        self.transitionContext = transitionContext
        
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! LoginViewController
        let fromView = fromViewController.view //from view
        let toController: UIViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)!
        let toView = toController.view
    
//        toView.alpha = 0.0
        let containerView = transitionContext.containerView()
        
        containerView!.addSubview(toView)
        var shapeLayer = CAShapeLayer()
        var diameter:CGFloat = 1360
        shapeLayer.frame = CGRectMake(0, 0, 500, 500)
        shapeLayer.path = UIBezierPath(ovalInRect: CGRectMake(-100, -150, 600, 600)).CGPath
        shapeLayer.fillColor = UIColor.redColor().CGColor
        containerView?.layer.addSublayer(shapeLayer)

        
        UIView.animateWithDuration(1, animations: {

                    var animation = CABasicAnimation(keyPath: "transform")
                    animation.toValue = NSValue(CATransform3D: CATransform3DMakeScale(1.0, 1.0, 1.0))
                    animation.fromValue = NSValue(CATransform3D: CATransform3DMakeScale(0.1, 0.1, 1.0))
//                    animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
                    animation.removedOnCompletion = true
            
                    animation.duration = 0.31;
            
                    shapeLayer.addAnimation(animation, forKey:"shapeBackgroundAnimation")
            
            
            }, completion: {
                _ in
//                toView.alpha = 1.0
                shapeLayer.removeFromSuperlayer()
                transitionContext.completeTransition(true)
        })

    }
}
