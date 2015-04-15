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
    let captureSession: AVCaptureSession?
    let stillImageOutput: AVCaptureStillImageOutput?
    let previewLayer: AVCaptureVideoPreviewLayer?

//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        captureSession = AVCaptureSession()
//        captureSession!.sessionPreset = AVCaptureSessionPresetPhoto
//        var device: AVCaptureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
//        if device.lockForConfiguration(nil) {
//            if device.smoothAutoFocusSupported {
//                device.smoothAutoFocusEnabled = true
//            }
//            if device.isFocusModeSupported(.AutoFocus) {
//                device.focusMode = .AutoFocus;
//            }
//            
//            if device.isExposureModeSupported(.ContinuousAutoExposure) {
//                device.exposureMode = .ContinuousAutoExposure;
//            }
//            device.unlockForConfiguration()
//        }
//        var error: NSError? = nil
//        var captureInput: AVCaptureDeviceInput? = AVCaptureDeviceInput.deviceInputWithDevice(device, error: &error) as? AVCaptureDeviceInput
//        if captureInput == nil {
//            println("open camera error! \(error?.localizedDescription)")
//        }
//        
//        stillImageOutput = AVCaptureStillImageOutput();
//        var outputSettings: NSDictionary = [AVVideoCodecKey : AVVideoCodecJPEG]
//        stillImageOutput.outputSettings = outputSettings;
//        
//        captureSession!.addInput(captureInput)
//        captureSession!.addOutput(stillImageOutput)
//    }
//    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
