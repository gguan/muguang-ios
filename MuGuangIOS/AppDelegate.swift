//
//  AppDelegate.swift
//  MuGuangIOS
//
//  Created by William Hu on 15/4/15.
//  Copyright (c) 2015 William Hu. All rights reserved.
//

import UIKit

let kSampleImageName = "duckling.jpg"
@UIApplicationMain

class AppDelegate: UIResponder, UIApplicationDelegate, WeiboSDKDelegate {

    let ShareAppKey     = "6bfabdd0c3f3"
    let ShareAppSecret  = "2b9631dc59bb449cfb475480410bd071"
    
    let SinaAppKey      = "3927488598"
    let SinaAppSecret   = "4935c913baa5146cf1cd1f5757e350e4"
    
    let Camera360Key    = "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"

    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        //Share SDK
        //ShareSDK.registerApp(ShareAppKey)
        
        //微博SDK
        WeiboSDK.enableDebugMode(true)
        WeiboSDK.registerApp(SinaAppKey)
        
        //程序主体颜色
        //window?.tintColor = UIColor.redColor()
        
        //Camera360
        pg_edit_sdk_controller.sStart(Camera360Key)
        
        let editCtl : pg_edit_sdk_controller?
        
        
        return true
    }

    
    
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool {
        return WeiboSDK.handleOpenURL(url, delegate: self)
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject?) -> Bool {
        return WeiboSDK.handleOpenURL(url, delegate: self)
    }
    
    //MARK: 新浪微博代理方法
    func didReceiveWeiboRequest(request: WBBaseRequest!) {
        
    }
    
    func didReceiveWeiboResponse(response: WBBaseResponse!) {
        //response.userInfo["acesss_token"]
    }
    
}

