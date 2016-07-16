//
//  socket.swift
//  myChat
//
//  Created by D_ttang on 15/2/20.
//  Copyright (c) 2015年 D_ttang. All rights reserved.
//

import Foundation

public class Socket {
    var addr : String
    var port : Int
    var fd   : Int32?
    init(){
        self.addr = ""
        self.port = 0
    }
    
    public init(addr _addr: String, port _port : Int){
        self.addr = _addr
        self.port = _port
    }
}