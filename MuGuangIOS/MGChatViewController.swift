//
//  MGChatViewController.swift
//  MuGuangIOS
//
//  Created by ZhangHao on 15/5/5.
//  Copyright (c) 2015年 北京目光璀璨科技有限公司. All rights reserved.
//

import UIKit

class MGChatViewController: JSQMessagesViewController {

    var dataSource: Array<JSQMessage> = []
    var avatars: Array<JSQMessagesAvatarImage> = []
    
    var outgoingBubbleImageData: JSQMessagesBubbleImage?
    var incomingBubbleImageData: JSQMessagesBubbleImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // 用户ID
        self.senderId = "A"
        // 用户昵称
        self.senderDisplayName = "B"
        
        var bubbleFactory: JSQMessagesBubbleImageFactory = JSQMessagesBubbleImageFactory()
        // 自己消息的气泡样式
        self.outgoingBubbleImageData = bubbleFactory.outgoingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleLightGrayColor())
        // 受到消息的气泡样式
        self.incomingBubbleImageData = bubbleFactory.outgoingMessagesBubbleImageWithColor(UIColor.jsq_messageBubbleGreenColor())
        
        // 假数据
        var message: JSQMessage = JSQMessage(senderId: "诸葛亮", senderDisplayName: "诸葛亮", date: NSDate(), text: "知天易，逆天难。")
        self.dataSource.append(message)
        var wozImage: JSQMessagesAvatarImage = JSQMessagesAvatarImageFactory.avatarImageWithImage(UIImage(named: "avatar_placeholder"), diameter: UInt(kJSQMessagesCollectionViewAvatarSizeDefault))
        self.avatars.append(wozImage)
        
        var message1: JSQMessage = JSQMessage(senderId: "诸葛亮", senderDisplayName: "诸葛亮", date: NSDate(timeIntervalSinceNow: 60 * 12), text: "观今夜天象，知天下大事。")
        self.dataSource.append(message1)
        var wozImage1: JSQMessagesAvatarImage = JSQMessagesAvatarImageFactory.avatarImageWithImage(UIImage(named: "avatar_placeholder"), diameter: UInt(kJSQMessagesCollectionViewAvatarSizeDefault))
        self.avatars.append(wozImage1)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
        发送
    */
    override func didPressSendButton(button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: NSDate!) {
        
        // 发送的消息
        var message: JSQMessage = JSQMessage(senderId: senderId, senderDisplayName: senderDisplayName, date: date, text: text)
        // 缓存消息
        self.dataSource.append(message)
        
        // 头像
        var wozImage: JSQMessagesAvatarImage = JSQMessagesAvatarImageFactory.avatarImageWithImage(UIImage(named: "avatar_placeholder"), diameter: UInt(kJSQMessagesCollectionViewAvatarSizeDefault))
        self.avatars.append(wozImage)
        
        self.finishSendingMessageAnimated(true)
    }
    
    /**
        表情
    */
    override func didPressAccessoryButton(sender: UIButton!) {
        
    }
    
    // MARK: - JSQMessages CollectionView DataSource
    /**
        消息内容
    */
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageData! {
        return self.dataSource[indexPath.item]
    }
    
    /**
        头像
    */
    override func collectionView(collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageAvatarImageDataSource! {
        return self.avatars[indexPath.item]
    }
    
    /**
        气泡样式
    */
    override func collectionView(collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAtIndexPath indexPath: NSIndexPath!) -> JSQMessageBubbleImageDataSource! {
        
        var message: JSQMessage = self.dataSource[indexPath.item]
        
        if message.senderId == self.senderId {
            return self.outgoingBubbleImageData;
        }

        return self.outgoingBubbleImageData
    }
    
    /**
        行数
    */
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    /**
        cell样式
    */
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = super.collectionView(collectionView, cellForItemAtIndexPath: indexPath) as! JSQMessagesCollectionViewCell
        
        var msg: JSQMessage = self.dataSource[indexPath.item]
        
        let attributes : [NSObject:AnyObject] = [NSForegroundColorAttributeName:cell.textView.textColor, NSUnderlineStyleAttributeName: 1]
        cell.textView.linkTextAttributes = attributes
        return cell
    }
    
    /**
        姓名label的高度
    */
    override func collectionView(collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForMessageBubbleTopLabelAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return kJSQMessagesCollectionViewCellLabelHeightDefault
    }
    
    /**
        时间lable的高度
    */
    override func collectionView(collectionView: JSQMessagesCollectionView!, layout collectionViewLayout: JSQMessagesCollectionViewFlowLayout!, heightForCellTopLabelAtIndexPath indexPath: NSIndexPath!) -> CGFloat {
        return kJSQMessagesCollectionViewCellLabelHeightDefault
    }
    
    /**
        时间
    */
    override func collectionView(collectionView: JSQMessagesCollectionView!, attributedTextForCellTopLabelAtIndexPath indexPath: NSIndexPath!) -> NSAttributedString! {
        var message: JSQMessage = self.dataSource[indexPath.item]
        return JSQMessagesTimestampFormatter.sharedFormatter().attributedTimestampForDate(message.date)
    }
    
    /**
        姓名
    */
    override func collectionView(collectionView: JSQMessagesCollectionView!, attributedTextForMessageBubbleTopLabelAtIndexPath indexPath: NSIndexPath!) -> NSAttributedString! {
        
        var message: JSQMessage = self.dataSource[indexPath.item]

        if message.senderId == self.senderId {
            return nil
        }
        
        if indexPath.item - 1 > 0 {
            var previousMessage: JSQMessage = self.dataSource[indexPath.item - 1]

            if previousMessage.senderId == message.senderId {
                return nil
            }
        }
        
        /**
        *  Don't specify attributes to use the defaults.
        */
        return NSAttributedString(string: message.senderDisplayName)
    }

    // MARK: - Responding to collection view tap events
    /**
        点击头像
    */
    override func collectionView(collectionView: JSQMessagesCollectionView!, didTapAvatarImageView avatarImageView: UIImageView!, atIndexPath indexPath: NSIndexPath!) {
        println("did tap avatar")
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
