//
//  UIColorExt.swift
//  MuGuangIOS
//
//  Created by William Hu on 4/27/15.
//  Copyright (c) 2015 北京目光璀璨科技有限公司. All rights reserved.
//

import Foundation

extension UIColor {
    class func MGMainColor () -> UIColor {
        return UIColor(red: 243/255.0, green: 54/255.0, blue: 29/255.0, alpha: 0.8)
    }
    class func MGGrayColor () -> UIColor {
        return UIColor(red: 229/255.0, green: 229/255.0, blue: 229/255.0, alpha: 1.0)
    }
    
    /**
     *  颜色转图片
     *  :param: color 图片颜色
     *  :param: size  图片尺寸
     */
    class func imageFromColor(color: UIColor, size: CGSize) -> UIImage {
        var rect = CGRectMake(0, 0, size.width, size.height)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        var context: CGContextRef = UIGraphicsGetCurrentContext()
        CGContextSetFillColorWithColor(context, color.CGColor)
        CGContextFillRect(context, rect)
        var image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}