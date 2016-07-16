//
//  InfoViewController.swift
//  myLogin
//
//  Created by D_ttang on 15/6/20.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {

    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var closeBtn: MyCloseButton!
    @IBOutlet weak var webView: UIWebView!
    
    var item: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        itemLabel.text = item
        // Do any additional setup after loading the view.
        initElements()
        
        let url = "https://www.baidu.com"
        
        //         let URL = NSURL.URLWithString("http://www.raywenderlich.com")
        let URL = NSURL(string:url)
        
        let request = NSURLRequest(URL:URL!)
        
        webView.loadRequest(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissAction(sender: UIButton) {
        dismissViewControllerAnimated(true, completion: nil)
    }

    func initElements(){
        closeBtn.frame.origin.y = view.frame.size.height - closeBtn.frame.height
        closeBtn.layer.cornerRadius = CGRectGetHeight(self.closeBtn.frame) / 2
        closeBtn.layer.masksToBounds = true
    }

}
