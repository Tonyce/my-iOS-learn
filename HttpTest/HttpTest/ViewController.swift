//
//  ViewController.swift
//  HttpTest
//
//  Created by D_ttang on 15/6/16.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

//        postTest(["username":"jameson", "password":"password"], url:"http://192.168.1.106:8080/messages")
        getTest(){
            data, error in
            if error != nil {
                print("error\(error)")
                return
            }
            do {
                let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions())
                print("json\(json)")
            }catch _ {
                print("NSJSONSerialization err")
                return
            }
        }
//        let url = NSURL(string: "http://192.168.1.106:9999/img/me.jpg")
//        let data = NSData(contentsOfURL: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check
//        imageView.image = UIImage(data: data!)
        imageView.imageFromUrl("http://192.168.1.17:9999/img/me.jpg")
        
        
        let getUrl = NSURL(string: "http://192.168.1.17:8088/messages")
        let getData = NSData(contentsOfURL: getUrl!)
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(getData!, options: NSJSONReadingOptions())
            print("---json\(json)")
        }catch _ {
            print("----NSJSONSerialization err")
            return
        }
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

func getTest(callback: (data: NSData?, err: NSError?) -> Void){
    let request = NSMutableURLRequest(URL: NSURL(string: "http://192.168.1.106:8088/messages")!)
    let session = NSURLSession.sharedSession()
    let task = session.dataTaskWithRequest(request){
        (data, response, error) -> Void in
        callback(data: data, err: error )
    }
    task!.resume()
}

func postTest(params: Dictionary<String, String>, url: String){
    print("post")
    // let request = NSMutableURLRequest(URL: NSURL(string: "http://192.168.1.21:8080/messages")!)
    let request = NSMutableURLRequest(URL: NSURL(string: url)!)
    let session = NSURLSession.sharedSession()
    request.HTTPMethod = "POST"
    // let params = ["username":"jameson", "password":"password"]
    let params = params
    do{
        request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: NSJSONWritingOptions(rawValue: 0))
    }catch _ {
        print("err")
        return
    }
    request.addValue("application/json", forHTTPHeaderField: "Content-Type")
    request.addValue("application/json", forHTTPHeaderField: "Accept")
    let task = session.dataTaskWithRequest(request, completionHandler: {
        data, response, error -> Void in
        
        if error != nil {
            print("error:\(error)")
            return
        }
        // print("Response: \(response)")
        let strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
        print("Body: \(strData)")
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions())
            print("json\(json)")
        }catch _ {
            print("err")
            return
        }
        
    })
    task!.resume()
}

extension UIImageView {
    public func imageFromUrl(urlString: String) {
        if let url = NSURL(string: urlString) {
            let request = NSURLRequest(URL: url)
            let session = NSURLSession.sharedSession()
            let task = session.dataTaskWithRequest(request){
                (data, response, error) -> Void in
                if error != nil {
                    return
                }
                print("done")
                dispatch_async(dispatch_get_main_queue(), {
                    // code here
                    self.image = UIImage(data: data!)
                    self.layer.cornerRadius = 30
                    self.layer.masksToBounds = true;
                })
//                dispatch_async(queue: dispatch_queue_t, block: dispatch_block_t)
//                self.image = UIImage(data: data!)
            }
            task!.resume()
            
            // deprecated
            /*
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {
                response, data, error -> Void in
                if error != nil {
                    return
                }
                self.image = UIImage(data: data!)
            })
            */
        }
    }
}

