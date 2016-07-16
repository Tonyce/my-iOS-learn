//
//  ViewController.swift
//  myTableView
//
//  Created by D_ttang on 14/12/28.
//  Copyright (c) 2014年 D_ttang. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {
    
    @IBOutlet var tableView: UITableView!
    var items = ["one", "two", "three"]
    let transition = WethearClip()
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.navigationController!.delegate = self;
        print("viewDidLoad...")
        // Do any additional setup after loading the view, typically from a nib.
        self.title = "my test"
        self.tableView.tableFooterView = UIView() //去tableView空白
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if let selectedIndexPath = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRowAtIndexPath(selectedIndexPath, animated: true)
        }
        self.navigationItem.leftBarButtonItem = self.editButtonItem()
    }
    override func setEditing(editing: Bool, animated: Bool)  {
        super.setEditing(editing, animated: animated)
        self.tableView.setEditing(editing, animated: animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension TableViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        let term = self.items[indexPath.row]
        cell.textLabel?.text = "\(term)"
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            print(".delete")
//            self.searches.removeAtIndex(indexPath.row)
//            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
    
    /*
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                print("showDetail...\(indexPath.row)")
                let item = self.items[indexPath.row]
                segue.destinationViewController.transitioningDelegate = self
                (segue.destinationViewController as! DetailViewController).item = item
            }
        }
    }
*/
}

/*
extension TableViewController: UIViewControllerTransitioningDelegate{
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if let selectIndexPath = self.tableView.indexPathForSelectedRow {
            // let tmpOriginFrame = (self.mainTable.cellForRowAtIndexPath(selectIndexPath)?.frame)!
            let rectOfCellInTableView = self.tableView.rectForRowAtIndexPath(selectIndexPath)
            let tmpOriginFrame = self.tableView.convertRect(rectOfCellInTableView, toView: self.tableView.superview)
            transition.originFrame = CGRectMake(tmpOriginFrame.origin.x, tmpOriginFrame.origin.y,
                tmpOriginFrame.size.width, tmpOriginFrame.size.height)
            transition.presenting = true
        }
        return transition
        
    }
}

extension TableViewController: UINavigationControllerDelegate{
    
    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        
        if operation == UINavigationControllerOperation.Push {
            
            if let selectIndexPath = self.tableView.indexPathForSelectedRow {
                // let tmpOriginFrame = (self.mainTable.cellForRowAtIndexPath(selectIndexPath)?.frame)!
                let rectOfCellInTableView = self.tableView.rectForRowAtIndexPath(selectIndexPath)
                let tmpOriginFrame = self.tableView.convertRect(rectOfCellInTableView, toView: self.tableView.superview)
                transition.selectIndexPath = selectIndexPath
                transition.originFrame = CGRectMake(tmpOriginFrame.origin.x, tmpOriginFrame.origin.y,
                    tmpOriginFrame.size.width, tmpOriginFrame.size.height)
                transition.presenting = true
            }
            return transition
        }else {
            return nil
        }
    }
    
}

*/