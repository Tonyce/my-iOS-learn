//
//  AlertView.swift
//  nodejs
//
//  Created by D_ttang on 15/1/7.
//  Copyright (c) 2015年 D_ttang. All rights reserved.
//

import Foundation
import UIKit

class MyAlertView {
    class func showAlert(_self: UIViewController, _message: String) {
        let alert = UIAlertController(title: "Title", message: String(_message), preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
        _self.presentViewController(alert, animated: true, completion: nil)
    }
}