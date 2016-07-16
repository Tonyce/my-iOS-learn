//
//  ViewController.swift
//  useCSocket
//
//  Created by D_ttang on 15/7/2.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
//        let result = add(2, 3)
//        print("\(result)")
        let th1 = NSThread(target:self,selector:"socket",object:nil)
        //启动线程
        th1.start()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func socket(){
        let connectResult = connectServer()
        if connectResult >= 0 {
            print("connect")
            
            let numBytesIsSend = writeToServer()
            if numBytesIsSend <= 0 {
                print("write fail")
            }
            print("\(numBytesIsSend)")
            
            monitorServer()
            
        }else {
            print("\(connectResult)")
        }
    }

}

