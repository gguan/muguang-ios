//
//  MGVideoCamera.h
//  MuGuangIOS
//
//  Created by William Hu on 4/21/15.
//  Copyright (c) 2015 北京目光璀璨科技有限公司. All rights reserved.
//

//#import <Foundation/Foundation.h>
@import Foundation;
@import AVFoundation;
@import UIKit;

@interface MGVideoCamera : NSObject

@property (nonatomic, strong) CIFilter *filter;

+ (instancetype)cameraWithFlashButton:(UIButton *)flashButton;
- (void)startRunning;
- (void)stopRunning;
- (void)insertSublayerWithCaptureView:(UIView *)captureView atRootView:(UIView *)rootView;

@property (nonatomic, strong) CALayer *previewLayer;
//照相
- (UIImage *) captureImage;

- (void)toogleWithFlashButton:(UIButton *)flashButton;
- (void)changeFlashModeWithButton:(UIButton *)button;

- (void)focusView:(UIView *)focusView inTouchPoint:(CGPoint)touchPoint;

- (void) test:(UIView *) camView view:(UIView *) foucusView;
@end
