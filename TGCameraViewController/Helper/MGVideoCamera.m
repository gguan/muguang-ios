//
//  MGVideoCamera.m
//  MuGuangIOS
//
//  Created by William Hu on 4/21/15.
//  Copyright (c) 2015 北京目光璀璨科技有限公司. All rights reserved.
//

#import "MGVideoCamera.h"
#import "TGCameraFlash.h"
#import "TGCameraToggle.h"

@interface MGVideoCamera() <AVCaptureVideoDataOutputSampleBufferDelegate>
@property (strong, nonatomic) AVCaptureSession *session;
@property (nonatomic, strong) AVCaptureVideoDataOutput *videoOutput;
//@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;

@property (nonatomic, strong) CIContext *context;

@end

@implementation MGVideoCamera


+ (instancetype)cameraWithFlashButton:(UIButton *)flashButton
{
    MGVideoCamera *camera = [MGVideoCamera newCamera];
    [camera setupWithFlashButton:flashButton];
    return camera;
}

+ (instancetype)newCamera
{
    return [super new];
}

- (void)setupWithFlashButton:(UIButton *)flashButton
{
    //
    // create session
    //
    
    _session = [AVCaptureSession new];
    _session.sessionPreset = AVCaptureSessionPresetPhoto;
    _context = [CIContext contextWithOptions:nil];
    
    
    //
    // setup device
    //
    
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    if ([device lockForConfiguration:nil]) {
        if (device.autoFocusRangeRestrictionSupported) {
            device.autoFocusRangeRestriction = AVCaptureAutoFocusRangeRestrictionNear;
        }
        
        if (device.smoothAutoFocusSupported) {
            device.smoothAutoFocusEnabled = YES;
        }
        
        if([device isFocusModeSupported:AVCaptureFocusModeContinuousAutoFocus]){
            device.focusMode = AVCaptureFocusModeContinuousAutoFocus;
        }
        
        device.exposureMode = AVCaptureExposureModeContinuousAutoExposure;
        
        [device unlockForConfiguration];
    }
    
    //
    // add device input to session
    //
    
    AVCaptureDeviceInput *deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    [_session addInput:deviceInput];
    
    //
    // add output to session
    //
    

    //NSDictionary *outputSettings = [NSDictionary dictionaryWithObjectsAndKeys:AVVideoCodecJPEG, AVVideoCodecKey, nil];
    
    _videoOutput = [AVCaptureVideoDataOutput new];

    //_videoOutput.videoSettings = outputSettings;
    [_videoOutput setAlwaysDiscardsLateVideoFrames:YES];
    [_videoOutput setVideoSettings:[NSDictionary  dictionaryWithObject:[NSNumber numberWithInt:kCVPixelFormatType_32BGRA]
                                                              forKey:(id)kCVPixelBufferPixelFormatTypeKey]];
    [_videoOutput setSampleBufferDelegate:self queue:dispatch_get_main_queue()];
    
    
    if ([_session canAddOutput:_videoOutput]) {
        [_session addOutput:_videoOutput];
    }
//    [_session commitConfiguration];
    
    //
    // setup flash button
    //
    
    [TGCameraFlash flashModeWithCaptureSession:_session andButton:flashButton];
}


-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    
    CVPixelBufferRef pixelBuffer = (CVPixelBufferRef)CMSampleBufferGetImageBuffer(sampleBuffer);
    CIImage *image = [CIImage imageWithCVPixelBuffer:pixelBuffer];
    [self.filter setValue:image forKey:kCIInputImageKey];
    image  = self.filter.outputImage;
    
    image = [self makeRightOrientationOnCIImage:image];
    
    CGImageRef cgimg = [_context createCGImage:image fromRect:[image extent]];
    _previewLayer.contents = (__bridge id)(cgimg);
    CGImageRelease(cgimg);
    
}

- (CIImage *) makeRightOrientationOnCIImage:(CIImage *) image
{
    UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
    CGAffineTransform transform;
    
    if (orientation == UIDeviceOrientationPortrait) {
        transform = CGAffineTransformMakeRotation(-M_PI/2.0);
    } else if (orientation == UIDeviceOrientationPortraitUpsideDown) {
        transform = CGAffineTransformMakeRotation(M_PI / 2.0);
    } else if (orientation == UIDeviceOrientationLandscapeRight) {
        transform = CGAffineTransformMakeRotation(M_PI);
    } else {
        transform = CGAffineTransformMakeRotation(0);
    }
    return [image imageByApplyingTransform:transform];
}


- (void)startRunning
{
    [_session startRunning];
}
- (void)stopRunning
{
    [_session stopRunning];
}

- (void)insertSublayerWithCaptureView:(UIView *)captureView atRootView:(UIView *)rootView
{
    //_previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_session];
    _previewLayer = [CALayer new];
//    _previewLayer.session = _session;
//    _previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    CALayer *rootLayer = [rootView layer];
    rootLayer.masksToBounds = YES;
    
    CGRect frame = captureView.frame;
    _previewLayer.frame = frame;
    
//    [rootLayer insertSublayer:_previewLayer atIndex:0];
    [rootLayer addSublayer:_previewLayer];

//    NSInteger index = [captureView.subviews count]-1;
//    [captureView insertSubview:self.gridView atIndex:index];
}

- (UIImage *) captureImage
{
    if (_filter) {
        CIImage *image = self.filter.outputImage;
        image = [self makeRightOrientationOnCIImage:image];
        CGImageRef cgimg = [_context createCGImage:image fromRect:[image extent]];
        return [UIImage imageWithCGImage:cgimg];
    }else
        return nil;
}

//前置摄像头
- (void)toogleWithFlashButton:(UIButton *)flashButton
{
    [TGCameraToggle toogleWithCaptureSession:_session];
    [TGCameraFlash flashModeWithCaptureSession:_session andButton:flashButton];
}
//闪光灯
- (void)changeFlashModeWithButton:(UIButton *)button
{
    [TGCameraFlash changeModeWithCaptureSession:_session andButton:button];
}
@end

