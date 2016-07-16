//
//  LoginTransitionDelegate.swift
//  myLogin
//
//  Created by D_ttang on 15/6/19.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit

class LoginTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return LoginTransitionAnimator()
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return LoginTransitionAnimatorDismiss()
    }
}
