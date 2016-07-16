//
//  ViewController.swift
//  LoadWeb
//
//  Created by D_ttang on 15/10/16.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var myWebView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
//        let myWebView = UIWebView()
        let localfilePath = NSBundle.mainBundle().URLForResource("index", withExtension: "html");
        let myRequest = NSURLRequest(URL: localfilePath!);
        myWebView.loadRequest(myRequest);
        
        let htmlTitle = myWebView.stringByEvaluatingJavaScriptFromString("document.title");
        print(htmlTitle)
        
//        view.addSubview(myWebView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

/*
//
//  ViewController.swift
//  LoadWeb
//
//  Created by D_ttang on 15/10/16.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit
import Foundation

protocol JavascriptObjectDelegate {
func call( action: String, callback: String, data: String )
}

class ViewController: UIViewController {

let stepOne = "function mainUrl (content) {var idea = getMainIdea(content);var urls = getMatchUrls(idea);console.log(\"content: \", urls)}"


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

override func viewDidLoad() {
super.viewDidLoad()
// Do any additional setup after loading the view, typically from a nib.


let myWebView = UIWebView()

//        let jsCode = contentsOfFileWithName("preload")

myWebView.stringByEvaluatingJavaScriptFromString("window.open('ios://fdskfl')");


}


override func didReceiveMemoryWarning() {
super.didReceiveMemoryWarning()
// Dispose of any resources that can be recreated.
}


}

extension ViewController: UIWebViewDelegate {
func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
let url = request.URL!.absoluteString

print("捕获到链接："+url);

if(url.hasPrefix("ios://")){

let a = (url as NSString).substringFromIndex(6)

print("动作："+a);

//根据动作编写相应的swift代码。

return false;

}

return true;
}
}

//
//  ViewController.swift
//  LoadWeb
//
//  Created by D_ttang on 15/10/16.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit
import Foundation

protocol JavascriptObjectDelegate {
func call( action: String, callback: String, data: String )
}

class ViewController: UIViewController {

let stepOne = "function mainUrl (content) {var idea = getMainIdea(content);var urls = getMatchUrls(idea);console.log(\"content: \", urls)}"


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

override func viewDidLoad() {
super.viewDidLoad()
// Do any additional setup after loading the view, typically from a nib.


let myWebView = UIWebView()

//        let jsCode = contentsOfFileWithName("preload")

myWebView.stringByEvaluatingJavaScriptFromString("window.open('ios://fdskfl')");


}


override func didReceiveMemoryWarning() {
super.didReceiveMemoryWarning()
// Dispose of any resources that can be recreated.
}


}

extension ViewController: UIWebViewDelegate {
func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
let url = request.URL!.absoluteString

print("捕获到链接："+url);

if(url.hasPrefix("ios://")){

let a = (url as NSString).substringFromIndex(6)

print("动作："+a);

//根据动作编写相应的swift代码。

return false;

}

return true;
}
}


*/

