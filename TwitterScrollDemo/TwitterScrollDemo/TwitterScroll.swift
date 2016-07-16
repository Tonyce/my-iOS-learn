//
//  TwitterScroll.swift
//  TwitterScrollDemo
//
//  Created by D_ttang on 15/5/13.
//  Copyright (c) 2015年 D_ttang. All rights reserved.
//

import UIKit
import Accelerate

let offset_HeaderStop = 40.0
let offset_B_LabelHeader = 95.0
let distance_W_LabelHeader = 35.0

enum MyType: UInt {
    case Table
    case Scroll
}


class TwitterScroll: UIView {
    
    var avatarImage:UIImageView!
    var header: UIView!
    var headerLabel: UILabel!
    var scrollView: UIScrollView!
    var tableView: UITableView!
    var headerImageView:UIImageView!
    var headerButton: UIButton!
    
    var blurImages:NSMutableArray!
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
    // Drawing code
    }
    */
    
    convenience init (backgroundImage: UIImage, avatarImage: UIImage, titleString: String, height: CGFloat, type: MyType) {
        let bounds:CGRect  = UIScreen.mainScreen().bounds
        self.init(frame:bounds)
        
        self.header = UIView(frame: CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, 107))
        self.addSubview(self.header)
        
        self.headerLabel = UILabel(frame: CGRectMake(self.frame.origin.x, self.header.frame.size.height - 5, self.frame.size.width, 25))
        self.headerLabel.textAlignment = .Center;
        
        self.headerLabel.textColor = UIColor.whiteColor()
        self.headerLabel.font = UIFont(name: "HelveticaNeue-Medium", size: 18)
        self.headerLabel.text = titleString
        self.header.addSubview(self.headerLabel)
        
        if type == .Table {
            // TableView
            self.tableView = UITableView(frame: self.frame)
            self.tableView.backgroundColor = UIColor.clearColor()
            self.tableView.showsVerticalScrollIndicator = false
            
            // TableView Header
            self.tableView.tableHeaderView = UIView(frame: CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.header.frame.size.height + 100))
            
            self.tableView.addObserver(self, forKeyPath: "contentOffset", options: NSKeyValueObservingOptions.New, context: nil)
            self.addSubview(self.tableView)
            
        } else {
            
            // Scroll
            self.scrollView = UIScrollView(frame: CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, self.frame.size.height))
            self.scrollView.showsVerticalScrollIndicator = false
            self.addSubview(self.scrollView)
            
            let newSize = CGSizeMake(self.frame.size.width, height)
            self.scrollView.contentSize = newSize;
            self.scrollView.delegate = self;
        }
        
        self.avatarImage = UIImageView(frame:CGRectMake(10, 79, 70, 70))
        self.avatarImage.image = avatarImage
        self.avatarImage.layer.cornerRadius = 10
        // self.avatarImage.layer.masksToBounds = true
        self.avatarImage.clipsToBounds = true
        self.avatarImage.layer.borderWidth  = 1
        self.avatarImage.layer.borderColor = UIColor.whiteColor().CGColor
        
        let titleLabel:UILabel  = UILabel(frame:CGRectMake(10, 156, 250, 25))
        titleLabel.text = titleString;
        
        let subtitleLabel:UILabel = UILabel(frame: CGRectMake(10, 177, 250, 25))
        subtitleLabel.text = "subtitleString"
        subtitleLabel.font = UIFont(name: "HelveticaNeue-Medium", size:12)
        subtitleLabel.textColor = UIColor.lightGrayColor()
        
        self.headerImageView = UIImageView(frame: self.header.frame)
        self.headerImageView.image = backgroundImage
        self.headerImageView.contentMode = UIViewContentMode.ScaleAspectFill
        
//        self.headerImageView.image = self.headerImageView.image!.boxblurImageWithBlur(0.4)
//        self.headerImageView.image = self.headerImageView.image!.blur(0.4)
        
        self.header.insertSubview(self.headerImageView, aboveSubview: self.headerLabel)
        self.header.clipsToBounds = true
        
        self.tableView.addSubview(self.avatarImage)
        self.tableView.addSubview(titleLabel)
        self.tableView.addSubview(subtitleLabel)
        
        self.blurImages = []
        
        self.prepareForBlurImages()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepareForBlurImages(){
        var factor:CGFloat = 0.1
        self.blurImages.addObject(self.headerImageView.image!)
        print("\(self.headerImageView.frame.size.height / 10)")
        for var i:UInt = 0; i < UInt(self.headerImageView.frame.size.height / 10); i++ {
            self.blurImages.addObject(self.headerImageView.image!.boxblurImageWithBlur(factor))
            factor += 0.04
        }
    }
    
    
}

extension TwitterScroll: UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        self.animationForScroll(offset)
    }
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [NSObject : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        let offset:CGFloat = self.tableView.contentOffset.y
        self.animationForScroll(offset);
    }
    
    
    func animationForScroll(offset:CGFloat) {
        
        var headerTransform:CATransform3D  = CATransform3DIdentity
        var avatarTransform:CATransform3D  = CATransform3DIdentity
        
        // DOWN
        if offset < 0 {
            let headerScaleFactor:CGFloat = -(offset) / self.header.bounds.size.height
            let headerSizevariation:CGFloat  = ((self.header.bounds.size.height * (1.0 + headerScaleFactor)) - self.header.bounds.size.height)/2.0
            headerTransform = CATransform3DTranslate(headerTransform, 0, headerSizevariation, 0)
            headerTransform = CATransform3DScale(headerTransform, 1.0 + headerScaleFactor, 1.0 + headerScaleFactor, 0)
            
            self.header.layer.transform = headerTransform
            
        } else { // SCROLL UP/DOWN
            // Header
            headerTransform = CATransform3DTranslate(headerTransform, 0, max(-CGFloat(offset_HeaderStop), -offset), 0)
            
            //CATransform3DTranslate(t: CATransform3D, tx: CGFloat, ty: CGFloat, tz: CGFloat)
            // Label
            let labelTransform:CATransform3D  = CATransform3DMakeTranslation(0, max(-CGFloat(distance_W_LabelHeader), CGFloat(offset_B_LabelHeader) - offset), 0)
            self.headerLabel.layer.transform = labelTransform
            self.headerLabel.layer.zPosition = 2
            
            // Avatar
            let avatarScaleFactor:CGFloat  = (min(CGFloat(offset_HeaderStop), offset)) / self.avatarImage.bounds.size.height / 1.4 // Slow down the animation
            let avatarSizeVariation:CGFloat = ((self.avatarImage.bounds.size.height * (1.0 + avatarScaleFactor)) - self.avatarImage.bounds.size.height) / 2.0
            avatarTransform = CATransform3DTranslate(avatarTransform, 0, avatarSizeVariation, 0)
            avatarTransform = CATransform3DScale(avatarTransform, 1.0 - avatarScaleFactor, 1.0 - avatarScaleFactor, 0)
            
            if offset <= CGFloat(offset_HeaderStop) {
                if self.avatarImage.layer.zPosition <= self.headerImageView.layer.zPosition {
                    self.header.layer.zPosition = 0
                }
            }else {
                if self.avatarImage.layer.zPosition >= self.headerImageView.layer.zPosition {
                    self.header.layer.zPosition = 2
                }
            }
        }
        if self.headerImageView.image != nil {
            self.blurWithOffset(Float(offset))
        }
        self.header.layer.transform = headerTransform;
        self.avatarImage.layer.transform = avatarTransform
    }
    
    func blurWithOffset(offset:Float) {
        var index = Int(offset / 10);
        if index < 0 {
            index = 0;
        }else if index >= self.blurImages.count {
            index = self.blurImages.count - 1;
        }
        print("\(index)")
        let image:UIImage = self.blurImages[index] as! UIImage
        if self.headerImageView.image != image {
            self.headerImageView.image = image
        }
    }

}

extension UIImage {
    func boxblurImageWithBlur(blur: CGFloat) -> UIImage!{
        var _blur = blur
        var imageData:NSData = UIImageJPEGRepresentation(self, 1)!
        var destImage = UIImage(data: imageData)!
        
//        return destImage!
        
        if _blur < 0.0 || _blur > 1.0 {
            _blur = 0.5
        }
//        println("\(_blur)")
        var boxSize = Int(_blur * 40)
        print("boxSize: \(boxSize)")
        boxSize = boxSize - (boxSize % 2) + 1
        
        var img:CGImageRef = destImage.CGImage!
        
        var error: vImage_Error!
        
        var inProvider:CGDataProviderRef = CGImageGetDataProvider(img)
        
        var inBitmapData = CGDataProviderCopyData(inProvider)
        
        if inBitmapData == nil {
            print("inBitmapData == nil")
        }

        var inBuffer = vImage_Buffer(data: UnsafeMutablePointer<Void>(CFDataGetBytePtr(inBitmapData)),
                               height: vImagePixelCount(CGImageGetHeight(img)),
                                width: vImagePixelCount(CGImageGetWidth(img)),
                             rowBytes: CGImageGetBytesPerRow(img))
        
        var pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img))
        if pixelBuffer == nil {
            print("No pixelbuffer")
        }
        var outBuffer = vImage_Buffer(data: pixelBuffer,
                                    height: vImagePixelCount(CGImageGetHeight(img)),
                                     width: vImagePixelCount(CGImageGetWidth(img)),
                                  rowBytes: CGImageGetBytesPerRow(img))
        
        // Create a third buffer for intermediate processing
//        var pixelBuffer2 = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img))
//
//        var outBuffer2 = vImage_Buffer(data: pixelBuffer2,
//                                 height: vImagePixelCount(CGImageGetHeight(img)),
//                                  width: vImagePixelCount(CGImageGetWidth(img)),
//                               rowBytes: CGImageGetBytesPerRow(img))
        

//        error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer2, nil, 0, 0, UInt32(boxSize), UInt32(boxSize), nil, vImage_Flags(kvImageEdgeExtend))
//        if error != 0 {
//            println("\(error)")
//        }
//        error = vImageBoxConvolve_ARGB8888(&outBuffer2, &inBuffer, nil, 0, 0, UInt32(boxSize), UInt32(boxSize), nil, vImage_Flags(kvImageEdgeExtend))
//        if error != 0 {
//            println("\(error)")
//        }
        error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, nil, 0, 0, UInt32(boxSize), UInt32(boxSize), nil, vImage_Flags(kvImageEdgeExtend))
        if error != 0 {
            print("\(error)")
        }
        let colorSpace: CGColorSpaceRef = CGColorSpaceCreateDeviceRGB();
//        var bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.NoneSkipLast.rawValue)
        let bitmapInfo = CGImageAlphaInfo.NoneSkipLast.rawValue
        let ctx = CGBitmapContextCreate(outBuffer.data,
                                        Int(outBuffer.width),
                                        Int(outBuffer.height),
                                        8,
                                        outBuffer.rowBytes,
                                        colorSpace,
                                        bitmapInfo)
//        func CGBitmapContextCreate(data: UnsafeMutablePointer<Void>,
//                                _ width: Int,
//                               _ height: Int,
//                     _ bitsPerComponent: Int,
//                          _ bytesPerRow: Int,
//                                _ space: CGColorSpace!,
//                           _ bitmapInfo: UInt32) -> CGContext!
        
        
        let imageRef:CGImageRef = CGBitmapContextCreateImage(ctx)
        
        let returnImage = UIImage(CGImage: imageRef)

        //clean up
        free(pixelBuffer)
        
        return returnImage
    }
    
    /*
    public func blur(size: Float) -> UIImage! {
        let boxSize = size - (size % 2) + 1
        let image = self.CGImage
        let inProvider = CGImageGetDataProvider(image)
        
        let height = CGImageGetHeight(image)
        let width = CGImageGetWidth(image)
        let rowBytes = CGImageGetBytesPerRow(image)
        
        let inBitmapData = CGDataProviderCopyData(inProvider)
        let inData = UnsafeMutablePointer<Void>(CFDataGetBytePtr(inBitmapData))
        var inBuffer = vImage_Buffer(data: inData, height: vImagePixelCount(height), width: vImagePixelCount(width), rowBytes: rowBytes)
        
        let outData = malloc(CGImageGetBytesPerRow(image) * CGImageGetHeight(image))
        var outBuffer = vImage_Buffer(data: outData, height: vImagePixelCount(height), width: vImagePixelCount(width), rowBytes: rowBytes)
        
        let error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, nil, 0, 0, UInt32(boxSize), UInt32(boxSize), nil, vImage_Flags(kvImageEdgeExtend))
        
        var colorSpace = CGColorSpaceCreateDeviceRGB()
        let context = CGBitmapContextCreate(outBuffer.data,
                                            Int(outBuffer.width),
                                            Int(outBuffer.height),
                                            8,
                                            outBuffer.rowBytes,
                                            colorSpace,
                                            CGImageGetBitmapInfo(image))
//        CGBitmapContextCreate(data: UnsafeMutablePointer<Void>, width: Int, height: Int, bitsPerComponent: Int, bytesPerRow: Int, space: CGColorSpace!, bitmapInfo: CGBitmapInfo)
        let imageRef = CGBitmapContextCreateImage(context)
        let bluredImage = UIImage(CGImage: imageRef)
        
        free(outData)
        
        return bluredImage
    }
*/
}
