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
    
    // 模糊背景
    let pictureView: UIImageView = UIImageView(frame: CGRectZero)
    let blurView: FXBlurView = FXBlurView(frame: CGRectZero)
    // 相机视图
    let cameraView: MGCameraView = MGCameraView(frame: CGRectZero)
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        pictureView.hidden = true
        blurView.hidden = true
        blurView.userInteractionEnabled = false
        cameraView.addTapAction { (isRunning) -> Void in
            if isRunning {
                // 拍照
                self.cameraView.takePhoto({ (aImage) -> Void in
                    self.pictureView.image = aImage
                    self.pictureView.hidden = false
                    self.blurView.hidden = false
//                    UIView.animateWithDuration(2, animations: { () -> Void in
//                        self.blurView.blurRadius = 40
//                    })
                    
                    UIView.animateWithDuration(2, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                        self.blurView.blurRadius = 40
                    }, completion: { (finsih) -> Void in
                        
                    })
                    
//                    if let image = aImage {
//                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
//                            var context = CIContext(options: nil)
//                            var inputImage = CIImage(image: image)
//                            var filter = CIFilter(name: "CIGaussianBlur", withInputParameters: [kCIInputImageKey:inputImage, "inputRadius" : 10])
//                            var outputImage = filter.outputImage
//                            var outImage = context.createCGImage(outputImage, fromRect: outputImage.extent())
//                            
//                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                                self.blurView.image = UIImage(CGImage: outImage)
//                                self.blurView.hidden = false
//                            })
//                        })
//                    }
                })
                self.cameraView.stopRunning()
            } else {
                self.cameraView.startRunning()
                self.pictureView.hidden = true
                self.blurView.hidden = true
                self.blurView.blurRadius = 0
            }
        }
        
        self.view.addSubview(self.cameraView)
        self.view.addSubview(self.pictureView)
        self.view.addSubview(self.blurView)
        /**
         *  添加布局
         */
        self.cameraView.mas_makeConstraints { make in
            make.edges.equalTo()(self.view)
        }
        
        self.pictureView.mas_makeConstraints { make in
            make.edges.equalTo()(self.view)
        }
        
        self.blurView.mas_makeConstraints { make in
            make.edges.equalTo()(self.view)
        }
        
    }
    
    func getImageFromView(view: UIView!) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, true, view.layer.contentsScale)
        view.layer.renderInContext(UIGraphicsGetCurrentContext())
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
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
