//
//  ViewController.swift
//  myMK
//
//  Created by D_ttang on 15/5/20.
//  Copyright (c) 2015年 D_ttang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showAction(sender: AnyObject) {
        
        let secondViewController = storyboard!.instantiateViewControllerWithIdentifier("SecondViewController") as! SecondViewController

        
        presentViewController(secondViewController, animated: false, completion: nil)
    }

}

