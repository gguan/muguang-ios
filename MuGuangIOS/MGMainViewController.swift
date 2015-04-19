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
    
    // 相机视图
    lazy var cameraView: MGCameraView = {
        var camera = MGCameraView(frame: CGRectZero)
        camera.addTapAction({ (isRunning) -> Void in
            if isRunning {
                camera.stopRunning()
            } else {
                camera.startRunning()
            }
        })
        return camera
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.view.addSubview(self.cameraView)
        
        /**
         *  添加布局
         */
        self.cameraView.mas_makeConstraints { make in
            make.edges.equalTo()(self.view)
        }
        
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        /**
         *  开始运行相机（页面出现时）
         */
        self.cameraView.startRunning()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        /**
         *  停止运行相机（页面消失后）
         */
        self.cameraView.stopRunning()
    }
}
