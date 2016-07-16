//
//  LoginTransitionAnimatorDismiss.swift
//  myLogin
//
//  Created by D_ttang on 15/6/19.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit

class LoginTransitionAnimatorDismiss: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 0.5
    }
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        _ = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey) as! MainViewController
        let destinationController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)! as! LoginViewController
        
        let containerView = transitionContext.containerView()! as UIView
        
        destinationController.view.alpha = 0.0
        containerView.addSubview(destinationController.view)
        
        UIView.animateWithDuration(transitionDuration(transitionContext), animations: { () -> Void in
            destinationController.view.alpha = 1.0
            }) { (finished) -> Void in
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled())
        }
    }
}
