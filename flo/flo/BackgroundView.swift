//
//  BackgroundView.swift
//  flo
//
//  Created by D_ttang on 15/5/7.
//  Copyright (c) 2015年 D_ttang. All rights reserved.
//

import UIKit

@IBDesignable
class BackgroundView: UIView {
    //1
    @IBInspectable var lightColor: UIColor = UIColor.orangeColor()
    @IBInspectable var darkColor: UIColor = UIColor.yellowColor()
    @IBInspectable var patternSize:CGFloat = 200

    override func drawRect(rect: CGRect) {
        //2
        let context = UIGraphicsGetCurrentContext()
        
        //3
        CGContextSetFillColorWithColor(context, darkColor.CGColor)
        
        //4
        CGContextFillRect(context, rect)
        
         let drawSize = CGSize(width: patternSize, height: patternSize)
        
        // insert code here
        UIGraphicsBeginImageContextWithOptions(drawSize, true, 0.0)
        let drawingContext = UIGraphicsGetCurrentContext()
        
        darkColor.setFill()
        CGContextFillRect(drawingContext, CGRectMake(0, 0, drawSize.width, drawSize.height))
        
        let trianglePath = UIBezierPath()
        
        trianglePath.moveToPoint(CGPoint(x: drawSize.width / 2, y: 0))
        trianglePath.addLineToPoint(CGPoint(x: 0, y: drawSize.height / 2))
        trianglePath.addLineToPoint(CGPoint(x: drawSize.width, y: drawSize.height / 2))
        
        trianglePath.moveToPoint(CGPoint(x: 0, y: drawSize.height / 2))
        trianglePath.addLineToPoint(CGPoint(x: drawSize.width / 2, y: drawSize.height))
        trianglePath.addLineToPoint(CGPoint(x: 0, y: drawSize.height))
        
        trianglePath.moveToPoint(CGPoint(x: drawSize.width, y: drawSize.height / 2))
        trianglePath.addLineToPoint(CGPoint(x: drawSize.width / 2, y: drawSize.height))
        trianglePath.addLineToPoint(CGPoint(x: drawSize.width, y: drawSize.height))
        
        lightColor.setFill()
        trianglePath.fill()
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        UIColor(patternImage: image).setFill()
        CGContextFillRect(context, rect)
    }

}
