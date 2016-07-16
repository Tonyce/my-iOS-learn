//
//  selfAnimator.swift
//  viewChange
//
//  Created by D_ttang on 15/6/17.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit

class MyAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration = 1.0
    var presenting = true
    var originFrame = CGRect.zeroRect
    
    var dismissCompletion : (() -> ())?
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval{
        return duration
    }
    
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning){
        let containerView = transitionContext.containerView()
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        
        let herbView = presenting ? toView : transitionContext.viewForKey(UITransitionContextFromViewKey)!
        
        let initialFrame = presenting ? originFrame : herbView.frame
        let finalFrame = presenting ? herbView.frame : originFrame
        
        let xScaleFactor = presenting ? initialFrame.width / finalFrame.width : finalFrame.width / initialFrame.width
        let yScaleFactor = presenting ? initialFrame.height / finalFrame.height : finalFrame.height / initialFrame.height
        
        let scaleTransform = CGAffineTransformMakeTranslation(xScaleFactor, yScaleFactor)
//        let scaleTransform = CGAffineTransformScale(
//            CGAffineTransformMakeTranslation(1,1),
////            lineRect.size.width/cardRect.size.width,
////            lineRect.size.height/cardRect.size.height
//            1,
//            1)
        
        if presenting {
            herbView.transform = scaleTransform
            herbView.center = CGPoint(x: CGRectGetMinX(initialFrame), y: CGRectGetMinY(initialFrame))
            herbView.clipsToBounds = true
        }
        
        containerView!.addSubview(toView)
        containerView!.bringSubviewToFront(herbView)
        
        UIView.animateWithDuration(duration,
            //            delay:0.0,
            //            usingSpringWithDamping: 0.4,
            //            initialSpringVelocity: 0.0,
            //            options: [],
            animations: {
                // herbView.transform = self.presenting ? CGAffineTransformIdentity : scaleTransform
                herbView.transform =  scaleTransform
                herbView.center = CGPoint(x: CGRectGetMidX(finalFrame), y: CGRectGetMidY(finalFrame))
            }, completion:{_ in
                
                //                if !self.presenting {
                //                    self.dismissCompletion?()
                //                }
                transitionContext.completeTransition(true)
        })
    }

        /*
        let bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        // Create CAShapeLayerS
        let rectShape = CAShapeLayer()
        rectShape.bounds = bounds
        rectShape.position = containerView!.center
        rectShape.cornerRadius = bounds.width / 2
        toView.layer.addSublayer(rectShape)
        
        // Apply effects here
        
        // fill with yellow
        rectShape.fillColor = UIColor.yellowColor().CGColor
        
        // 1
        // begin with a circle with a 50 points radius
        let startShape = UIBezierPath(roundedRect: bounds, cornerRadius: 50).CGPath
        // animation end with a large circle with 500 points radius
        let endShape = UIBezierPath(roundedRect: CGRect(x: -450, y: -450, width: 1000, height: 1000), cornerRadius: 500).CGPath
        
        // set initial shape
        rectShape.path = startShape
        
        // 2
        // animate the `path`
        let animation = CABasicAnimation(keyPath: "path")
        animation.toValue = endShape
        animation.duration = 1 // duration is 1 sec
        // 3
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut) // animation curve is Ease Out
        animation.fillMode = kCAFillModeBoth // keep to value after finishing
        animation.removedOnCompletion = false // don't remove after finishing
        // 4
        rectShape.addAnimation(animation, forKey: animation.keyPath)
        */
    /*
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView()
        
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        let fromView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        //        UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        //        UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        //        [[transitionContext containerView] addSubview:toViewController.view];
//        toView.alpha = 0
        
        let scaleTransform = CGAffineTransformMakeScale(1, 1)
        
        containerView!.addSubview(toView)
        containerView!.bringSubviewToFront(toView)
        
        UIView.animateWithDuration(duration, delay:0.0,
            usingSpringWithDamping: 0.4,
            initialSpringVelocity: 0.0,
            options: [],
            animations: {
                toView.transform = scaleTransform
//                toView.alpha = 1
                toView.center = CGPointMake(UIScreen.mainScreen().bounds.size.width / 2, UIScreen.mainScreen().bounds.size.height / 2 )
                
            }, completion:{_ in
                
                transitionContext.completeTransition(true)
        })
    }
*/

}
