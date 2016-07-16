//
//  secondViewController.swift
//  myMK
//
//  Created by D_ttang on 15/5/21.
//  Copyright (c) 2015年 D_ttang. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.purpleColor()
        self.view.clipsToBounds = true
        // Do any additional setup after loading the view.
        
//        UIView.animateWithDuration(<#duration: NSTimeInterval#>, delay: NSTimeInterval, options: UIViewAnimationOptions, animations: <#() -> Void##() -> Void#>, completion: <#((Bool) -> Void)?##(Bool) -> Void#>)
        UIView.animateWithDuration(1.3, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {

            self.view.layer = CGAffineTransformMakeScale(1.0,1.0)
            
            }, completion:nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func doneAction(sender: AnyObject) {
        presentingViewController?.dismissViewControllerAnimated(false, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
