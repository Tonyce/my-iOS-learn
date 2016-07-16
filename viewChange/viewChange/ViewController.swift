//
//  ViewController.swift
//  viewChange
//
//  Created by D_ttang on 15/6/17.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // let transition = PopAnimator()
    let transition = MyAnimator()
    var fromFrame = CGRect.zeroRect
    
    @IBOutlet weak var btn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillDisappear(animated: Bool) {
//        layerAnimation()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func goNext(sender: UIButton) {
        fromFrame = sender.frame
        let SecondView = storyboard!.instantiateViewControllerWithIdentifier("SecondViewController") as! SecondViewController
        SecondView.transitioningDelegate = self
        presentViewController(SecondView, animated: true, completion: nil)
    }
}

extension ViewController: UIViewControllerTransitioningDelegate {
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        transition.originFrame = fromFrame
        transition.presenting = true
//        selectedImage!.hidden = true
//        
        return transition
    }

//    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//        transition.presenting = false
//        return transition
//    }
    
    func layerAnimation(){
        let bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
        
        // Create CAShapeLayerS
        let rectShape = CAShapeLayer()
        rectShape.bounds = bounds
        rectShape.position = view.center
        rectShape.cornerRadius = bounds.width / 2
        view.layer.addSublayer(rectShape)
        
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
    }

}

