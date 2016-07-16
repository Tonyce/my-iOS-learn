//
//  MessagesViewController.swift
//  podLearn
//
//  Created by D_ttang on 15/10/12.
//  Copyright © 2015年 D_ttang. All rights reserved.
//

import Foundation
import JSQMessagesViewController


class MessagesViewController: JSQMessagesViewController {

    
    var userName = "tt"
    var avatars = Dictionary<String, UIImage>()
    var messages = [JSQMessage]()
    let incomingBubble = JSQMessagesBubbleImageFactory().incomingMessagesBubbleImageWithColor(UIColor(red: 10/255, green: 180/255, blue: 230/255, alpha: 1.0))
    let outgoingBubble = JSQMessagesBubbleImageFactory().outgoingMessagesBubbleImageWithColor(UIColor.lightGrayColor())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        automaticallyScrollsToMostRecentMessage = true
        for (var i = 0; i < 8; i++) {
            messages.append(JSQMessage(senderId: "ds", displayName: "ds", text: String(i)))
        }
        
//        if let savedUserName = NSUserDefaults.standardUserDefaults().stringForKey("userName") {
//            self.userName = savedUserName
//        } else {
//            self.userName = "user" + String(arc4random_uniform(UInt32.max))
//            NSUserDefaults.standardUserDefaults().setObject(self.userName, forKey: "userName")
//            NSUserDefaults.standardUserDefaults().synchronize()
//        }
        self.senderDisplayName = self.userName
        self.senderId = self.userName
        
    }
    
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
        let data = self.messages[indexPath.row]
        return data
    }
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
        let data = self.messages[indexPath.row]
        if (data.senderId == self.senderId) {
            return self.outgoingBubble
        } else {
            return self.incomingBubble
        }
    }
    
    
    override func collectionView(collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource! {

//        let message = messages[indexPath.item]
//        if let avatar = avatars[message.sender()] {
//            return UIImageView(image: avatar)
//        } else {
//            setupAvatarImage(message.sender(), imageUrl: message.imageUrl(), incoming: true)
//            return UIImageView(image:avatars[message.sender()])
//        }
        let data = self.messages[indexPath.row]
        if (data.senderId == self.senderId) {
            return JSQMessagesAvatarImage.avatarWithImage(UIImage(named: "swift"))
        } else {
//            return JSQMessagesAvatarImage.avatarWithImage(JSQMessagesAvatarImageFactory.circularAvatarHighlightedImage(UIImage(named: "swift"), withDiameter: 5))
            return JSQMessagesAvatarImageFactory.avatarImageWithImage(UIImage(named: "swift"), diameter: 200)
        }
    }
    
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: NSDate!) {
        let newMessage = JSQMessage(senderId: senderId, displayName: senderDisplayName, text: text)
        self.messages += [newMessage]
        JSQSystemSoundPlayer.jsq_playMessageSentSound()
//        self.finishReceivingMessage()
        finishSendingMessage()
    }
    
    override func didPressAccessoryButton(sender: UIButton!) {
        print("AccessoryButton...")
    }
}
