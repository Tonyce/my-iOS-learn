//
//  Messages.swift
//  myChat
//
//  Created by D_ttang on 15/2/20.
//  Copyright (c) 2015年 D_ttang. All rights reserved.
//

import Foundation

class Message : NSObject, JSQMessageData {
    var text_: String
    var sender_: String
    var date_: NSDate
    var imageUrl_: String?
    
    convenience init(text: String?, sender: String?) {
        self.init(text: text, sender: sender, imageUrl: nil)
    }
    
    init(text: String?, sender: String?, imageUrl: String?) {
        self.text_ = text!
        self.sender_ = sender!
        self.date_ = NSDate()
        self.imageUrl_ = imageUrl
    }
    
    func text() -> String! {
        return text_;
    }
    
    func sender() -> String! {
        return sender_;
    }
    
    func date() -> NSDate! {
        return date_;
    }
    
    func imageUrl() -> String? {
        return imageUrl_;
    }
}