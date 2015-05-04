//
//  MGTool.swift
//  MuGuangIOS
//
//  Created by William Hu on 5/4/15.
//  Copyright (c) 2015 北京目光璀璨科技有限公司. All rights reserved.
//

import Foundation

class MGTool {
    
    static let sharedInstance = MGTool()
    
    init() {
        println("AAA");
    }
    
    func test () {
        println ("I am test")
    }
    
    /* 授权失败时候弹出授权界面 */
    
    func popAuthPage (nav: UINavigationController!) {
        
        var mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        var launchingVC = mainStoryboard.instantiateViewControllerWithIdentifier("MGLaunchingViewController") as! MGLaunchingViewController
        launchingVC.testBlcok = {() -> Void in
            //println("i am block")
        }
        nav.pushViewController(launchingVC, animated: false)
    }
}