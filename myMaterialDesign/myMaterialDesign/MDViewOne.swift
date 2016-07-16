//
//  MDViewOne.swift
//  myMaterialDesign
//
//  Created by D_ttang on 15/5/19.
//  Copyright (c) 2015年 D_ttang. All rights reserved.
//

import UIKit

let MDViewOneAnimationDuration: NSTimeInterval  = 0.5;

class MDViewOne: UIView {

    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    
    var subView: UIView!
    var subViewSwitch: UISwitch!
    var subViewButton: UIButton!
    var controls: NSMutableArray!
    var detailsButton: UIButton!
    
    func randomNumber0_1() -> CGFloat{
        return  CGFloat(Float( rand() % 10000 ) / 10000.0);
    }
    
    func randomColor() -> UIColor {
        return UIColor(red: self.randomNumber0_1(), green: self.randomNumber0_1(), blue: self.randomNumber0_1(), alpha: 1.0)
    }
    
    override init(frame: CGRect){
        super.init(frame: frame)
        srand(UInt32(time(nil)))
//        let time = UInt32(NSDate().timeIntervalSinceReferenceDate)
//        srand(time)
//        print("Random number: \(rand()%10)")
        
        self.backgroundColor = UIColor.blackColor()
        self.autoresizingMask = [UIViewAutoresizing.FlexibleHeight, UIViewAutoresizing.FlexibleWidth]
        
        subView = UIView(frame: CGRectMake(0, 0, 90, 90))
//        self.subView.backgroundColor = UIColor(red: 55.0 / 255.0 , green:64.0 / 255.0 , blue:69.0 / 255.0, alpha:1.0)
        self.subView.backgroundColor = UIColor.redColor()
        self.addSubview(self.subView)
        
        let subViewLabel = UILabel(frame: CGRectMake(20.0, 20.0, 1.0, 1.0))
        
        subViewLabel.textAlignment = NSTextAlignment.Center
        subViewLabel.font = UIFont(name: "HelveticaNeue", size: 16.0)
        subViewLabel.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleWidth]
        subViewLabel.numberOfLines = 0
        subViewLabel.text = "Hello, world!\nFew words label..."
        subViewLabel.textColor = UIColor.whiteColor()

        self.subView.addSubview(subViewLabel)
        
        subViewSwitch = UISwitch()
        self.subViewSwitch.addTarget(self, action: Selector("subviewSwitchAction:"), forControlEvents: UIControlEvents.ValueChanged)
        self.subView.addSubview(self.subViewSwitch)
        
        subViewButton = UIButton(type: UIButtonType.System)
        self.subViewButton.addTarget(self, action: Selector("buttonAction:event:"), forControlEvents: UIControlEvents.TouchUpInside)
//        [self.subviewButton addTarget:self action:@selector(buttonAction:event:) forControlEvents:UIControlEventTouchUpInside];
        self.subViewButton.setTitle("Button", forState: UIControlState.Normal)
        self.subView.addSubview(self.subViewButton)
        
        self.controls = NSMutableArray()
        
//        const; controlsCount;:NSInteger  = 4.0;
        let controlsCount = 4
        for var i = 0; i < controlsCount; i++ {
            let control: UIControl = UIControl()
            control.backgroundColor = self.randomColor()
            control.addTarget(self, action: Selector("controlAction:event:"), forControlEvents: UIControlEvents.TouchUpInside)
//            self, action: Selector("addPassAction:"), forControlEvents: UIControlEvents.TouchUpInside)

//            [control addTarget:self action:@selector(controlAction:event:) forControlEvents:UIControlEventTouchUpInside];
            self.addSubview(control)
//            self.controls.addObject(control)
        }
        
        detailsButton = UIButton(type: UIButtonType.System)
        self.detailsButton.setTitle("Show Details", forState: UIControlState.Normal)
        self.addSubview(self.detailsButton)
        
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // pragma mark - actions
    
    @objc private func buttonAction(sender: UIControl, event: UIEvent){
//        if let touch = UIEvent.first as? UITouch
//        var touch: UITouch = event.allTouches() as! UITouch
////        let touch = event.allTouches()
////        let touch = event.allTouches()!
//        let location = touch.locationInView(self.subView)
        //            var position:CGPoint = event.allTouches()
        print("button")
    }
    
    @objc private func controlAction(sender: UIControl, event: UIEvent){
        print("control")
    }
    
    @objc private func subviewSwitchAction(swtch: UISwitch){
        print("\(swtch.on)")
        if swtch.on {
            self.subView.mdInflateAnimatedFromPoint(swtch.center, backgroundColor: UIColor(red: 0.0/255.0, green: 150/255.0, blue: 137.0/255.0, alpha: 1.0), duration: MDViewOneAnimationDuration, completion: {})
        } else {
//            self.subView.mdDeflateAnimatedToPoint(swtch.center, backgroundColor: UIColor(red:55.0/255.0, green:64.0/255.0, blue:69.0/255.0, alpha:1.0), duration: MDViewOneAnimationDuration, completion: {})
        }
    }
}



//- (void)buttonAction:(UIControl *)sender event:(UIEvent *)event {
//    CGPoint position = [[[event allTouches] anyObject] locationInView:self.subview];
//    [self.subview mdInflateAnimatedFromPoint:position backgroundColor:[self randomColor] duration:MDViewOneAnimationDuration completion:nil];
//    }

//    - (void)controlAction:(UIControl *)sender event:(UIEvent *)event {
//        CGPoint position = [[[event allTouches] anyObject] locationInView:sender];
//        
//        NSInteger index = [self.controls indexOfObjectIdenticalTo:sender];
//        if (index % 2) {
//            [sender mdInflateAnimatedFromPoint:position backgroundColor:[self randomColor] duration:MDViewOneAnimationDuration completion:nil];
//        } else {
//            [sender mdDeflateAnimatedToPoint:position backgroundColor:[self randomColor] duration:MDViewOneAnimationDuration completion:nil];
//        }
//        }
//        
//        - (void)subviewSwitchAction:(UISwitch *)swtch {
//            if (swtch.isOn) {
//                [self.subview mdInflateAnimatedFromPoint:swtch.center backgroundColor:[UIColor colorWithRed:0.0 / 255.0 green:150.0 / 255.0 blue:137.0 / 255.0 alpha:1.0] duration:MDViewOneAnimationDuration completion:nil];
//            } else {
//                [self.subview mdDeflateAnimatedToPoint:swtch.center backgroundColor:[UIColor colorWithRed:55.0 / 255.0 green:64.0 / 255.0 blue:69.0 / 255.0 alpha:1.0] duration:MDViewOneAnimationDuration completion:nil];
//            }



