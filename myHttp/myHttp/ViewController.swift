//
//  ViewController.swift
//  myHttp
//
//  Created by D_ttang on 15/5/6.
//  Copyright (c) 2015年 D_ttang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let httpHelper = HTTPHelper()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        makeRequest()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func makeRequest(){
     
        let httpRequest = httpHelper.buildRequest("test", method: "POST")
        httpRequest.HTTPBody = "{\"full_name\":\"userName\",\"email\": \"email\",\"password\":\"password\"}".dataUsingEncoding(NSUTF8StringEncoding)
        
        httpHelper.sendRequest(httpRequest) { (data:NSData!, error:NSError!) in
            
            if error != nil {
                let errorMessage = self.httpHelper.getErrorMessage(error)
                
                print("\(errorMessage)")
                return
            }
            
            var jsonerror:NSError?
            let responseDict = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error:&jsonerror) as NSDictionary
            
            responseDict.enumerateKeysAndObjectsUsingBlock({ (dictKey, dictObj, stopBool) -> Void in
                var myKey = dictKey as NSString
                var myObj = dictObj as NSString
                
                println("\(myKey) ... \(myObj)")
            })
            
            if let jsonObject = responseDict as? [String:AnyObject] {
                if error == nil {
                    println("Data returned from FB:\n\(jsonObject)")
                    if let data = JSONValue.fromObject(jsonObject)?.object{
                        for (key,v) in data {
                            println("\(key) .. \(v.string)")
                        }
                    }
                }
            }
        }
    }
}

