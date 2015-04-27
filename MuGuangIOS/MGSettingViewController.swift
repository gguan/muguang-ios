//
//  MGSettingViewController.swift
//  MuGuangIOS
//
//  Created by ZhangHao on 15/4/27.
//  Copyright (c) 2015年 北京目光璀璨科技有限公司. All rights reserved.
//

import UIKit

class MGSettingViewController: MGBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var label = UIScrollView(frame: CGRectMake(0, -20, self.view.frame.size.width, 500))
        label.backgroundColor = UIColor.clearColor()
        label.contentSize = CGSizeMake(0, 1000)
        self.view.addSubview(label)
        var lll = UILabel(frame: CGRectMake(0, 0, 320, 40))
        lll.backgroundColor = UIColor.blackColor()
        label.addSubview(lll)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
