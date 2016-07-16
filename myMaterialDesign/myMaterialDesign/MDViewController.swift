//
//  MDViewController.swift
//  myMaterialDesign
//
//  Created by D_ttang on 15/5/19.
//  Copyright (c) 2015年 D_ttang. All rights reserved.
//

import UIKit

class MDViewController: UIViewController {

    var viewOne: MDViewOne!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
//        _viewOne = [[MDViewOne alloc] initWithFrame:self.view.bounds];
//        [self.viewOne.detailsButton addTarget:self action:@selector(showDetailsAction:event:) forControlEvents:UIControlEventTouchUpInside];
//        [self.view addSubview:self.viewOne];
        
        viewOne = MDViewOne(frame: self.view.bounds)
        self.viewOne.detailsButton.addTarget(self, action: Selector("showDetailsAction:event:"), forControlEvents:UIControlEvents.TouchUpInside)
        self.view.addSubview(viewOne)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc private func showDetailsAction(sender:UIButton, event:UIEvent ) {
        print("ooo")
//    CGPoint exactTouchPosition = [[[event allTouches] anyObject] locationInView:self.viewOne];
//    [UIView mdInflateTransitionFromView:self.viewOne toView:self.viewTwo originalPoint:exactTouchPosition duration:0.7 completion:nil];
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
