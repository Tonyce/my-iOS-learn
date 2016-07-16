//
//  myCustomAlertViewController.swift
//  myCustomAlertView
//
//  Created by D_ttang on 14/12/27.
//  Copyright (c) 2014年 D_ttang. All rights reserved.
//

import UIKit

class myCustomAlertViewController : UIViewController {
    var transitioner : CAVTransitioner
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!) {
        self.transitioner = CAVTransitioner()
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.modalPresentationStyle = .Custom
        self.transitioningDelegate = self.transitioner
    }
    
    convenience init() {
//        super.init()
        self.init(nibName:"myCustomAlertView", bundle:nil)
    }
    
    required init(coder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    @IBAction func doDisMiss(sender: AnyObject) {
        println("okok")
        self.presentingViewController!.dismissViewControllerAnimated(true, completion: nil)
    }
}