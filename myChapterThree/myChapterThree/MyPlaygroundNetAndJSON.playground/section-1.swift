// Playground - noun: a place where people can play

//import UIKit
import XCPlayground
import Foundation

var str = "Hello, playground"


import Foundation

enum JSONValue {
    
    case JSONObject([String:JSONValue])
    case JSONArray([JSONValue])
    case JSONString(String)
    case JSONNumber(NSNumber)
    case JSONBool(Bool)
    case JSONNull
    
    var object: [String:JSONValue]? {
        switch self {
        case .JSONObject(let value):
            return value
        default:
            return nil
        }
    }
    
    var array: [JSONValue]? {
        switch self {
        case .JSONArray(let value):
            return value
        default:
            return nil
        }
    }
    
    var string: String? {
        switch self {
        case .JSONString(let value):
            return value
        default:
            return nil
        }
    }
    
    var integer: Int? {
        switch self {
        case .JSONNumber(let value):
            return value.integerValue
        default:
            return nil
        }
    }
    
    var double: Double? {
        switch self {
        case .JSONNumber(let value):
            return value.doubleValue
        default:
            return nil
        }
    }
    
    var bool: Bool? {
        switch self {
        case .JSONBool(let value):
            return value
        case .JSONNumber(let value):
            return value.boolValue
        default:
            return nil
        }
    }
    
    subscript(i: Int) -> JSONValue? {
        get {
            switch self {
            case .JSONArray(let value):
                return value[i]
            default:
                return nil
            }
        }
    }
    
    subscript(key: String) -> JSONValue? {
        get {
            switch self {
            case .JSONObject(let value):
                return value[key]
            default:
                return nil
            }
        }
    }
    
    static func fromObject(object: AnyObject) -> JSONValue? {
        switch object {
        case let value as NSString:
            return JSONValue.JSONString(value as String)
        case let value as NSNumber:
            return JSONValue.JSONNumber(value)
        case let value as NSNull:
            return JSONValue.JSONNull
        case let value as NSDictionary:
            var jsonObject: [String:JSONValue] = [:]
            for (k: AnyObject, v: AnyObject) in value {
                if let k = k as? NSString {
                    if let v = JSONValue.fromObject(v) {
                        jsonObject[k] = v
                    } else {
                        return nil
                    }
                }
            }
            return JSONValue.JSONObject(jsonObject)
        case let value as NSArray:
            var jsonArray: [JSONValue] = []
            for v in value {
                if let v = JSONValue.fromObject(v) {
                    jsonArray.append(v)
                } else {
                    return nil
                }
            }
            return JSONValue.JSONArray(jsonArray)
        default:
            return nil
        }
    }
    
}

let nodeIndexUrl = "http://nodejs.org/api/index.json"
//let nodeIndexUrl = "http://baidu.com"
let request = NSURLRequest(URL: NSURL(string: nodeIndexUrl)!)
print("------------")

NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue())
    { (response: NSURLResponse!, data: NSData!, error: NSError!) in
        println("------------")
        if error != nil {
            println("\(error)")
            return
        }
        if data != nil {
//            println("\(data)")
            let results: AnyObject! = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.AllowFragments, error: nil)
            if results == nil {
                return
            }else{
                println("=======")
                if let json = JSONValue.fromObject(results) {
                    let source = json["source"]?.string
                    let desc_type0   = json["desc"]?[0]?["type"]?.string
                    let descs = json["desc"]?.array
                    for obj in descs! {
                        var _type = obj["type"]?.string
                    }
//                    let desc0  = desc?[0]
//                    let type0  = desc0["type"]?.string
//                    let photos = json["photos"]?["photo"]?.array
//                    if status != nil && status! == "ok" && photos != nil {
//                        var flickrPhotos: [Photo] = []
//                        for photo in photos! {
//                            flickrPhotos.append(Photo.createFromJSON(photo))
//                        }
//                        completion(result: .Results(flickrPhotos))
//                        return
//                    }
                }
            }
        }
    }
/*
let url = NSURL(string: "http://nodejs.org/api/index.json")
let task = NSURLSession.sharedSession().dataTaskWithURL(url!) {(data, response, error) in
    println(NSString(data: data, encoding: NSUTF8StringEncoding))
}
task.resume()

NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) {(response, data, error) in
    if error != nil {
        println("\(error)")
    }
//    println(NSString(data: data, encoding: NSUTF8StringEncoding))
}

func getTemperatureForLocation(location: NSString){
    var url : String = "http://api.openweathermap.org/data/2.5/weather?units=imperial&q=" + location
    var request : NSMutableURLRequest = NSMutableURLRequest()
    request.URL = NSURL(string: url)
    request.HTTPMethod = "GET"
    NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue(), completionHandler:{ (response:NSURLResponse!, data: NSData!, error: NSError!) -> Void in
        if error != nil {
            println("\(error)")
        }else {
            println(NSString(data: data, encoding: NSUTF8StringEncoding))
        }
        var error: AutoreleasingUnsafeMutablePointer<NSError?> = nil
        let jsonResult: NSDictionary! = NSJSONSerialization.JSONObjectWithData(data, options:NSJSONReadingOptions.MutableContainers, error: error) as? NSDictionary
        
        if (jsonResult != nil) {
            var temp = jsonResult["main"]?["temp"]? as NSNumber
            println(temp)
        } else {
            println("Failed to get temperature")
        }
    })
}
getTemperatureForLocation("Philadelphia,PA")
*/
XCPSetExecutionShouldContinueIndefinitely(true)
