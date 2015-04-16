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
    lazy var cameraView: MGCameraView = {
        var camera = MGCameraView(frame: CGRectZero)
        return camera
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(self.cameraView)
        self.cameraView.mas_makeConstraints { make in
            make.edges.equalTo()(self.view)
        }
    }
}
