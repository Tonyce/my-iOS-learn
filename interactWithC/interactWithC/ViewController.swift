//
//  ViewController.swift
//  interactWithC
//
//  Created by D_ttang on 15/2/9.
//  Copyright (c) 2015年 D_ttang. All rights reserved.
//

import UIKit
//import Darwin.C

class ViewController: UIViewController {
    
//    let my_client_socket = ClientSocket ("localhost", 30000)

    override func viewDidLoad() {
        super.viewDidLoad()
        testtcpclient()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func testtcpclient(){
        // 创建socket
        // print("......")
        let client:TCPClient = TCPClient(addr: "127.0.0.1", port: 8124)
        //连接
        var (success,errmsg)=client.connect(timeout: 1)
        if success{
            //发送数据
//            var (success,errmsg)=client.send(str:"GET / HTTP/1.0\n\n" )
            var (success,errmsg)=client.send(str:"hello")
            if success{
                //读取数据
                let data=client.read(1024*10)
                if let d=data{
                    if let str=String(bytes: d, encoding: NSUTF8StringEncoding){
                        print(str)
                    }
                }
            }else{
                print(errmsg)
            }
        }else{
            print("llll\(errmsg)")
        }
    }


}

