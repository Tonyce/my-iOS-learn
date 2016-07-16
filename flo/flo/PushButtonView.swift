//
//  PushButtonView.swift
//  flo
//
//  Created by D_ttang on 15/5/6.
//  Copyright (c) 2015年 D_ttang. All rights reserved.
//

import UIKit

@IBDesignable

class PushButtonView: UIButton {
    
    @IBInspectable var fillColor: UIColor = UIColor.greenColor()
    @IBInspectable var isAddButton: Bool  = true

    override func drawRect(rect: CGRect) {
        let path = UIBezierPath(ovalInRect: rect)
        // UIColor.greenColor().setFill()
        // UIColor.blueColor().setFill()
        fillColor.setFill()
        path.fill()
        
        let plusHeight:CGFloat = 3.0
        let plusWidth:CGFloat  = min(bounds.width, bounds.height) * 0.6
        
        let plusPath = UIBezierPath()
        
        plusPath.lineWidth = plusHeight
        
        
        plusPath.moveToPoint(CGPoint(x: bounds.width / 2 - plusWidth / 2 + 0.5 , y: bounds.height / 2 + 0.5))
        plusPath.addLineToPoint(CGPoint(x: bounds.width / 2 + plusWidth / 2 + 0.5 , y: bounds.height / 2 + 0.5))
        
        if isAddButton {
            plusPath.moveToPoint(CGPoint(x: bounds.width / 2 + 0.5, y: bounds.height / 2 - plusWidth / 2 + 0.5))
            plusPath.addLineToPoint(CGPoint(x: bounds.width / 2 + 0.5, y: bounds.height / 2 + plusWidth / 2 + 0.5))
            
        }
        
        UIColor.whiteColor().setStroke()
        plusPath.stroke()
        
        //set up the width and height variables
        //for the horizontal stroke
//        let plusHeight: CGFloat = 3.0
//        let plusWidth: CGFloat = min(bounds.width, bounds.height) * 0.6
//        
//        //create the path
//        var plusPath = UIBezierPath()
//        
//        //set the path's line width to the height of the stroke
//        plusPath.lineWidth = plusHeight
//        
//        //move the initial point of the path
//        //to the start of the horizontal stroke
//        plusPath.moveToPoint(CGPoint(
//            x:bounds.width/2 - plusWidth/2,
//            y:bounds.height/2))
//        
//        //add a point to the path at the end of the stroke
//        plusPath.addLineToPoint(CGPoint(
//            x:bounds.width/2 + plusWidth/2,
//            y:bounds.height/2))
//        
//        //set the stroke color
//        UIColor.whiteColor().setStroke()
//        
//        //draw the stroke
//        plusPath.stroke()
    }
}
