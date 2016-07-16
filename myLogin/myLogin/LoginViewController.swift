//
//  LoginViewController.swift
//  myLogin
//
//  Created by D_ttang on 15/6/18.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import UIKit


let kMMRingStrokeAnimationKey = "mmmaterialdesignspinner.stroke"
let kMMRingRotationAnimationKey = "mmmaterialdesignspinner.rotation"

class LoginViewController: UIViewController {

    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var userName: MKTextField!
    @IBOutlet weak var password: MKTextField!
    @IBOutlet weak var bgImage: UIImageView!
    
    @IBOutlet weak var userLabel: UILabel!
    @IBOutlet weak var pwdLabel: UILabel!
    
    let requestUrl = "http://107.150.96.151/api/me/login"
    var initBtnFrame: CGRect?
    var lastBtnFrame: CGRect?
    let ovalShapeLayer: CAShapeLayer = CAShapeLayer()
    var loginInitCenter: CGPoint?
    
    let loginTransitionDelegate = LoginTransitionDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initBtnFrame = loginBtn.frame
        initMKElement()
    }
    
    override func viewWillAppear(animated: Bool) {
        if let firstInitBtnFrame = initBtnFrame {
            loginBtn.frame = firstInitBtnFrame
            loginBtn.enabled = true
            loginBtn.setTitle("Login", forState: UIControlState.Normal)
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Action

    @IBAction func LoginAction(sender: AnyObject) {
        let userNameValue = userName.text!
        let passwordValue = password.text!
        
        // print("\(userNameValue)..\(passwordValue)...loging...")
        // print("\(userNameValue.characters.count)")
        
        UIView.animateWithDuration(0.3, animations: {
            self.registerBtn.layer.zPosition = -1
            
            self.loginInitCenter = self.loginBtn.center
            
            self.loginBtn.center.x = self.view.center.x
            
            self.loginBtn.bounds.size.width = self.loginBtn.frame.size.height
            self.loginBtn.setTitle("", forState: UIControlState.Normal)
            self.loginBtn.enabled = false
            self.lastBtnFrame = self.loginBtn.frame
            self.giveLoginBtnShadow()
            }, completion: {
                _ in
                self.addMMSpinner()
//                LoginStatus.saveStatusToPlist()
//                self.changeToMainView()
                
                let requestBody = ["userName": userNameValue, "password": passwordValue]
                MyHTTPHandler.post(self.requestUrl, params: requestBody){
                    
                    data, err in
                    dispatch_async(dispatch_get_main_queue(), {
                        // code here
                        let jsonParsed: AnyObject!
                        if err != nil {
                            self.displayAlert("client goes wrong")
                            return
                        }
                        
                         let strData = NSString(data: data!, encoding: NSUTF8StringEncoding)
                        print("\(strData)")
                        do {
                            jsonParsed = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions())
                            // print("json\(jsonParsed)")
                        }catch _ {
                            print("err")
                            self.displayAlert("parse json goes wrong")
                            self.backLoginBtn()
                            return
                        }
                        
                        
                        let jsonResult = JSONValue.fromObject(jsonParsed)!
                        let success = jsonResult["success"]?.bool
                        if success == true {
                            LoginStatus.saveStatusToPlist()
                            self.changeToMainView()
                        }else {
                            self.displayAlert("password is wrong")
                            self.backLoginBtn()
                        }
                    })
                    
                }
                

        })
    }
    
    func changeToMainView(){

        let MainView = storyboard!.instantiateViewControllerWithIdentifier("MainViewController") as! MainViewController
        MainView.firstIn = true
        MainView.addButtonFrame = self.lastBtnFrame!
//        MainView.addButtonLayer = self.loginBtn.layer
        MainView.transitioningDelegate = loginTransitionDelegate
        // presentViewController(MainView, animated: true, completion: nil)
        presentViewController(MainView, animated: false, completion: nil)
    }

    func initMKElement(){
        
        let blurEffect = UIBlurEffect(style: .ExtraLight)
        let blurView = UIVisualEffectView(effect: blurEffect)
        // blurView.frame.size = CGSize(width: 200, height: 200)
        blurView.frame = bgImage.frame
        // blurView.center = view.center
        bgImage.addSubview(blurView)
        loginBtn.layer.cornerRadius = CGRectGetHeight(self.loginBtn.frame) / 2
        registerBtn.layer.cornerRadius = CGRectGetHeight(self.registerBtn.frame) / 2
        
        userName.layer.borderColor = UIColor.clearColor().CGColor
        userName.floatingPlaceholderEnabled = true
        userName.placeholder = "user name"
        userName.tintColor = UIColor.MKColor.BlueGrey
        userName.rippleLocation = .Right
        userName.cornerRadius = 0
        userName.bottomBorderEnabled = true
        
        
        password.layer.borderColor = UIColor.clearColor().CGColor
        password.floatingPlaceholderEnabled = true
        password.placeholder = "password"
        password.tintColor = UIColor.MKColor.BlueGrey
        password.rippleLocation = .Right
        password.cornerRadius = 0
        password.bottomBorderEnabled = true
        
        userLabel.font = UIFont(name: GoogleIconName, size: 30.0)
        // userLabel.textColor = UIColor.greenColor()
        userLabel.textColor = UIColor.MKColor.BlueGrey
        userLabel.text = GoogleIcon.ec6c
        
        pwdLabel.font = UIFont(name: GoogleIconName, size: 30.0)
        pwdLabel.textColor = UIColor.MKColor.BlueGrey
        pwdLabel.text = GoogleIcon.e671
    }
    
    func giveLoginBtnShadow(){
        loginBtn.layer.shadowColor = UIColor.blackColor().CGColor
        loginBtn.layer.shadowOpacity = 0.75
        loginBtn.layer.shadowRadius = 5.0
        loginBtn.layer.shadowOffset = CGSize(width: 0, height: 1.5)
    }
    func removeLoginBtnShadow(){
        loginBtn.layer.shadowColor = UIColor.clearColor().CGColor
        loginBtn.layer.shadowOpacity = 0
        loginBtn.layer.shadowRadius = 0
        loginBtn.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
    func displayAlert(message: String){
        let alertController = UIAlertController(title: "login", message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.Default,handler: {
                _ in
            
            }))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func resumeLoginBtn(){
        UIView.animateWithDuration(0.1, animations: {
                self.removeLoginBtnShadow()
                self.loginBtn.bounds.size.width = (self.initBtnFrame?.size.width)!
                self.loginBtn.enabled = true
                self.lastBtnFrame = self.loginBtn.frame
            
            }, completion: {
                _ in
                self.loginBtn.setTitle("Login", forState: UIControlState.Normal)
            })
    }
    
    func handleRequestResult(){
        
    }
    
    func addMMSpinner(){

        ovalShapeLayer.strokeColor = UIColor.whiteColor().CGColor
        ovalShapeLayer.fillColor = UIColor.clearColor().CGColor
        ovalShapeLayer.lineWidth = 2.0
        ovalShapeLayer.frame = CGRectMake(0, 0, self.loginBtn.frame.width, self.loginBtn.frame.height)
        //        ovalShapeLayer.backgroundColor = UIColor.orangeColor().CGColor
        let refreshRadius = self.loginBtn.frame.size.height/2 * 0.5
        let path = UIBezierPath(ovalInRect: CGRect(
            x: self.loginBtn.frame.size.width/2 - refreshRadius,
            y: self.loginBtn.frame.size.height/2 - refreshRadius,
            width: 2 * refreshRadius,
            height: 2 * refreshRadius))
        
        ovalShapeLayer.path = path.CGPath
        
        self.loginBtn.layer.addSublayer(ovalShapeLayer)
        beginRefreshing()
    }
    
    func beginRefreshing() {
        
        let animation = CABasicAnimation()
        //        CABasicAnimation *animation = [CABasicAnimation animation];
        animation.keyPath = "transform.rotation"
        animation.duration = 4.0;
        animation.fromValue = 0.0;
        animation.toValue = 2 * M_PI;
        animation.repeatCount = Float.infinity
        
        ovalShapeLayer.addAnimation(animation, forKey: kMMRingRotationAnimationKey)
        
        let headAnimation = CABasicAnimation()
        headAnimation.keyPath = "strokeStart"
        headAnimation.duration = 1.0;
        headAnimation.fromValue = 0.0;
        headAnimation.toValue = 0.25;
        
        
        let tailAnimation = CABasicAnimation()
        tailAnimation.keyPath = "strokeEnd"
        tailAnimation.duration = 1.0
        tailAnimation.fromValue = 0.0
        tailAnimation.toValue = 1.0
        tailAnimation.delegate = self
        
        
        let endHeadAnimation = CABasicAnimation()
        endHeadAnimation.keyPath = "strokeStart"
        endHeadAnimation.beginTime = 1.0
        endHeadAnimation.duration = 0.5
        endHeadAnimation.fromValue = 0.25
        endHeadAnimation.toValue = 1.0
        
        let endTailAnimation = CABasicAnimation()
        endTailAnimation.keyPath = "strokeEnd"
        endTailAnimation.beginTime = 1.0
        endTailAnimation.duration = 0.5
        endTailAnimation.fromValue = 1.0
        endTailAnimation.toValue = 1.0
        
        let animations = CAAnimationGroup()
        animations.duration = 1.5
        animations.animations = [headAnimation, tailAnimation, endHeadAnimation, endTailAnimation]
        animations.repeatCount = Float.infinity
        ovalShapeLayer.addAnimation(animations, forKey: kMMRingStrokeAnimationKey)
    }
    
    func stopAnimate(){
        
        ovalShapeLayer.removeAnimationForKey(kMMRingRotationAnimationKey)
        ovalShapeLayer.removeAnimationForKey(kMMRingStrokeAnimationKey)
        
    }
    
    func backLoginBtn(){
        
        self.loginBtn.center = loginInitCenter!
//        self.view.addSubview(self.registerBtn)
                    self.registerBtn.layer.zPosition = 0
        self.stopAnimate()
        self.ovalShapeLayer.removeFromSuperlayer()
        
        self.resumeLoginBtn()
    }
}
