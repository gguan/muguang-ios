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

    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        //Share SDK
        ShareSDK.registerApp(ShareAppKey)
        
        //微博SDK
        WeiboSDK.enableDebugMode(true)
        WeiboSDK.registerApp(SinaAppKey)
        
        //程序主体颜色
        //window?.tintColor = UIColor.redColor()
        
//获取新浪用户信息
//        
//        MGAPIManager.sharedInstance.sinaAuthInfo(uid, accessToken: accessToken, success: { (operation:AFHTTPRequestOperation!, responseData:AnyObject!) -> Void in
//            
//            println(operation.responseObject)
//            
//            },failure: { (operation:AFHTTPRequestOperation!, error:NSError!) -> Void in
//                
//        });
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
        
        if response != nil {
            
            //保存新浪微博有用的信息
            
            let uid: AnyObject?            = response.userInfo["uid"]
            let accessToken: AnyObject?    = response.userInfo["access_token"]
            let refreshToken: AnyObject?   = response.userInfo["refresh_token"];
            
            
            if let app: AnyObject  = response.userInfo["app"] {
                let name           = app["name"]            // 应用名字
                let logo           = app["logo"]            // 应用logo
            }
            
            if uid != nil && accessToken != nil && refreshToken != nil {
                NSUserDefaults.standardUserDefaults().setObject(uid, forKey: "uid")
                NSUserDefaults.standardUserDefaults().setObject(accessToken,  forKey: "access_token")
                NSUserDefaults.standardUserDefaults().setObject(refreshToken, forKey: "refresh_token")
                
                //注册用户
                MGAPIManager.sharedInstance.registerUser(uid as! String,
                    accessToken: accessToken as! String,
                    refreshToken: refreshToken as! String,
                    success: { (operation: AFHTTPRequestOperation!, response:AnyObject!) -> Void in
                        println(operation.response.URL)
                    },
                    failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                        println(operation.response.URL,operation.responseObject,operation.response.statusCode)
                })
            }
            
            
        }
    }
    
}

