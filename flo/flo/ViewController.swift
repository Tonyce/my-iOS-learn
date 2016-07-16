//
//  ViewController.swift
//  flo
//
//  Created by D_ttang on 15/5/6.
//  Copyright (c) 2015年 D_ttang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var counterView: CounterView!
    @IBOutlet weak var counterLabel: UILabel!
    
    var isGraphViewShowing = false
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var graphView: GraphView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        counterLabel.text = String(counterView.counter)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnPushButton(button: PushButtonView){
        if( button.isAddButton ){
            counterView.counter < 8 ? counterView.counter++ : counterView.counter
        } else {
            if counterView.counter > 0 {
                counterView.counter--
            }
        }
        counterLabel.text = String(counterView.counter)
        
        if isGraphViewShowing {
            counterViewTap(nil)
        }
    }
    
    @IBAction func counterViewTap(gesture: UITapGestureRecognizer?){
        // println("taped")
        if isGraphViewShowing {
            UIView.transitionFromView(graphView, toView: counterView, duration: 0.8, options: [UIViewAnimationOptions.TransitionFlipFromLeft, UIViewAnimationOptions.ShowHideTransitionViews], completion: nil)
        } else {
            UIView.transitionFromView(counterView, toView: graphView, duration: 0.5, options: [UIViewAnimationOptions.TransitionFlipFromRight, UIViewAnimationOptions.ShowHideTransitionViews], completion: nil)
        }
        isGraphViewShowing = !isGraphViewShowing
    }

}

