//
//  MGLaunchingViewController.swift
//  MuGuangIOS
//
//  Created by William Hu on 4/23/15.
//  Copyright (c) 2015 北京目光璀璨科技有限公司. All rights reserved.
//

import UIKit

class MGLaunchingViewController: UIViewController {

    @IBOutlet weak var moveImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    func moveBackgroundImage () {
        UIView.animateWithDuration(25, delay: 0.0, options: .Autoreverse | .Repeat | .CurveLinear , animations: { () -> Void in
            self.moveImageView.center.x += 1300
            //self.moveImageView.transform = CGAffineTransformRotate(self.moveImageView.transform, 90.0)
            }, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.moveBackgroundImage()
    }
    @IBAction func sinaLogin(sender: AnyObject) {
        
        var wbRequest = WBAuthorizeRequest.request() as! WBAuthorizeRequest
        
        wbRequest.redirectURI = SinaRedirectURI
        
        wbRequest.scope       = "all"
        
        //可以不填写
        wbRequest.userInfo    = ["SSO_From": "SendMessageToWeiboViewController",
            "Other_Info_1": 123,
            "Other_Info_2": ["obj1", "obj2"],
            "Other_Info_3": ["key1": "obj1", "key2": "obj2"]]
        
        WeiboSDK.sendRequest(wbRequest)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func testAction(sender: AnyObject) {
        let mainVC = MGMainViewController()
        self.presentViewController(mainVC, animated: false, completion:nil)
    }

}
