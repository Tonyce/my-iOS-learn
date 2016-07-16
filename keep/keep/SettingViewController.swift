//
//  SettingViewController.swift
//  keep
//
//  Created by D_ttang on 15/5/16.
//  Copyright (c) 2015年 D_ttang. All rights reserved.
//

import UIKit

@IBDesignable

class SettingViewController: UIViewController {

    @IBInspectable
//    @IBOutlet weak var tableView: UITableView!
    var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

//                self.hidesBottomBarWhenPushed = true
        // Do any additional setup after loading the view.
        
        self.tableView = UITableView(frame: CGRectMake(0, 0, self.view.frame.width, self.view.frame.height), style: UITableViewStyle.Grouped)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
    }
    
    override func viewWillDisappear(animated: Bool) {
//        self.tabBarController?.tabBar.hidden = true

    }

}

extension SettingViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }

    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "0"
        case 1:
            return "1"
        default:
            return "2"
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return 2
    }


    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            return 88
            
        } else if indexPath.section == 2 && indexPath.row == 2 {
            return 44
        } else {
            return 44
        }
    }

    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let identifier = "Cell"
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: identifier)
        
        cell.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
        
        cell.textLabel!.text =  "Cell"
        
//        cell.
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("tableSegue", sender: self)
//        println("didSelectRowAtIndexPath")
    }
    
//    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
//        if indexPath.section == 0 || indexPath.section == 1 {
//            return indexPath
//        } else {
//            return nil
//        }
//    }
    
//    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return 40
//    }
    
//    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//        return 40
//    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "tableSegue"{
            print("......")
            let controller = segue.destinationViewController as! SettingDetailViewController
        }
    }
    
}


