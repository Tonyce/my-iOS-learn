//
//  httpHelp.swift
//  nodejs
//
//  Created by D_ttang on 15/1/6.
//  Copyright (c) 2015年 D_ttang. All rights reserved.
//

import Foundation

class HttpHelp {
    
    enum SearchResult {
        case Result(AnyObject)
        case Error
    }
    
    typealias SearchCompletion = (result: SearchResult) -> Void
    
    class func requestFromNet(term: String, completion: SearchCompletion){

        let searchURLString = (term as NSString).stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!

        let request = NSURLRequest(URL: NSURL(string: searchURLString)!)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response: NSURLResponse?, data: NSData?, error: NSError?) in
            if error != nil {
                completion(result: .Error)
                return
            }
            
            let results: AnyObject! = try? NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments)
            // println("results: \(results)")
            if results == nil {
                completion(result: .Error)
                return
            }
            completion(result: .Result(results))
        }
    }
}