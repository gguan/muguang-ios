//
//  MGPublishViewController.swift
//  MuGuangIOS
//
//  Created by William Hu on 4/16/15.
//  Copyright (c) 2015 北京目光璀璨科技有限公司. All rights reserved.
//

import UIKit

import AVFoundation

import QuartzCore

import ImageIO

class MGPublishViewController: UIViewController {

    let captureSession = AVCaptureSession()
    var captureDevice    : AVCaptureDevice?
    var previewLayer     : AVCaptureVideoPreviewLayer?
    var stillImageOutput : AVCaptureStillImageOutput!
    
    @IBOutlet weak var preview: UIView!
    @IBOutlet weak var previewImage: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    let reuseIdentifier = "MGPhotoCell"
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        //Capture Size
        previewLayer?.frame = preview.bounds;
        collectionView.backgroundColor = UIColor.blueColor()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        captureSession.sessionPreset = AVCaptureSessionPresetHigh
        
        let devices = AVCaptureDevice.devices()
        
        for device in AVCaptureDevice.devices() {
            // Make sure this particular device supports video
            if (device.hasMediaType(AVMediaTypeVideo)) {
                // Finally check the position and confirm we've got the back camera
                if(device.position == AVCaptureDevicePosition.Back) {
                    captureDevice = device as? AVCaptureDevice
                    if captureDevice != nil {
                        beginSession()
                    }
                }
            }
        }
    }

    func beginSession() {
        
        configureDevice()
        
        var err : NSError? = nil
        captureSession.addInput(AVCaptureDeviceInput(device: captureDevice, error: &err))
        
        if err != nil {
            println("error: \(err?.localizedDescription)")
        }
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
        self.preview.layer.addSublayer(previewLayer)
        self.preview.backgroundColor = UIColor.redColor()
        //拍照
        stillImageOutput = AVCaptureStillImageOutput()
        self.stillImageOutput.outputSettings =
            NSDictionary(object: AVVideoCodecJPEG, forKey: AVVideoCodecKey) as [NSObject : AnyObject]
        captureSession.addOutput(self.stillImageOutput)
        
        //运行取景器
        captureSession.startRunning()
    }
    
    func configureDevice() {
        if let device = captureDevice {
            device.lockForConfiguration(nil)
            device.focusMode = .Locked
            device.unlockForConfiguration()
        }
    }
    
    
    //拍照
    @IBAction func capture(sender: AnyObject) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) { () -> Void in
            var videoConnection :AVCaptureConnection?
            if let videoConnection = self.stillImageOutput.connectionWithMediaType(AVMediaTypeVideo){
                self.stillImageOutput.captureStillImageAsynchronouslyFromConnection(videoConnection, completionHandler: { (buffer:CMSampleBuffer!, error: NSError!) -> Void in
                    if let exifAttachments = CMGetAttachment(buffer, kCGImagePropertyExifDictionary, nil) {
                        let imageData = AVCaptureStillImageOutput.jpegStillImageNSDataRepresentation(buffer)
                        if let image = UIImage(data: imageData) {
                            self.previewImage.image  = image
                            self.previewImage.hidden = false
                        }
                        
                        //UIImageWriteToSavedPhotosAlbum(self.previewImage.image, nil, nil, nil)
                    }
                })
            }

        }

    }

    //重新拍照
    @IBAction func retake(sender: AnyObject) {
        //TODO: 逻辑待确定
        self.previewImage.hidden = true
        self.presentViewController(UINavigationController(rootViewController: MGMainViewController()), animated: true, completion: nil)
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
