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
+ (instancetype)cameraWithFlashButton:(UIButton *)flashButton;
- (void)startRunning;
- (void)stopRunning;
- (void)insertSublayerWithCaptureView:(UIView *)captureView atRootView:(UIView *)rootView;
@end
