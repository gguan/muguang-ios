//
//  MGVerticalSlider.swift
//  MuGuangIOS
//
//  Created by ZH on 15/4/17.
//  Copyright (c) 2015年 北京目光璀璨科技有限公司. All rights reserved.
//

import UIKit

class MGVerticalSlider: UISlider {

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initVerticalSlider()
    }
    
    func initVerticalSlider() {
//        var rect: CGRect = self.frame
//        self.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
//        self.frame = rect;
        self.setThumbImage(self.rotatedImage(UIImage(named: "main_page_slider_icon")), forState: .Normal)
        var backImage = UIImage(named: "main_page_silder_background")
        self.setMinimumTrackImage(self.rotatedImage(backImage)?.stretchableImageWithLeftCapWidth(10, topCapHeight: 0), forState: .Normal)
        self.setMaximumTrackImage(self.rotatedImage(backImage)?.stretchableImageWithLeftCapWidth(10, topCapHeight: 0), forState: .Normal)
    }
    
    func rotatedImage(aImage: UIImage?) -> UIImage? {
        if let image = aImage {
            UIGraphicsBeginImageContextWithOptions(CGSizeMake(image.size.height, image.size.width), false, image.scale)
            var context: CGContextRef = UIGraphicsGetCurrentContext()
            CGContextRotateCTM(context, CGFloat(M_PI_2));
            image.drawAtPoint(CGPointMake(0, -image.size.height))
            return UIGraphicsGetImageFromCurrentImageContext()
        } else {
            return nil
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
        if !CGAffineTransformEqualToTransform(self.transform, transform) {
            self.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI_2))
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
