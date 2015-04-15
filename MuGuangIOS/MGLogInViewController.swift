//
//  MGLogInViewController.swift
//  MuGuangIOS
//
//  Created by William Hu on 15/4/15.
//  Copyright (c) 2015 北京目光璀璨科技有限公司. All rights reserved.
//

import UIKit

class MGLogInViewController: UIViewController {
    let SinaRedirectURI = "http://ec2-54-223-171-74.cn-north-1.compute.amazonaws.com.cn:9000/auth"
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func ssoAuth(sender: AnyObject) {
        var wbRequest = WBAuthorizeRequest.request() as WBAuthorizeRequest
        
        wbRequest.redirectURI = SinaRedirectURI
        
        wbRequest.scope       = "all"
        
        wbRequest.userInfo    = ["SSO_From": "SendMessageToWeiboViewController",
                             "Other_Info_1": 123,
                             "Other_Info_2": ["obj1", "obj2"],
                             "Other_Info_3": ["key1": "obj1", "key2": "obj2"]]
        
        WeiboSDK.sendRequest(wbRequest)
    }
    
    // 跳转到主页面
    @IBAction func pushMainViewController(sender: AnyObject) {
        var mainViewCoontroller = MGMainViewController();
        self.presentViewController(mainViewCoontroller, animated: true, completion: nil)
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
