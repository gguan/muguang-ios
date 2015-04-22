//
//  MGCardDetailController.swift
//  MuGuangIOS
//
//  Created by ZhangHao on 15/4/21.
//  Copyright (c) 2015年 北京目光璀璨科技有限公司. All rights reserved.
//

import UIKit

class MGCardDetailController: MGBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        // back button
        var backButton: UIButton = UIButton(frame: CGRectZero)
        backButton.setTitle("Back", forState: .Normal)
        backButton.setTitleColor(UIColor.purpleColor(), forState: .Normal)
        backButton.addTarget(self, action: Selector("pop:"), forControlEvents: .TouchUpInside)
        self.view.addSubview(backButton)
        
        backButton.mas_makeConstraints { make in
            make.top.and().left().equalTo()(self.view).offset()(20)
            make.width.equalTo()(50)
            make.height.equalTo()(40)
        }
    }
    
    func pop(button: UIButton) {
        self.navigationController?.popViewControllerAnimated(true)
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
