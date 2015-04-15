//
//  MGMainViewController.swift
//  MuGuangIOS
//
//  Created by ZH on 15/4/15.
//  Copyright (c) 2015年 北京目光璀璨科技有限公司. All rights reserved.
//

import UIKit

/**
 *  主页面
 */
class MGMainViewController: MGBaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var button: UIButton = UIButton(frame: CGRectZero);
        self.view.addSubview(button)
        button.mas_makeConstraints { make in
            make.center.equalTo()(self.view)
            return ()
        }
    }
}
