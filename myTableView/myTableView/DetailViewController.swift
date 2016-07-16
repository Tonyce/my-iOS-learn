//
//  DetailView.swift
//  myTableView
//
//  Created by D_ttang on 14/12/28.
//  Copyright (c) 2014年 D_ttang. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var item: String?
    
    @IBOutlet weak var itemLable: UILabel!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        if let showItem = item {
            itemLable.text = item
        }
    }
}
