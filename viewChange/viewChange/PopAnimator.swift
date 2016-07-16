//
//  PopAnimation.swift
//  viewChange
//
//  Created by D_ttang on 15/6/17.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit

class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    let duration = 1.0
    var presenting = true
    var originFrame = CGRect.zeroRect
    
    var dismissCompletion : (() -> ())?
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return duration
    }
    
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView()
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        
        let herbView = presenting ? toView : transitionContext.viewForKey(UITransitionContextFromViewKey)!
        
        let initialFrame = presenting ? originFrame : herbView.frame
        let finalFrame = presenting ? herbView.frame : originFrame
        
        let xScaleFactor = presenting ? initialFrame.width / finalFrame.width : finalFrame.width / initialFrame.width
        let yScaleFactor = presenting ? initialFrame.height / finalFrame.height : finalFrame.height / initialFrame.height
        
        let scaleTransform = CGAffineTransformMakeScale(xScaleFactor, yScaleFactor)
        
        if presenting {
            herbView.transform = scaleTransform
            herbView.center = CGPoint(x: CGRectGetMinX(initialFrame), y: CGRectGetMinY(initialFrame))
            herbView.clipsToBounds = true
        }
        
        containerView!.addSubview(toView)
        containerView!.bringSubviewToFront(herbView)
        
        UIView.animateWithDuration(duration, delay:0.0,
            usingSpringWithDamping: 0.4,
            initialSpringVelocity: 0.0,
            options: [],
            animations: {
                herbView.transform = self.presenting ? CGAffineTransformIdentity : scaleTransform
                herbView.center = CGPoint(x: CGRectGetMidX(finalFrame), y: CGRectGetMidY(finalFrame))
            }, completion:{_ in
                
                if !self.presenting {
                    self.dismissCompletion?()
                }
                transitionContext.completeTransition(true)
        })
    }
    /*
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
    let containerView = transitionContext.containerView()
    
    let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
    let fromView = transitionContext.viewForKey(UITransitionContextToViewKey)!
    //        UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    //        UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    //        [[transitionContext containerView] addSubview:toViewController.view];
    toView.alpha = 0
    
    let scaleTransform = CGAffineTransformMakeScale(5, 5)
    
    containerView!.addSubview(toView)
    containerView!.bringSubviewToFront(toView)
    
    UIView.animateWithDuration(duration, delay:0.0,
    usingSpringWithDamping: 0.4,
    initialSpringVelocity: 0.0,
    options: [],
    animations: {
    toView.transform = scaleTransform
    toView.alpha = 1
    toView.center = CGPointMake(UIScreen.mainScreen().bounds.size.width / 2, UIScreen.mainScreen().bounds.size.height / 2 )
    
    }, completion:{_ in
    
    transitionContext.completeTransition(true)
    })
    }
    */
}
