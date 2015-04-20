//
//  MGCameraView.swift
//  MuGuangIOS
//
//  Created by ZH on 15/4/15.
//  Copyright (c) 2015年 北京目光璀璨科技有限公司. All rights reserved.
//

import UIKit
import AVFoundation
import CoreImage

/**
 *  主页面的相机类
 */
class MGCameraView: UIView, AVCaptureVideoDataOutputSampleBufferDelegate {
    var captureSession: AVCaptureSession!
    var previewLayer: CALayer!
    // filter: "CIColorInvert" : 反色， "CIPhotoEffectFade" : 褪色
    var filter: CIFilter = CIFilter(name: "CIPhotoEffectFade")
    lazy var context: CIContext = {
        let eaglContext = EAGLContext(API: EAGLRenderingAPI.OpenGLES2)
        let options = [kCIContextWorkingColorSpace : NSNull()]
        return CIContext(EAGLContext: eaglContext, options: options)
        }()
    // 闭包回调
    var tapAction: ((isRunning: Bool) -> Void)? = nil

    override init(frame: CGRect) {
        super.init(frame: frame)

        // 防止模拟器crash
        #if arch(i386) || arch(x86_64)
            // simulator
            #else
            // device
            self.setupCaptureSession()
        #endif
        previewLayer = CALayer()
        previewLayer.anchorPoint = CGPointZero
        previewLayer.masksToBounds = true

        self.layer.insertSublayer(previewLayer, atIndex: 0)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /**
     *  配置相机
     */
    func setupCaptureSession() {
        captureSession = AVCaptureSession()
        captureSession.beginConfiguration()
        captureSession.sessionPreset = AVCaptureSessionPresetHigh
        var device: AVCaptureDevice?
        for devi: AnyObject in AVCaptureDevice.devices() {
            if devi.position == AVCaptureDevicePosition.Back {
                device = devi as? AVCaptureDevice
            }
        }
        
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
            if captureSession.canAddInput(captureInput) {
                captureSession.addInput(captureInput)
            }
        }
        let dataOutput: AVCaptureVideoDataOutput = AVCaptureVideoDataOutput()
        dataOutput.videoSettings = [kCVPixelBufferPixelFormatTypeKey : kCVPixelFormatType_32BGRA]
        dataOutput.alwaysDiscardsLateVideoFrames = true

        if captureSession.canAddOutput(dataOutput) {
            captureSession.addOutput(dataOutput)
        }
        
        let queue = dispatch_queue_create("VideoQueue", DISPATCH_QUEUE_SERIAL)
        dataOutput.setSampleBufferDelegate(self, queue: queue)
        captureSession.commitConfiguration()
        
        // 添加点击手势
        var tapGR: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("methodForTapGestureRecognizer:"))
        self.addGestureRecognizer(tapGR)
    }
    
    // 添加点击后执行的方法
    func addTapAction(aClosure: (isRunning: Bool) -> Void) -> Void {
        self.tapAction = aClosure
    }
    
    /**
     *  点击手势
     */
    func methodForTapGestureRecognizer(tap: UITapGestureRecognizer!) {
        if let action = self.tapAction {
            action(isRunning: self.captureSession.running)
        }
    }
    
    /**
     *  开始运行
     */
    func startRunning() {
        self.captureSession.startRunning()
    }
    
    /**
     *  停止运行
     */
    func stopRunning() {
        self.captureSession.stopRunning()
    }
    
    /**
     *  拍照
     */
    func takePhoto(completion: (aImage: CGImage?) -> Void) {
        self.stopRunning()
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
            var cg_image = self.previewLayer.contents as! CGImage
            if let ui_image = UIImageJPEGRepresentation(UIImage(CGImage: cg_image), 0.5) {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    completion(aImage: UIImage(data: ui_image)?.CGImage)
                })
            }
        })
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.previewLayer.bounds = self.bounds
    }

    // MARK: - AVCaptureVideoDataOutputSampleBufferDelegate
    func captureOutput(captureOutput: AVCaptureOutput!,didOutputSampleBuffer sampleBuffer: CMSampleBuffer!,fromConnection connection: AVCaptureConnection!) {
        autoreleasepool {
            let imageBuffer = CMSampleBufferGetImageBuffer(sampleBuffer)
            
            var outputImage = CIImage(CVPixelBuffer: imageBuffer)
            
            self.filter.setValue(outputImage, forKey: kCIInputImageKey)
            outputImage = self.filter.outputImage
            
            let orientation = UIDevice.currentDevice().orientation
            var t: CGAffineTransform!
            if orientation == UIDeviceOrientation.Portrait {
                t = CGAffineTransformMakeRotation(CGFloat(-M_PI / 2.0))
            } else if orientation == UIDeviceOrientation.PortraitUpsideDown {
                t = CGAffineTransformMakeRotation(CGFloat(M_PI / 2.0))
            } else if (orientation == UIDeviceOrientation.LandscapeRight) {
                t = CGAffineTransformMakeRotation(CGFloat(M_PI))
            } else {
                t = CGAffineTransformMakeRotation(0)
            }
            outputImage = outputImage.imageByApplyingTransform(t)
            
            let cgImage = self.context.createCGImage(outputImage, fromRect: outputImage.extent())
            
            dispatch_sync(dispatch_get_main_queue(), {
                self.previewLayer.contents = cgImage
            })
        }
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
}
