//
//  MainViewController.swift
//  Swift-图片轮播
//
//  Created by on 14-10-10.
//  Copyright (c) 2014年 . All rights reserved.
//

// 模拟器不能运行的话，请在iOS8的真机上运行

import UIKit

class MainViewController: UIViewController,UIScrollViewDelegate {

    var photoView: PhotoTurn!
    var scrollView: UIScrollView!
    var pageControl: UIPageControl!
    var timer: NSTimer!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scrollWidth = self.view.frame.width
        let scrollHeight = scrollWidth / 320 * 130
        
        print("main \(scrollHeight)")
        scrollView = UIScrollView(frame: CGRectMake(0, 20, scrollWidth, scrollHeight))
        scrollView.delegate = self
        self.view.addSubview(self.scrollView)
        
        photoView = PhotoTurn(frame: CGRectMake(0, scrollHeight + 20, scrollWidth, scrollHeight))
        self.view.addSubview(photoView)
        
    // 添加图片
        let width:CGFloat = scrollView.frame.width
        let height:CGFloat = scrollView.frame.height
        
        for var i:CGFloat = 1 ; i < 6; ++i{
            let imageName:String = "img_0\(i)"
            
            let imageView = UIImageView()
            let x = (i - 1) * width
            imageView.image = UIImage(named: imageName)
            imageView.frame = CGRectMake(x, 0, width, height)
            scrollView!.addSubview(imageView)
        }
        scrollView.pagingEnabled = true
        scrollView.contentSize = CGSizeMake(5 * width, 0)
        
        pageControl = UIPageControl(frame:CGRectMake( scrollWidth / 2 - 50, scrollHeight, 100, 20))
        pageControl.center = CGPoint(x: scrollWidth / 2, y: scrollHeight)
        pageControl.layer.zPosition = 100
        pageControl.numberOfPages = 5
        
        pageControl.currentPageIndicatorTintColor = UIColor.orangeColor()
        pageControl.pageIndicatorTintColor = UIColor.grayColor()
        
        
        self.view.addSubview(pageControl)
        
        self.addScrollTimer()
    }
    
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

