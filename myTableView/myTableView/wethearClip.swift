//
//  wethearClip.swift
//  myTableView
//
//  Created by D_ttang on 15/6/26.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit

class WethearClip: NSObject, UIViewControllerAnimatedTransitioning {
    
    let duration    = 0.5
    var presenting  = true
    var originFrame = CGRect.zero
    var selectIndexPath: NSIndexPath!
    
    var topImageHeight:CGFloat = 0.0
    var dismissCompletion: (()->())?
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return duration
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView()
        
        let fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! TableViewController
        let fromView = fromViewController.view
//        fromView.alpha = 0.5
        
        let toView = transitionContext.viewForKey(UITransitionContextToViewKey)!
        
        let herbView = presenting ? toView : transitionContext.viewForKey(UITransitionContextFromViewKey)!
        
        let initialFrame = presenting ? originFrame : herbView.frame
        let finalFrame = presenting ? herbView.frame : originFrame
        
        //        let xScaleFactor = presenting ? initialFrame.width / finalFrame.width : finalFrame.width / initialFrame.width
        
        let yScaleFactor = presenting ? initialFrame.height / finalFrame.height : finalFrame.height / initialFrame.height
        
        //        let scaleTransform = CGAffineTransformMakeScale(xScaleFactor, yScaleFactor)
        let scaleTransform = CGAffineTransformMakeScale(1, yScaleFactor)
        
        if presenting {
            
            herbView.transform = scaleTransform
            herbView.center = CGPoint(
                x: CGRectGetMidX(initialFrame),
                y: CGRectGetMidY(initialFrame))
            herbView.clipsToBounds = true
        }
        
        containerView!.addSubview(toView)
        containerView!.bringSubviewToFront(herbView)
        
        UIView.animateWithDuration(duration,
            animations: {

                fromViewController.tableView.cellForRowAtIndexPath(self.selectIndexPath)?.transform = scaleTransform
                
                herbView.transform = self.presenting ? CGAffineTransformIdentity : scaleTransform
                herbView.center = CGPoint(x: CGRectGetMidX(finalFrame), y: CGRectGetMidY(finalFrame))
                
            }, completion:{_ in
                
                if !self.presenting {
                    self.dismissCompletion?()
                }
                transitionContext.completeTransition(true)
        })
        
        
    }
    
}