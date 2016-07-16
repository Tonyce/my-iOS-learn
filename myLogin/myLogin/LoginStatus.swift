//
//  LoginStatus.swift
//  myLogin
//
//  Created by D_ttang on 15/6/22.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit

let LogedInKey = "LogedIn"

class LoginStatus {
    static var status: Bool = false
    
    class func getPath() -> String {
//        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
//        let documentsDirectory = paths[0] as! String
//        let path = documentsDirectory.stringByAppendingPathComponent("initial.pist")
        return ""
    }
    
    class func isPlistExist() -> Bool {
//        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray
//        let documentsDirectory = paths[0] as! String
//        let path = documentsDirectory.stringByAppendingPathComponent("initial.pist")
//        
//        let fileManager = NSFileManager.defaultManager()
//        
//        if fileManager.fileExistsAtPath(path) {
//            return true
//        }
        return false
    }
    
    class func loadStatusFromPlist() {
        let path = getPath()
        let fileManager = NSFileManager.defaultManager()
        if !isPlistExist() {
            fileManager.createFileAtPath(path, contents: nil, attributes: [String : AnyObject]?())
            initData(path)
        }
        let myDict = NSDictionary(contentsOfFile: path)
        
        if let dict = myDict {
            //loading values
            status = Bool(dict.objectForKey(LogedInKey)! as! NSNumber)
        }
    }
    
    class func initData(path: String){
        let dict: NSMutableDictionary = ["XInitializerItem": "DoNotEverChangeMe"]
        //saving values
        dict.setObject(false, forKey: LogedInKey)

        //writing to plist
        dict.writeToFile(path, atomically: false)
    }
    
    class func saveStatusToPlist(login: Bool = true){
        
        let path = getPath()
        let dict: NSMutableDictionary = ["XInitializerItem": "DoNotEverChangeMe"]
        //saving values
        dict.setObject(login, forKey: LogedInKey)
        
        //writing to plist
        dict.writeToFile(path, atomically: false)
    }
}