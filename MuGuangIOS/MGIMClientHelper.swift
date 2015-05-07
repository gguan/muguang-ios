//
//  MGIMClientHelper.swift
//  MuGuangIOS
//
//  Created by ZhangHao on 15/5/6.
//  Copyright (c) 2015年 北京目光璀璨科技有限公司. All rights reserved.
//

import UIKit

let kLeanCloudApplicationId = "j779xk4d8nv0h6e4ihhd7e8s9oo71ctbjpnkp918tjxo0qzr"
let kLeanCloudClientKey = "jeriizum1hsc15qirhuqp42c8vdsfb71399qp9a5cnkf68rp"

// 一对一单聊
let kConversationType_OneOne = 0
// 多人群聊
let kConversationType_Group = 1

class MGIMClientHelper: NSObject, AVIMClientDelegate {
    
    // 单例
    class var shared: MGIMClientHelper {
        struct Inner {
            static var onceToken: dispatch_once_t = 0
            static var instance: MGIMClientHelper? = nil
        }
        dispatch_once(&Inner.onceToken) {
            Inner.instance = MGIMClientHelper()
        }
        return Inner.instance!
    }
    

    
    /**
    *  即时通讯客户端
    */
    lazy var imClient: AVIMClient = {
        var client = AVIMClient()
        return client
    }()
    
    /**
        初始化
    */
    class func setupClient() {
        
        // 设置LeanCloud
        AVOSCloud.setApplicationId(kLeanCloudApplicationId, clientKey: kLeanCloudClientKey)

        /**
        *  DEBUG模式下开启日志
        */
        #if DEBUG
            AVOSCloud.setVerbosePolicy(kAVVerboseShow)
            AVLogger.addLoggerDomain(AVLoggerDomainIM)
            AVLogger.addLoggerDomain(AVLoggerDomainCURL)
            AVLogger.setLoggerLevelMask(AVLoggerLevelAll.value)
        #endif

        // 登陆
        self.shared.loginLeanCloud()
    }
    

    /**
        登陆聊天服务器
    */
    func loginLeanCloud() {
        
        self.imClient.openWithClientId("M_ouse", callback: { (success, error) -> Void in
            
            if !success {
                
                // 登陆聊天服务器失败
                println("登陆聊天服务器失败: \(error?.description)")
                
            } else {
                
                // 登陆聊天服务器成功
                println("登陆聊天服务器成功")
                
                // 设置代理 - AVIMClientDelegate
                self.imClient.delegate = self
                
            }
            
        })
        
    }
    
    /**
        创建一个新的用户对话（在单聊的场合，传入对方一个 clientId 即可；群聊的时候，支持同时传入多个 clientId 列表）
    
        :param: name       会话名称
        :param: clientIds  聊天参与者（发起人除外）的 clientId 列表
        :param: attributes 会话的自定义属性
        :param: options    可选参数，可以使用或 “|” 操作表示多个选项
        :param: callback   对话建立之后的回调
    */
    func createConversation(name: String!, clientIds: [AnyObject]!, attributes: [NSObject : AnyObject]!, options: AVIMConversationOption, callback: AVIMConversationResultBlock!) {
        
        self.imClient.createConversationWithName(name, clientIds: clientIds, attributes: attributes, options: options) { (conversation, error) -> Void in
            
            if error != nil {
                
                println("创建对话失败: \(error?.description)")
                
            } else {
                
                // 创建对话成功
                callback(conversation, error)
                
            }
            
        }
        
    }
    
    /**
        发送消息
    */
    func sendMessage(conversation: AVIMConversation, message: AVIMMessage!, callback: AVIMBooleanResultBlock!) {
        
        conversation.sendMessage(message) { (success, error) -> Void in
            
        }
        
    }
    
    // MARK: - AVIMClientDelegate
    // 收到消息
    func conversation(conversation: AVIMConversation!, didReceiveCommonMessage message: AVIMMessage!) {
        
        println("receive message ===== \(message)")
        
    }

}
