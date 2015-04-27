//
//  MGLogInViewController.swift
//  MuGuangIOS
//
//  Created by William Hu on 15/4/15.
//  Copyright (c) 2015 北京目光璀璨科技有限公司. All rights reserved.
//

import UIKit

class MGLogInViewController: UIViewController, TGCameraDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        var sender: AnyObject = UIButton.buttonWithType(UIButtonType.Custom)
        //self.takePhoto(sender)
    }
    @IBAction func ssoAuth(sender: AnyObject) {
        var wbRequest         = WBAuthorizeRequest.request() as! WBAuthorizeRequest
        
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

    @IBAction func takePhoto(sender: AnyObject) {
        var nav = TGCameraNavigationController.newWithCameraDelegate(self)
        self.presentViewController(nav, animated: true, completion: nil)
    }
    
    // MARK: TGCamera Delegate Methods
    func cameraDidCancel() {
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    func cameraDidTakePhoto(image: UIImage!) {
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    func cameraDidSelectAlbumPhoto(image: UIImage!) {
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    @IBAction func publish(sender: AnyObject) {
        let nav = MGPublishViewController()
        self.presentViewController(nav, animated: true, completion: nil)
    }
}
