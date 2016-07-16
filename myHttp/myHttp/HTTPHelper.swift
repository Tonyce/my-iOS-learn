//
//  HTTPHelper.swift
//  myHttp
//
//  Created by D_ttang on 15/5/6.
//  Copyright (c) 2015年 D_ttang. All rights reserved.
//

import Foundation

enum HTTPRequestContentType {
    case HTTPJsonContent
    case HTTPMultipartContent
}

struct HTTPHelper {
    static let BASE_URL = "http://127.0.0.1:1337/api"
    
    func buildRequest(path: String, method:String, requestContentType: HTTPRequestContentType = HTTPRequestContentType.HTTPJsonContent, requestBoundary: String = "") -> NSMutableURLRequest{
        
        let requestURL = NSURL(string: "\(HTTPHelper.BASE_URL)/\(path)")
        let request = NSMutableURLRequest(URL: requestURL!)
        
        request.HTTPMethod = method
        
        switch requestContentType {
            
        case .HTTPJsonContent:
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        case .HTTPMultipartContent:
            _ = NSString(format: "multipart/form-data; boundary=%@", requestBoundary)
            request.addValue("", forHTTPHeaderField: "Content-Type")
        }
        
        return request
    }
    
    func sendRequest(request: NSURLRequest, completion: (NSData!, NSError!) -> Void) -> (){
        let session = NSURLSession.sharedSession()
        
//        let task = session.dataTaskWithRequest(request, completionHandler: { (data: NSData!, response:NSURLResponse!, error: NSError!) -> Void in
        let task = session.dataTaskWithRequest(request, completionHandler: {
            data, response:, error -> Void in
            if error != nil {
                dispatch_async(dispatch_get_main_queue(), {() -> Void in
                    completion(data, error)
                })
                
                return
            }
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                let httpResponse = response! as NSHTTPURLResponse
                
                if httpResponse.statusCode == 200 {
                    completion(data, nil)
                } else {
                    var jsonerror: NSError?
                    
                    let errorDict = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error:&jsonerror) as NSDictionary
                    
                    let responseError : NSError = NSError(domain: "HTTPHelperError", code: httpResponse.statusCode, userInfo: errorDict)
                    completion(data, responseError)
                    
                }
            })
        })
        
        task.resume()
    }
    
    func getErrorMessage(error: NSError) -> NSString {
        var errorMessage : NSString
        
        // return correct error message
        if error.domain == "HTTPHelperError" {
            let userInfo = error.userInfo as NSDictionary!
            errorMessage = userInfo.valueForKey("message") as! NSString
        } else {
            errorMessage = error.description
        }
        
        return errorMessage
    }
}