//
//  PhotoTurn.swift
//  Swift-图片轮播
//
//  Created by D_ttang on 15/5/26.
//  Copyright (c) 2015年 sen5labs. All rights reserved.
//

import UIKit

@IBDesignable
class PhotoTurn: UIView{

    var view: UIView!
    var nibName: String = "PhotoTurn"
    
    var scrollView: UIScrollView!
    var pageControl: UIPageControl!
    var timer: NSTimer!
    
    override init(frame: CGRect){
        super.init(frame: frame)
        setup()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    func setup(){
        view = loadViewFromNib()
        view.frame = self.bounds
        view.autoresizingMask = [UIViewAutoresizing.FlexibleWidth, UIViewAutoresizing.FlexibleHeight]
        self.addSubview(view)
        
        let scrollWidth = self.view.frame.width
        let scrollHeight = scrollWidth / 320 * 130
        
        print("xib \(scrollHeight)")
        
        scrollView = UIScrollView(frame: CGRectMake(0, 0, scrollWidth, scrollHeight))
        scrollView.delegate = self
        self.addSubview(self.scrollView)
        
        // 添加图片
        let width:CGFloat = scrollView.frame.width
        let height:CGFloat = scrollView.frame.height
        
        print("photo height \(height)")
        
        for var i:CGFloat = 1 ; i < 6; ++i{
            if i == 1{
                continue
            }
            let imageName:String = "img_0\(i)"
            
            let imageView = UIImageView()
            let x = (i - 1) * width
            imageView.image = UIImage(named: imageName)
            imageView.frame = CGRectMake(x, 0, width, height)
            scrollView.addSubview(imageView)
        }
        scrollView.pagingEnabled = true
        scrollView.contentSize = CGSizeMake(5 * width, 0)
        
        pageControl = UIPageControl(frame:CGRectMake( scrollWidth / 2 - 50, scrollHeight, 100, 20))
        pageControl.center = CGPoint(x: scrollWidth / 2, y: scrollHeight - 10)
        pageControl.layer.zPosition = 100
        pageControl.numberOfPages = 5
      
        pageControl.currentPageIndicatorTintColor = UIColor.orangeColor()
        pageControl.pageIndicatorTintColor = UIColor.grayColor()
        
        self.addSubview(pageControl)
        
        self.addScrollTimer()
    }
    
    func loadViewFromNib() -> UIView {
        let bundle = NSBundle(forClass: self.dynamicType)
        let nib = UINib(nibName: nibName, bundle: bundle)
        let view  = nib.instantiateWithOwner(self, options: nil)[0] as! UIView
        return view
    }
}

extension PhotoTurn: UIScrollViewDelegate {
    // 添加时间计时器
    func addScrollTimer(){
        timer = NSTimer.scheduledTimerWithTimeInterval(2.0, target:self, selector:"nextPage", userInfo:nil, repeats:true)
    }
    
    // 移除时间计时器
    func removeScrollTimer(){
        
        timer.invalidate()
        timer = nil
    }
    
    // 下一页自动轮播
    func nextPage(){
        
        var currentPage = CGFloat(pageControl.currentPage)
        currentPage++
        if currentPage == 5 {
            currentPage = 0
        }
        let width:CGFloat = scrollView.frame.width
        let offset:CGPoint = CGPointMake(currentPage * width, 0)
        
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.scrollView.contentOffset = offset
        })
        
    }
    // scrollView的代理方法
    // 结束滚动
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let offset:CGPoint = self.scrollView.contentOffset
        let offsetX:CGFloat = offset.x;
        let width:CGFloat = self.scrollView.frame.width
        self.pageControl.currentPage = (Int(offsetX + 0.5 * width) / Int(width))
    }
    // 开始拖拽
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.removeScrollTimer()
    }
    
    // 结束拖拽
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.addScrollTimer()
    }
}

