//
//  ViewController.swift
//  myCustomAlertView
//
//  Created by D_ttang on 14/12/27.
//  Copyright (c) 2014年 D_ttang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var buttonAction: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showAlertView(sender: AnyObject) {
        println("i was been click")
        var vc = myCustomAlertViewController()
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
}

