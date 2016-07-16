//
//  ViewController.swift
//  myChat
//
//  Created by D_ttang on 15/2/19.
//  Copyright (c) 2015年 D_ttang. All rights reserved.
//

import UIKit

//class ViewController: UIViewController {
class ViewController: JSQMessagesViewController{
    
    var client:TcpClientSocket!
    var clientStatus = (success: false, errmsg: "")
    var button: UIButton!
    
    var messages = [Message]()
    var avatars = Dictionary<String, UIImage>()
    var outgoingBubbleImageView = JSQMessagesBubbleImageFactory.outgoingMessageBubbleImageViewWithColor(UIColor.jsq_messageBubbleLightGrayColor())
    var incomingBubbleImageView = JSQMessagesBubbleImageFactory.incomingMessageBubbleImageViewWithColor(UIColor.jsq_messageBubbleGreenColor())
    var senderImageUrl: String!
    var batchMessages = true
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        inputToolbar!.contentView!.leftBarButtonItem = nil
        automaticallyScrollsToMostRecentMessage = true
        
        sender = (sender != nil) ? sender : "Anonymous"
        
        self.client = TcpClientSocket(addr: "127.0.0.1", port: 1337);
        clientStatus = client.connect(timeout: 1)
        resive()
        
//        button = UIButton.buttonWithType(.System) as? UIButton
//        button.frame = CGRect(x: 110, y: 70, width: 100, height: 44)
//        button.setTitle("Press Me", forState: .Normal)
//        button.setTitle("I'm Pressed", forState: .Highlighted)
//        button.addTarget(self, action: "buttonIsPressed:", forControlEvents: .TouchDown)
//        view.addSubview(button)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
    }
    
    func setupAvatarImage(name: String, imageUrl: String?, incoming: Bool) {
        if imageUrl == nil ||  countElements(imageUrl!) == 0 {
            setupAvatarColor(name, incoming: incoming)
            return
        }
        
        let diameter = incoming ? UInt(collectionView!.collectionViewLayout.incomingAvatarViewSize.width) : UInt(collectionView!.collectionViewLayout.outgoingAvatarViewSize.width)
        
        let url = NSURL(string: imageUrl!)
        let image = UIImage(data: NSData(contentsOfURL: url!)!)
        let avatarImage = JSQMessagesAvatarFactory.avatarWithImage(image, diameter: diameter)
        
        avatars[name] = avatarImage
    }
    
    func setupAvatarColor(name: String, incoming: Bool) {
            let diameter = incoming ? UInt(collectionView!.collectionViewLayout.incomingAvatarViewSize.width) : UInt(collectionView!.collectionViewLayout.outgoingAvatarViewSize.width)
            
            let rgbValue = name.hash
            let r = CGFloat(Float((rgbValue & 0xFF0000) >> 16)/255.0)
            let g = CGFloat(Float((rgbValue & 0xFF00) >> 8)/255.0)
            let b = CGFloat(Float(rgbValue & 0xFF)/255.0)
            let color = UIColor(red: r, green: g, blue: b, alpha: 0.5)
            
            let nameLength = countElements(name)
            let initials : String? = name.substringToIndex(advance(sender.startIndex, min(3, nameLength)))
            let userImage = JSQMessagesAvatarFactory.avatarWithUserInitials(initials, backgroundColor: color, textColor: UIColor.blackColor(), font: UIFont.systemFontOfSize(CGFloat(13)), diameter: diameter)
            
            avatars[name] = userImage
    }
    
    
    func sendMessage(text: String!, sender: String!) {
        print("string : \(text) : \(sender)")
        let message = Message(text: text, sender: sender, imageUrl: senderImageUrl)
        messages.append(message)
        if clientStatus.success{
        //发送数据
            var (success,errmsg)=client.send(str:text)
            if success{
                print("the data has been send success")
            }else{
                print(errmsg)
            }
        }else{
            print(clientStatus.errmsg)
        }
    }
    
    // ACTIONS
    
    func receivedMessagePressed(sender: UIBarButtonItem) {
        // Simulate reciving message
        showTypingIndicator = !showTypingIndicator
        scrollToBottomAnimated(true)
    }
    
    override func didPressSendButton(button: UIButton!, withMessageText text: String!, sender: String!, date: NSDate!) {
        JSQSystemSoundPlayer.jsq_playMessageSentSound()
        sendMessage(text, sender: sender)
        finishSendingMessage()
    }
    
    override func didPressAccessoryButton(sender: UIButton!) {
        print("Camera pressed!")
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, bubbleImageViewForItemAtIndexPath indexPath: NSIndexPath!) -> UIImageView! {
        let message = messages[indexPath.item]
        
        if message.sender() == sender {
        return UIImageView(image: outgoingBubbleImageView.image, highlightedImage: outgoingBubbleImageView.highlightedImage)
        }
        
        return UIImageView(image: incomingBubbleImageView.image, highlightedImage: incomingBubbleImageView.highlightedImage)
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, avatarImageViewForItemAtIndexPath indexPath: NSIndexPath!) -> UIImageView! {
            let message = messages[indexPath.item]
            if let avatar = avatars[message.sender()] {
            return UIImageView(image: avatar)
        } else {
            setupAvatarImage(message.sender(), imageUrl: message.imageUrl(), incoming: true)
            return UIImageView(image:avatars[message.sender()])
            }
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
                return messages.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAtIndexPath: indexPath) as! JSQMessagesCollectionViewCell
        
        let message = messages[indexPath.item]
        if message.sender() == sender {
            cell.textView!.textColor = UIColor.blackColor()
        } else {
            cell.textView!.textColor = UIColor.whiteColor()
        }
        
        let attributes  = [NSForegroundColorAttributeName:cell.textView!.textColor, NSUnderlineStyleAttributeName: 1]
        cell.textView!.linkTextAttributes = attributes as [String:AnyObject]
        
        //        cell.textView.linkTextAttributes = [NSForegroundColorAttributeName: cell.textView.textColor,
        //            NSUnderlineStyleAttributeName: NSUnderlineStyle.StyleSingle]
        return cell
    }
    
    
    // View  usernames above bubbles
    override func collectionView(collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAtIndexPath indexPath: NSIndexPath!) -> NSAttributedString! {
            let message = messages[indexPath.item];
            
            // Sent by me, skip
            if message.sender() == sender {
        return nil;
            }
            
            // Same as previous sender, skip
            if indexPath.item > 0 {
                let previousMessage = messages[indexPath.item - 1];
                if previousMessage.sender() == message.sender() {
                return nil;
                }
            }
            
            return NSAttributedString(string:message.sender())
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
                let message = messages[indexPath.item]
                
                // Sent by me, skip
                if message.sender() == sender {
        return CGFloat(0.0);
                }
                
                // Same as previous sender, skip
                if indexPath.item > 0 {
                    let previousMessage = messages[indexPath.item - 1];
                    if previousMessage.sender() == message.sender() {
                    return CGFloat(0.0);
                    }
                }
                
                return kJSQMessagesCollectionViewCellLabelHeightDefault
    }
    
    
    func buttonIsPressed(sender: UIButton){
        if clientStatus.success{
            //发送数据
            var (success,errmsg)=client.send(str:"hello i am send by swift" )
            if success{
                print("the data has been send success")
            }else{
                print(errmsg)
            }
        }else{
            print(clientStatus.errmsg)
        }
    }
    
    func resive() {
        let readFromServer = dispatch_queue_create("readFromServer",nil)
        dispatch_async(readFromServer,{
            while self.clientStatus.success {
                let data = self.client.read(1024*10)
                if let d = data{
                    if let str = String(CString: d, encoding: NSUTF8StringEncoding){
                        print(str)
                        let message = Message(text: str, sender: "me", imageUrl: self.senderImageUrl)
                        self.messages.append(message)
                        self.finishReceivingMessage()
                    }
                }
                self.clientStatus = self.client.connect(timeout: 1)
            }
            
            print("disconnect from server")
            //返回主线程
            dispatch_sync(dispatch_get_main_queue(), {
                print("是否是主线程\(NSThread.isMainThread())")
            })
        })
    }
}



func testtcpclient(){
            //创建socket
    let client:TcpClientSocket = TcpClientSocket(addr: "127.0.0.1", port: 1337)
            //连接
    var (success,errmsg)=client.connect(timeout: 1)
    if success{
                //发送数据
        var (success,errmsg)=client.send(str:"hello i am send by swift" )
        if success{
    //读取数据
            let data = client.read(1024*10)
            if let d = data{
                if let str = String(CString: d, encoding: NSUTF8StringEncoding){
                    print(str)
                }
            }
        }else{
            print(errmsg)
        }
    }else{
        print(errmsg)
    }
}

