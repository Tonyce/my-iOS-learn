//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

var request = NSMutableURLRequest(URL: NSURL(string: "http://192.168.1.106:8080/messages")!)
var session = NSURLSession.sharedSession()
request.HTTPMethod = "POST"

var params = ["username":"jameson", "password":"password"] as Dictionary<String, String>

request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(params, options: NSJSONWritingOptions(rawValue: 0))
request.addValue("application/json", forHTTPHeaderField: "Content-Type")
request.addValue("application/json", forHTTPHeaderField: "Accept")

var task = session.dataTaskWithRequest(request, completionHandler: {
    data, response, error -> Void in
    
    if error != nil {
        print("err != nil")
        return
    }
    print("Response: \(response)")
    var strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
    print("Body: \(strData)")
//    var json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves)
})

//var task = session.dataTaskWithRequest(request, completionHandler: {
//    data, response, error -> Void in
//        print("Response: \(response)")
//        var strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
//        print("Body: \(strData)")
//        var err: NSError?
//        var json = try NSJSONSerialization.JSONObjectWithData(data!, options: .MutableLeaves)

    // Did the JSONObjectWithData constructor return an error? If so, log the error to the console
//    if(err != nil) {
//        print(err!.localizedDescription)
//        let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
//        print("Error could not parse JSON: '\(jsonStr)'")
//    }
//    else {
//        // The JSONObjectWithData constructor didn't return an error. But, we should still
//        // check and make sure that json has a value using optional binding.
//        if let parseJSON = json {
//            // Okay, the parsedJSON is here, let's get the value for 'success' out of it
//            var success = parseJSON["success"] as? Int
//            println("Succes: \(success)")
//        }
//        else {
//            // Woa, okay the json object was nil, something went worng. Maybe the server isn't running?
//            let jsonStr = NSString(data: data!, encoding: NSUTF8StringEncoding)
//            print("Error could not parse JSON: \(jsonStr)")
//        }
//    }
//})

task!.resume()
