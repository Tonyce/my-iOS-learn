//
//  ViewController.swift
//  mySliderView
//
//  Created by D_ttang on 15/2/7.
//  Copyright (c) 2015年 D_ttang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var viewOne : UIView!
    
    var viewTwo : UIView!
    
//    var swipeRecognizer: UISwipeGestureRecognizer!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        swipeRecognizer = UISwipeGestureRecognizer(target: self, action: "handleSwipes:")
    }
    
    
    //    label = UILabel(frame: CGRect(x: 20, y: 100, width: 100, height: 23))
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setupSwipeControls()
        
        let upSwipe = UISwipeGestureRecognizer(target: self, action: "handleSwipes:")
        upSwipe.numberOfTouchesRequired = 1
        upSwipe.direction = UISwipeGestureRecognizerDirection.Up
        view.addGestureRecognizer(upSwipe)
        
        let downSwipe = UISwipeGestureRecognizer(target: self, action: "handleSwipes:")
        downSwipe.numberOfTouchesRequired = 1
        downSwipe.direction = UISwipeGestureRecognizerDirection.Down
        view.addGestureRecognizer(downSwipe)
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: Selector("left:"))
        leftSwipe.numberOfTouchesRequired = 1
        leftSwipe.direction = UISwipeGestureRecognizerDirection.Left
        view.addGestureRecognizer(leftSwipe)

        let rightSwipe = UISwipeGestureRecognizer(target: self, action: Selector("right:"))
        rightSwipe.numberOfTouchesRequired = 1
        rightSwipe.direction = UISwipeGestureRecognizerDirection.Right
        view.addGestureRecognizer(rightSwipe)
        
        initView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
                // Dispose of any resources that can be recreated.
    }
    
    func initView() {
        viewOne = UIView(frame: view.bounds)
        viewOne.backgroundColor = UIColor.blueColor()
        view.addSubview(viewOne)
    }
    
    // Commands
    @objc(up:)
    func upCommand(r: UIGestureRecognizer!) {
        print("up...")
    }
    
    @objc(down:)
    func downCommand(r: UIGestureRecognizer!) {
        print("down...")
//        frame: CGRect(x: 20, y: 100, width: 100, height: 23)
    }
    
    @objc(left:)
    func leftCommand(r: UIGestureRecognizer!) {
        print("left...")
    }
    
    @objc(right:)
    func rightCommand(r: UIGestureRecognizer!) {
        print("right...")
    }
    
    func setupSwipeControls() {
        let upSwipe = UISwipeGestureRecognizer(target: self, action: Selector("up:"))
        upSwipe.numberOfTouchesRequired = 1
        upSwipe.direction = UISwipeGestureRecognizerDirection.Up
        view.addGestureRecognizer(upSwipe)
        
        let downSwipe = UISwipeGestureRecognizer(target: self, action: Selector("down:"))
        downSwipe.numberOfTouchesRequired = 1
        downSwipe.direction = UISwipeGestureRecognizerDirection.Down
        view.addGestureRecognizer(downSwipe)
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: Selector("left:"))
        leftSwipe.numberOfTouchesRequired = 1
        leftSwipe.direction = UISwipeGestureRecognizerDirection.Left
        view.addGestureRecognizer(leftSwipe)
        
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: Selector("right:"))
        rightSwipe.numberOfTouchesRequired = 1
        rightSwipe.direction = UISwipeGestureRecognizerDirection.Right
        view.addGestureRecognizer(rightSwipe)
    }
    
    func handleSwipes(sender: UISwipeGestureRecognizer){
            
        if sender.direction == .Down{
            print("Swiped Down")
            viewTwo = UIView(frame: CGRect(x: 20, y: 100, width: 100, height: 23))
            viewTwo.backgroundColor = UIColor.redColor()
            view.addSubview(viewTwo)
        }
        if sender.direction == .Left{
            print("Swiped Left")
        }
        if sender.direction == .Right{
            print("Swiped Right")
        }
        if sender.direction == .Up{
            print("Swiped Up")
        }
    }
    
}

