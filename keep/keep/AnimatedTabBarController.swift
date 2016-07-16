//
//  AnimatedTabBarController.swift
//  keep
//
//  Created by D_ttang on 15/5/16.
//  Copyright (c) 2015年 D_ttang. All rights reserved.
//

import UIKit

class AnimatedTarBarItem: UITabBarItem {
 
    @IBOutlet weak var animation: ItemAnimation!
    @IBInspectable var textColor: UIColor = UIColor.blackColor()
    
    func playAnimation(icon: UIImageView, textLabel: UILabel){
        if animation != nil {
            animation.playAnimation(icon, textLabel: textLabel)
        }
    }
    
    func deselectedAnimation(icon: UIImageView, textLable: UILabel){
        if animation != nil {
            animation.deselectAnimation(icon, textLabel: textLable, defaultTextColor: textColor)
        }
    }
    
    func selectedState(icon: UIImageView, textLabel: UILabel){
        if animation != nil {
            animation.selectedState(icon, textLabel: textLabel)
        }
    }
    
}

class AnimatedTabBarController: UITabBarController {

    var iconsView: [(icon: UIImageView, textLabel: UILabel)] = Array()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let containers = createViewContainers()
        
        createCustomIcons(containers)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createCustomIcons(containers: NSDictionary){
        if let items = tabBar.items {
            let itemsCount: Int = tabBar.items!.count as Int - 1
            var index = 0
            for item in self.tabBar.items as! [AnimatedTarBarItem] {
                let container: UIView = containers["container\(itemsCount - index)"] as! UIView
                container.tag = index
                
                let icon = UIImageView(image: item.image)
                icon.translatesAutoresizingMaskIntoConstraints = false
                icon.tintColor = UIColor.clearColor()
                
                // text
                let textLabel = UILabel()
                textLabel.text = item.title
                textLabel.backgroundColor = UIColor.clearColor()
                textLabel.textColor = item.textColor
                textLabel.font = UIFont.systemFontOfSize(10)
                textLabel.textAlignment = NSTextAlignment.Center
                textLabel.translatesAutoresizingMaskIntoConstraints = false
                
                container.addSubview(icon)
                createConstraints(icon, container: container, size: item.image!.size, yOffset: -5)
                container.addSubview(textLabel)
        
                let textLabelWidth = tabBar.frame.width / CGFloat(tabBar.items!.count) - 5.0
                createConstraints(textLabel, container: container, size: CGSize(width: textLabelWidth , height: 10), yOffset: 16)
                
                let iconAndLabel = (icon: icon, textLabel: textLabel)
                
                iconsView.append(iconAndLabel)
                
                if 0 == index { // selected first elemet
                    item.selectedState(icon, textLabel: textLabel)
                }
                
                item.image = nil
                item.title = ""
                index++
                
            }
        }
    }
    
    func createConstraints(view:UIView, container:UIView, size:CGSize, yOffset:CGFloat) {
        
        let constX = NSLayoutConstraint(item: view,
            attribute: NSLayoutAttribute.CenterX,
            relatedBy: NSLayoutRelation.Equal,
            toItem: container,
            attribute: NSLayoutAttribute.CenterX,
            multiplier: 1,
            constant: 0)
        container.addConstraint(constX)
        
        let constY = NSLayoutConstraint(item: view,
            attribute: NSLayoutAttribute.CenterY,
            relatedBy: NSLayoutRelation.Equal,
            toItem: container,
            attribute: NSLayoutAttribute.CenterY,
            multiplier: 1,
            constant: yOffset)
        container.addConstraint(constY)
        
        let constW = NSLayoutConstraint(item: view,
            attribute: NSLayoutAttribute.Width,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1,
            constant: size.width)
        view.addConstraint(constW)
        
        let constH = NSLayoutConstraint(item: view,
            attribute: NSLayoutAttribute.Height,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1,
            constant: size.height)
        view.addConstraint(constH)
    }
    
    func createViewContainers() -> NSDictionary {
        var containersDict = NSMutableDictionary()
        
        let itemsCount: Int = tabBar.items!.count as Int - 1
        
        for index in 0...itemsCount {
            var viewContainer = createViewContainer()
            containersDict.setValue(viewContainer, forKey: "container\(index)")
        }
        
        var keys = containersDict.allKeys
        
        var formatString = "H:|-(0)-[container0]"
        for index in 1...itemsCount {
            formatString += "-(0)-[container\(index)(==container0)]"
        }
        formatString += "-(0)-|"
        
        print("formatString: \(formatString)")
        
        var constranints = NSLayoutConstraint.constraintsWithVisualFormat(formatString,
                        options: NSLayoutFormatOptions.DirectionRightToLeft,
                        metrics: nil,
                          views: containersDict as [NSObject : AnyObject])
        
        view.addConstraints(constranints)

        return containersDict
    }
    
    func createViewContainer() -> UIView {
        let viewContainer = UIView()
        viewContainer.backgroundColor = UIColor.clearColor()
        viewContainer.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(viewContainer)
        
        // add tapGesture
        let tapGesture = UITapGestureRecognizer(target: self, action: "tapHandler:")
        tapGesture.numberOfTapsRequired = 1
        viewContainer.addGestureRecognizer(tapGesture)
        
        // add constrains
        let constY = NSLayoutConstraint(item: viewContainer,
            attribute: NSLayoutAttribute.Bottom,
            relatedBy: NSLayoutRelation.Equal,
            toItem: view,
            attribute: NSLayoutAttribute.Bottom,
            multiplier: 1,
            constant: 0)
        
        view.addConstraint(constY)
        
        let constH = NSLayoutConstraint(item: viewContainer,
            attribute: NSLayoutAttribute.Height,
            relatedBy: NSLayoutRelation.Equal,
            toItem: nil,
            attribute: NSLayoutAttribute.NotAnAttribute,
            multiplier: 1,
            constant: tabBar.frame.size.height)
        viewContainer.addConstraint(constH)
        
        
        return viewContainer
    }
    
    func tapHandler(gesture:UITapGestureRecognizer){
        
        let items = tabBar.items as! [AnimatedTarBarItem]
        
        let currentIndex = gesture.view!.tag
        
        if selectedIndex != currentIndex {
            
            let animationItem: AnimatedTarBarItem = items[currentIndex]
            let icon: UIImageView = iconsView[currentIndex].icon
            let textLabel: UILabel = iconsView[currentIndex].textLabel
            animationItem.playAnimation(icon, textLabel: textLabel)
            
            let deselectItem: AnimatedTarBarItem = items[selectedIndex]
            let deselectIcon: UIImageView = iconsView[selectedIndex].icon
            let deselectTextLabel: UILabel = iconsView[selectedIndex].textLabel
            deselectItem.deselectedAnimation(deselectIcon, textLable: deselectTextLabel)
            
            selectedIndex = gesture.view!.tag
        }
        
    }

}
