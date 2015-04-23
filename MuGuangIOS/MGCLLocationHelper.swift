//
//  MGCLLocationHelper.swift
//  MuGuangIOS
//
//  Created by ZhangHao on 15/4/22.
//  Copyright (c) 2015年 北京目光璀璨科技有限公司. All rights reserved.
//

import Foundation
import CoreLocation
import MapKit

/**
*   经纬度帮助类
*/
class MGCLLocationHelper: NSObject {

    /**
    *   获取两点间的距离
    */
    class func getDistance(location1: CLLocation, location2: CLLocation) -> Double {
        return location1.distanceFromLocation(location2)
    }
    
    /**
    *   角度转弧度
    */
    class func degreeToRadian(degree: Double) -> Double {
        return degree / 180.0 * M_PI
    }
    
    /**
    *   弧度转角度
    */
    class func radianToDegree(radian: Double) -> Double {
        return radian / M_PI * 180.0
    }
    
    /**
    *   计算两点间的角度(正北为0)
    */
    class func calculatorDegree(location1: CLLocation, location2: CLLocation) -> Double {
        var degree = atan2(location2.coordinate.longitude - location1.coordinate.longitude, location2.coordinate.latitude - location1.coordinate.latitude)
        // －180° ~ 180°转化为0° ~ 360°
        return radianToDegree(degree >= 0 ? degree : (2 * M_PI + degree))
    }
    
    /**
    *   判断目标角度在不在当前视野内 偏移量45°
    */
    class func judgeDegreeInField(currentDegree: Double, targetDegree: Double) -> Bool {
        var degree1 = currentDegree - 45
        var degree2 = currentDegree + 45
        degree1 = degree1 < 0 ? (359.99 + degree1) : degree1
        return targetDegree <= degree2 || targetDegree >= degree1
    }
}
