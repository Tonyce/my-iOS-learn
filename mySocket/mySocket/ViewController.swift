//
//  ViewController.swift
//  mySocket
//
//  Created by D_ttang on 15/2/8.
//  Copyright (c) 2015年 D_ttang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let socket = ActiveSocket<sockaddr_in>()
            .onRead {
                let (count, block, errno) = $0.read()
                if count < 1 {
                    println("EOF, or great error handling \(errno).")
                    return
                }
                println("Answer to ring,ring is: \(count) bytes: \(block)")
            }
            .connect("127.0.0.1:80") {
                socket.write("Ring, ring!\r\n")
        }

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

