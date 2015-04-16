//
//  MGCameraView.swift
//  MuGuangIOS
//
//  Created by ZH on 15/4/15.
//  Copyright (c) 2015年 北京目光璀璨科技有限公司. All rights reserved.
//

import UIKit
import AVFoundation

/**
 *  主页面的相机类
 */
class MGCameraView: UIView {
    let captureSession: AVCaptureSession = AVCaptureSession()
    let stillImageOutput: AVCaptureStillImageOutput = AVCaptureStillImageOutput()
    let previewLayer: AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer()
    // 闭包回调
    var tapAction: ((isRunning: Bool) -> Void)? = nil
    override init(frame: CGRect) {
        
        // 配置相机
        captureSession.sessionPreset = AVCaptureSessionPresetPhoto
        var device: AVCaptureDevice?
        // 加判断防止模拟器crash
        #if arch(i386) || arch(x86_64)
            //simulator
            #else
            //device
            device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        #endif
        if let captureDevice = device {
            if captureDevice.lockForConfiguration(nil) {
                if captureDevice.isFocusModeSupported(.AutoFocus) {
                    captureDevice.focusMode = .AutoFocus;
                }
                
                if captureDevice.isExposureModeSupported(.ContinuousAutoExposure) {
                    captureDevice.exposureMode = .ContinuousAutoExposure;
                }
                captureDevice.unlockForConfiguration()
            }
            var error: NSError? = nil
            var captureInput: AVCaptureDeviceInput? = AVCaptureDeviceInput.deviceInputWithDevice(device, error: &error) as? AVCaptureDeviceInput
            if captureInput == nil {
                println("open camera error! \(error?.localizedDescription)")
            }
            captureSession.addInput(captureInput)
        }

        var outputSettings: NSDictionary = [AVVideoCodecKey : AVVideoCodecJPEG]
        stillImageOutput.outputSettings = outputSettings as [NSObject : AnyObject]
        
        captureSession.addOutput(stillImageOutput)
        previewLayer.session = captureSession
        previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        super.init(frame: frame)
        self.layer.addSublayer(previewLayer)
        
        // 添加点击手势
        var tapGR: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("methodForTapGestureRecognizer:"))
        self.addGestureRecognizer(tapGR)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // 添加点击后执行的方法
    func addTapAction(aClosure: (isRunning: Bool) -> Void) -> Void {
        self.tapAction = aClosure
    }
    
    /**
     *点击手势
     */
    func methodForTapGestureRecognizer(tap: UITapGestureRecognizer!) {
        if let action = self.tapAction {
            action(isRunning: self.captureSession.running)
        }
    }
    
    /**
     *开始运行
     */
    func startRunning() {
        var fadeAnimation = CATransition()
        fadeAnimation.type = kCATransitionFade
        fadeAnimation.duration = 0.25
        self.previewLayer.addAnimation(fadeAnimation, forKey: "Fade")
        self.captureSession.startRunning()
    }
    
    /**
     *停止运行
     */
    func stopRunning() {
        self.captureSession.stopRunning()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.previewLayer.frame = self.frame
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
