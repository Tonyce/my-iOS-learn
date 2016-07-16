//
//  DetailViewController.swift
//  nodejs
//
//  Created by D_ttang on 15/1/4.
//  Copyright (c) 2015年 D_ttang. All rights reserved.
//

import UIKit


class DetailViewController: UIViewController, UIApplicationDelegate {
    
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    @IBOutlet weak var stability: UILabel!
    @IBOutlet weak var desc: UITextView!
    var showTitle:String?
    //    var detailItem: Docs.IndexDoc?
    var detailItem: Docs.IndexDoc? {
        didSet {
            // Update the view.
            print("didSet")
            self.configureView()
        }
    }
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail: Docs.IndexDoc = self.detailItem {
            self.title = detail.text
            requestNetToGetData(detail.jsonPre!)
        }
    }
    
    func requestNetToGetData(modulePre: String){
        let urlStr = "http://nodejs.org/api/\(modulePre).json"
        HttpHelp.requestFromNet(urlStr){
            switch ($0) {
            case .Error:
                break
            case .Result(let result):
                print("\(result)")
                if let json = JSONValue.fromObject(result) {
                    self.stability?.text = json["modules"]?[0]?["stabilityText"]?.string
                    self.desc?.text = json["modules"]?[0]?["desc"]?.string
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

