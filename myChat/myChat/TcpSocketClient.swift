//
//  TcpSocketClient.swift
//  myChat
//
//  Created by D_ttang on 15/2/20.
//  Copyright (c) 2015年 D_ttang. All rights reserved.
//

import Foundation

public class TcpClientSocket:Socket {
    /*
    * connect to server
    * return success or fail with message
    */
    public func connect(timeout t:Int)->(Bool,String){
        let rs:Int32 = tcpsocket_connect(self.addr, Int32(self.port),Int32(t))
        if rs>0{
            self.fd=rs
            return (true,"connect success")
        }else{
            switch rs{
            case -1:
                return (false,"qeury server fail")
            case -2:
                return (false,"connection closed")
            case -3:
                return (false,"connect timeout")
            default:
                return (false,"unknow err.")
            }
        }
    }
    
    /*
    * close socket
    * return success or fail with message
    */
    public func close()->(Bool,String){
        if let fd:Int32 = self.fd {
            tcpsocket_close(fd)
            self.fd=nil
            return (true,"close success")
        }else{
            return (false,"socket not open")
        }
    }
    /*
    * send data
    * return success or fail with message
    */
    public func send(data d:[Int8])->(Bool,String){
        if let fd:Int32 = self.fd{
            let sendsize:Int32 = tcpsocket_send(fd, d, Int32(d.count))
            if Int(sendsize) == d.count{
                return (true,"send success")
            }else{
                return (false,"send error")
            }
        }else{
            return (false,"socket not open")
        }
    }
    
    /*
    * send string
    * return success or fail with message
    */
    public func send(str s:String)->(Bool,String){
        if let fd:Int32=self.fd{
            let sendsize:Int32 = tcpsocket_send(fd, s, Int32(strlen(s)))
            if sendsize == Int32(strlen(s)){
                return (true,"send success")
            }else{
                return (false,"send error")
            }
        }else{
            return (false,"socket not open")
        }
    }
    
    /*
    *
    * send nsdata
    */
    public func send(data d:NSData)->(Bool,String){
        if let fd:Int32=self.fd{
            var buff:[Int8] = [Int8](count:d.length,repeatedValue:0x0)
            d.getBytes(&buff, length: d.length)
            let sendsize:Int32 = tcpsocket_send(fd, buff, Int32(d.length))
            if sendsize==Int32(d.length){
                return (true,"send success")
            }else{
                return (false,"send error")
            }
        }else{
            return (false,"socket not open")
        }
    }
    
    /*
    * read data with expect length
    * return success or fail with message
    */
    public func read(expectlen:Int)->[Int8]?{
        if let fd:Int32 = self.fd{
            var buff:[Int8] = [Int8](count:expectlen,repeatedValue:0x0)
            let readLen:Int32 = tcpsocket_pull(fd, &buff, Int32(expectlen))
            if readLen<=0{
                return nil
            }
            let rs = buff[0...Int(readLen-1)]
            let data:[Int8] = Array(rs)
            return data
        }
        return nil
    }
}