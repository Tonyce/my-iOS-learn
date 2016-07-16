//
//  SocketClass.swift
//  podLearn
//
//  Created by D_ttang on 15/10/12.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import Foundation
import Starscream

class SocketClass {
    var socket = WebSocket(url: NSURL(string: "ws://localhost:8124/")!)
    init() {
        socket.delegate = self
    }
    
    func connnect() {
        socket.connect()
    }
    
    func writeString(str: String) {
        socket.writeString(str)
    }
    
    class var sharedInstance: SocketClass {
        struct Singleton {
            static let instance = SocketClass()
        }
        return Singleton.instance
    }
}

extension SocketClass: WebSocketDelegate {
    
    func websocketDidConnect(socket: WebSocket){
        print("websocket is connected")
        self.writeString("hi")
    }
    func websocketDidDisconnect(socket: WebSocket, error: NSError?) {
        print("websocket is disconnected: \(error?.localizedDescription)")
        
    }
    func websocketDidReceiveMessage(socket: WebSocket, text: String) {
        print("got some text: \(text)")
        
    }
    func websocketDidReceiveData(socket: WebSocket, data: NSData) {
        print("got some data: \(data.length)")
        
    }
}