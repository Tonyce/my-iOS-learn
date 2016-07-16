//
//  ViewController.swift
//  keep
//
//  Created by D_ttang on 15/5/16.
//  Copyright (c) 2015年 D_ttang. All rights reserved.
//

import UIKit

class FriendsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let myScrollView = TwitterScroll(backgroundImage: UIImage(named: "background")!, avatarImage: UIImage(named: "avatar")!, titleString: "MainTitle", height: 0, type: .Table)
        
        myScrollView.tableView.delegate = self
        myScrollView.tableView.dataSource = self
        
        self.view.addSubview(myScrollView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension FriendsViewController:UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let identifier = "Cell"
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: identifier)
        cell.textLabel!.text =  "Cell";
        
        return cell;
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        var currentPoint = scrollView.contentOffset.y
//        if currentPoint - preventPoint>20&&currentPoint!=0{
//            
//            preventPoint=currentPoint;
//            
////            NSLog(@"下滑");
//            
//            self.tabBarController.tabBar.hidden=YES;
//            
//        }elseif((preventPoint-currentPoint>20)&&(currentPoint  <=scrollView.contentSize.height-scrollView.bounds.size.height-20)){
//            
//            preventPoint=currentPoint;
//            
//            NSLog(@"上滑");
//            
//            self.tabBarController.tabBar.hidden=NO;
//            
//        }
//        if currentPoint > 0 {
//            self.tabBarController!.tabBar.frame.origin.y += 100
//        }else {
//            self.tabBarController!.tabBar.frame.origin.y -= 100
//        }

    }
}

// a param to describe the state change, and an animated flag
// optionally add a completion block which matches UIView animation
//- (void)setTabBarVisible:(BOOL)visible animated:(BOOL)animated {
//    
//    // bail if the current state matches the desired state
//    if ([self tabBarIsVisible] == visible) return;
//    
//    // get a frame calculation ready
//    CGRect frame = self.tabBarController.tabBar.frame;
//    CGFloat height = frame.size.height;
//    CGFloat offsetY = (visible)? -height : height;
//    
//    // zero duration means no animation
//    CGFloat duration = (animated)? 0.3 : 0.0;
//    
//    [UIView animateWithDuration:duration animations:^{
//    self.tabBarController.tabBar.frame = CGRectOffset(frame, 0, offsetY);
//    }];
//    }
//    
//    // know the current state
//    - (BOOL)tabBarIsVisible {
//        return self.tabBarController.tabBar.frame.origin.y < CGRectGetMaxY(self.view.frame);
//        }
//        
//        
//        // illustration of a call to toggle current state
//        - (IBAction)pressedButton:(id)sender {
//            
//            [self setTabBarVisible:![self tabBarIsVisible] animated:YES];
//}

