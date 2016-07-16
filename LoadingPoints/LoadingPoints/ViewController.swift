//
//  ViewController.swift
//  LoadingPoints
//
//  Created by D_ttang on 2016/6/22.
//  Copyright © 2016年 D_ttang. All rights reserved.
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

    override func viewDidAppear(animated: Bool) {
        let colors = [UIColor.redColor(), UIColor.blackColor(), UIColor.blueColor(), UIColor.cyanColor(),UIColor.grayColor(),UIColor.brownColor()]
        let pointsView = LoadingPointsView(colors: colors, frame: self.view.frame)
        pointsView.translatesAutoresizingMaskIntoConstraints = false
        pointsView.backgroundColor = UIColor.lightGrayColor()
        view.addSubview(pointsView)
        
        
        let top = NSLayoutConstraint(item: pointsView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0)
        view.addConstraint(top)
        
        let bottom = NSLayoutConstraint(item: pointsView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0)
        view.addConstraint(bottom)
        
        let trailing = NSLayoutConstraint(item: pointsView, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0)
        view.addConstraint(trailing)
        
        let leading = NSLayoutConstraint(item: pointsView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: view, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0)
        view.addConstraint(leading)
    }

}

