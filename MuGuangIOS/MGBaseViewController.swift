//
//  MGBaseViewController.swift
//  MuGuangIOS
//
//  Created by ZH on 15/4/15.
//  Copyright (c) 2015年 北京目光璀璨科技有限公司. All rights reserved.
//

import UIKit

/**
 *  自定义UIViewController的基类
 */
class MGBaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.barTintColor = UIColor.transformColor(kTextColorRed, alpha: 0.5)
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationController?.navigationBar.barStyle = .Black
        self.navigationController?.navigationBar.translucent = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // 重设返回按钮
    func resetBackButton() {
        var backButton = UIButton(frame: CGRectMake(0, 0, 30, 30))
        backButton.setImage(UIImage(named: "backArrow"), forState: .Normal)
        backButton.addTarget(self, action: Selector("methodForBackBarButton:"), forControlEvents: .TouchUpInside)
        var backItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.leftBarButtonItem = backItem
    }

    func methodForBackBarButton(button: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
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
