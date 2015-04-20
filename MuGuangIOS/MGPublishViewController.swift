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

import GPUImage

class MGPublishViewController: UIViewController {

 
    let captureSession   = AVCaptureSession()
    var captureDevice    : AVCaptureDevice?
    var previewLayer     : AVCaptureVideoPreviewLayer?
    var stillImageOutput : AVCaptureStillImageOutput!
    
    @IBOutlet weak var preview          : UIView!
    @IBOutlet weak var previewImage     : UIImageView!
    @IBOutlet weak var collectionView   : UICollectionView!
    @IBOutlet weak var filteredImageView: FilteredImageView!
    
    /************GPU*****************/
    
    var videoCamera: GPUImageVideoCamera?
    
    @IBOutlet weak var filterView: UIImageView!
    
    var stillCamera: GPUImageStillCamera?
    
    /************常用滤镜*****************/
    var filters = [CIFilter]()
    let filterDescriptors: [(filterName: String, filterDisplayName: String)] = [
        ("CIColorControls", "None"),
        ("CIPhotoEffectMono", "Mono"),
        ("CIPhotoEffectTonal", "Tonal"),
        ("CIPhotoEffectNoir", "Noir"),
        ("CIPhotoEffectFade", "Fade"),
        ("CIPhotoEffectChrome", "Chrome"),
        ("CIPhotoEffectProcess", "Process"),
        ("CIPhotoEffectTransfer", "Transfer"),
        ("CIPhotoEffectInstant", "Instant"),
    ]
    
    let reuseIdentifier = "MGPhotoCell"
    
    
    required init(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)

    }
    
    
    var filterOperation: FilterOperationInterface? {
        didSet {
            self.configureView()
        }
    }
    
    func configureView() {
//        if let currentFilterConfiguration = self.filterOperation {
////            self.title = currentFilterConfiguration.titleName
////            
////            if let view = self.filterView {
////                switch currentFilterConfiguration.filterOperationType {
////                case .SingleInput:
////                    videoCamera.addTarget((currentFilterConfiguration.filter as! GPUImageInput))
////                    currentFilterConfiguration.filter.addTarget(view)
////                case .Blend:
////                    videoCamera.addTarget((currentFilterConfiguration.filter as! GPUImageInput))
////                    let inputImage = UIImage(named:"WID-small.jpg")
////                    self.blendImage = GPUImagePicture(image: inputImage)
////                    self.blendImage?.addTarget((currentFilterConfiguration.filter as! GPUImageInput))
////                    self.blendImage?.processImage()
////                    currentFilterConfiguration.filter.addTarget(view)
////                case let .Custom(filterSetupFunction:setupFunction):
////                    let inputToFunction:(GPUImageOutput, GPUImageOutput?) = setupFunction(camera:videoCamera, outputView:view) // Type inference falls down, for now needs this hard cast
////                    currentFilterConfiguration.configureCustomFilter(inputToFunction)
////                }
////                
////                videoCamera.startCameraCapture()
//            }
//            
//            // Hide or display the slider, based on whether the filter needs it
//            if let slider = self.filterSlider {
//                switch currentFilterConfiguration.sliderConfiguration {
//                case .Disabled:
//                    slider.hidden = true
//                    //                case let .Enabled(minimumValue, initialValue, maximumValue, filterSliderCallback):
//                case let .Enabled(minimumValue, maximumValue, initialValue):
//                    slider.minimumValue = minimumValue
//                    slider.maximumValue = maximumValue
//                    slider.value = initialValue
//                    slider.hidden = false
//                    self.updateSliderValue()
//                }
//            }
//            
//        }
    }

    /**
    *  初始化视频取景器
    */
    func initVideoCamera () {
        // Video Camera 取景
        videoCamera = GPUImageVideoCamera(sessionPreset: AVCaptureSessionPreset640x480, cameraPosition: .Back)
        if videoCamera != nil {
            videoCamera!.outputImageOrientation = .Portrait
        }
    }
    
    /**
     *  打开视频取景器
     */
    func startVideoCamera () {
        var customFilter        = GPUImageFilter(fragmentShaderFromFile:"Shader1")
        var filteredVideoView   = GPUImageView(frame: CGRectZero)
        filteredVideoView.frame = preview.frame;
        preview.backgroundColor = UIColor.yellowColor()
        self.view.addSubview(filteredVideoView)
        filteredVideoView.backgroundColor = UIColor.redColor()
        customFilter.addTarget(filteredVideoView)
        self.videoCamera?.addTarget(customFilter)
        self.videoCamera?.startCameraCapture()
    }
    
    
    /**
    *  初始化图片取景器
    */
    func initImageCamera () {
        stillCamera = GPUImageStillCamera()
        stillCamera?.outputImageOrientation = .Portrait
        var filter = GPUImageGammaFilter()
        stillCamera?.addTarget(filter)
    
        let pp = GPUImageView(frame: preview.bounds)
        preview.addSubview(pp)
        filter.addTarget(pp)
        stillCamera?.startCameraCapture()
    }
    
    // 初始化变量
    func initVariables() {
        
        //初始化视频取景器
        self.initVideoCamera()
        
        previewImage.image = UIImage(named: kSampleImageName)
        
        collectionView.backgroundColor = UIColor.blueColor()

        for descriptor in filterDescriptors {
            filters.append(CIFilter(name: descriptor.filterName))
        }
        filteredImageView.layer.borderColor = UIColor.yellowColor().CGColor
        filteredImageView.layer.borderWidth = 2
        
        filteredImageView.inputImage = UIImage(named: kSampleImageName)

        filteredImageView.contentMode = .ScaleAspectFit
        filteredImageView.filter = filters[0]
        
        captureSession.sessionPreset = AVCaptureSessionPresetHigh
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
    
    // 初始化视图size
    func initViewVariables () {
        
        preview.backgroundColor = UIColor.greenColor()
        filteredImageView.backgroundColor = UIColor.yellowColor()
        
        //Capture Size
        previewLayer?.frame = preview.bounds;
        
    }
    
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.initViewVariables()
        
        ////self.startVideoCamera()
        
        self.initImageCamera()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /**
        *  初始化变量
        */
        self.initVariables()
        
    
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
//        //拍照
//        stillImageOutput = AVCaptureStillImageOutput()
//        self.stillImageOutput.outputSettings =
//            NSDictionary(object: AVVideoCodecJPEG, forKey: AVVideoCodecKey) as [NSObject : AnyObject]
//        captureSession.addOutput(self.stillImageOutput)
//        
//        //运行取景器
//        captureSession.startRunning()
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
