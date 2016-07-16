//
//  ViewController.swift
//  Hi
//
//  Created by D_ttang on 15/10/16.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var myWebView: UIWebView!
//    let meWebView = UIWebView()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let localfilePath = NSBundle.mainBundle().URLForResource("index", withExtension: "html");
        let myRequest = NSURLRequest(URL: localfilePath!);
        myWebView.loadRequest(myRequest);
        
        let jsCode = contentsOfFileWithName("preload")
        myWebView.stringByEvaluatingJavaScriptFromString(jsCode!);
//        let htmlTitle = myWebView.stringByEvaluatingJavaScriptFromString("document.title");
//        print(htmlTitle)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func contentsOfFileWithName(fileName: String) -> String? {
        guard let path = NSBundle.mainBundle().pathForResource(fileName, ofType: "js") else {
            return nil
        }
        
        do {
            let content = try String(contentsOfFile:path, encoding: NSUTF8StringEncoding)
            return content
        } catch _ as NSError {
            return nil
        }
    }

}

