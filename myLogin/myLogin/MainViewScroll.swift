//
//  MainViewScroll.swift
//  myLogin
//
//  Created by D_ttang on 15/6/22.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit
import Accelerate

let offset_HeaderStop = 40.0
let offset_B_LabelHeader = 95.0
let distance_W_LabelHeader = 35.0

extension MainViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let offset = scrollView.contentOffset.y
        self.animationForScroll(offset)
//        print("\(offset)")
    }

    

//    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [NSObject : AnyObject]?, context: UnsafeMutablePointer<Void>) {
//        let offset:CGFloat = self.mainTable.contentOffset.y
//        self.animationForScroll(offset);
//    }
    
    
    func animationForScroll(offset:CGFloat) {
    
        var headerTransform:CATransform3D  = CATransform3DIdentity
        var avatarTransform:CATransform3D  = CATransform3DIdentity
        
        if self.headerImageView.image != nil {
            self.blurWithOffset(Float(offset))
        }
        
        // DOWN
        if offset < 0 {
            let headerScaleFactor:CGFloat = -(offset) / self.topView.bounds.size.height
            let headerSizevariation:CGFloat  = ((self.topView.bounds.size.height * (1.0 + headerScaleFactor)) - self.topView.bounds.size.height)/2.0
            headerTransform = CATransform3DTranslate(headerTransform, 0, headerSizevariation, 0)
            headerTransform = CATransform3DScale(headerTransform, 1.0 + headerScaleFactor, 1.0 + headerScaleFactor, 0)
            
            self.topView.layer.transform = headerTransform

        } else { // SCROLL UP/DOWN
            // Header
            headerTransform = CATransform3DTranslate(headerTransform, 0, max(-CGFloat(offset_HeaderStop), -offset), 0)
            
            //CATransform3DTranslate(t: CATransform3D, tx: CGFloat, ty: CGFloat, tz: CGFloat)
            // Label
            let labelTransform:CATransform3D  = CATransform3DMakeTranslation(0, max(-CGFloat(distance_W_LabelHeader), CGFloat(offset_B_LabelHeader) - offset), 0)
//            self.headerLabel.layer.transform = labelTransform
//            self.headerLabel.layer.zPosition = 2
            
            // Avatar
            let avatarScaleFactor:CGFloat  = (min(CGFloat(offset_HeaderStop), offset)) / self.meImage.bounds.size.height / 1.4 // Slow down the animation
            let avatarSizeVariation:CGFloat = ((self.meImage.bounds.size.height * (1.0 + avatarScaleFactor)) - self.meImage.bounds.size.height) / 2.0
            avatarTransform = CATransform3DTranslate(avatarTransform, 0, avatarSizeVariation, 0)
            avatarTransform = CATransform3DScale(avatarTransform, 1.0 - avatarScaleFactor, 1.0 - avatarScaleFactor, 0)
            
            if offset <= CGFloat(offset_HeaderStop) {
                if self.meImage.layer.zPosition <= self.headerImageView.layer.zPosition {
                    self.topView.layer.zPosition = 0
                    self.mainTable.layer.zPosition = 2
                }
            }else {
                if self.meImage.layer.zPosition >= self.headerImageView.layer.zPosition {
                    self.topView.layer.zPosition = 2
                    self.mainTable.layer.zPosition = 0
                }
            }
        }
        
        self.topView.layer.transform = headerTransform
        self.meImage.layer.transform = avatarTransform
        self.headerBottomView.layer.transform = headerTransform

    }

    func blurWithOffset(offset:Float) {
        var index = Int(offset / 10);
        if index < 0 {
            index = 0;
        }else if index >= self.blurImages.count {
            index = self.blurImages.count - 1;
        }
        let image:UIImage = self.blurImages[index] as! UIImage
        if self.headerImageView.image != image {
            self.headerImageView.image = image
        }
    }
    
    func prepareForBlurImages(){
        var factor:CGFloat = 0.1

        //if let image = self.headerImageView.image {
        //    self.blurImages.addObject(image)
        //}
        self.blurImages.addObject(self.headerImageView.image!)
        for var i:UInt = 0; i < UInt(self.headerImageView.frame.size.height / 10); i++ {
            self.blurImages.addObject(self.headerImageView.image!.boxblurImageWithBlur(factor))
            factor += 0.04
        }
    }
    
}

extension UIImage {
    func boxblurImageWithBlur(blur: CGFloat) -> UIImage!{
        var _blur = blur
        let imageData:NSData = UIImageJPEGRepresentation(self, 1)!
        let destImage = UIImage(data: imageData)!
        
        if _blur < 0.0 || _blur > 1.0 {
            _blur = 0.5
        }
        var boxSize = Int(_blur * 40)
        // print("boxSize: \(boxSize)")
        boxSize = boxSize - (boxSize % 2) + 1
        
        let img:CGImageRef = destImage.CGImage!
        
        var error: vImage_Error!
        
        let inProvider:CGDataProviderRef = CGImageGetDataProvider(img)!
        
        let inBitmapData = CGDataProviderCopyData(inProvider)
        
        if inBitmapData == nil {
            print("inBitmapData == nil")
        }
        
        var inBuffer = vImage_Buffer(data: UnsafeMutablePointer<Void>(CFDataGetBytePtr(inBitmapData)),
            height: vImagePixelCount(CGImageGetHeight(img)),
            width: vImagePixelCount(CGImageGetWidth(img)),
            rowBytes: CGImageGetBytesPerRow(img))
        
        let pixelBuffer = malloc(CGImageGetBytesPerRow(img) * CGImageGetHeight(img))
        if pixelBuffer == nil {
            print("No pixelbuffer")
        }
        var outBuffer = vImage_Buffer(data: pixelBuffer,
            height: vImagePixelCount(CGImageGetHeight(img)),
            width: vImagePixelCount(CGImageGetWidth(img)),
            rowBytes: CGImageGetBytesPerRow(img))
        
        error = vImageBoxConvolve_ARGB8888(&inBuffer, &outBuffer, nil, 0, 0, UInt32(boxSize), UInt32(boxSize), nil, vImage_Flags(kvImageEdgeExtend))
        if error != 0 {
            print("\(error)")
        }
        let colorSpace: CGColorSpaceRef = CGColorSpaceCreateDeviceRGB()!;
        let bitmapInfo = CGImageAlphaInfo.NoneSkipLast.rawValue
        let ctx = CGBitmapContextCreate(outBuffer.data,
            Int(outBuffer.width),
            Int(outBuffer.height),
            8,
            outBuffer.rowBytes,
            colorSpace,
            bitmapInfo)
        
        let imageRef:CGImageRef = CGBitmapContextCreateImage(ctx)!
        
        let returnImage = UIImage(CGImage: imageRef)
        
        //clean up
        free(pixelBuffer)
        
        return returnImage
    }
}
