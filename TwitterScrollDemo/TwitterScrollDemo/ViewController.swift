//
//  ViewController.swift
//  TwitterScrollDemo
//
//  Created by D_ttang on 15/5/13.
//  Copyright (c) 2015年 D_ttang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
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

extension ViewController:UITableViewDelegate, UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let identifier = "Cell"
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: identifier)
        cell.textLabel!.text =  "Cell";
        
        return cell;
    }
}

