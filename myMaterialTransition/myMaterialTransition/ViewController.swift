//
//  ViewController.swift
//  myMaterialTransition
//
//  Created by D_ttang on 15/6/24.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let transition = Transition()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        segue.destinationViewController.transitioningDelegate = self
        
        /*
        let SecondView = storyboard!.instantiateViewControllerWithIdentifier("SecondViewController") as! SecondViewController
        SecondView.transitioningDelegate = self
        presentViewController(SecondView, animated: true, completion: nil)
        */
    }

    

}

extension ViewController: UIViewControllerTransitioningDelegate {
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        transition.presenting = true
        return transition
        
    }
}

