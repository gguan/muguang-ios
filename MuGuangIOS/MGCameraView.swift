//
//  MGCameraView.swift
//  MuGuangIOS
//
//  Created by ZH on 15/4/15.
//  Copyright (c) 2015年 北京目光璀璨科技有限公司. All rights reserved.
//

import UIKit
import AVFoundation

class MGCameraView: UIView {
    let captureSession: AVCaptureSession = AVCaptureSession()
    let stillImageOutput: AVCaptureStillImageOutput = AVCaptureStillImageOutput()
    let previewLayer: AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer()

    override init(frame: CGRect) {
        captureSession.sessionPreset = AVCaptureSessionPresetPhoto
        
        var device: AVCaptureDevice?
        #if arch(i386) || arch(x86_64)
            //simulator
            #else
            //device
            device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        #endif
        if let captureDevice = device {
            if captureDevice.lockForConfiguration(nil) {
                if captureDevice.smoothAutoFocusSupported {
                    captureDevice.smoothAutoFocusEnabled = true
                }
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
        previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        super.init(frame: frame)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.previewLayer.frame = self.frame
        self.layer.addSublayer(previewLayer)
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
