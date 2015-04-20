//
//  MGLocationManager.swift
//  MuGuangIOS
//
//  Created by ZhangHao on 15/4/20.
//  Copyright (c) 2015年 北京目光璀璨科技有限公司. All rights reserved.
//

import UIKit
import CoreLocation

/**
 *  提供位置服务
 */
class MGLocationManager: NSObject, CLLocationManagerDelegate {
    // 单例
    class var shared: MGLocationManager {
        struct Inner {
            static var onceToken: dispatch_once_t = 0
            static var instance: MGLocationManager? = nil
        }
        dispatch_once(&Inner.onceToken) {
            Inner.instance = MGLocationManager()
        }
        return Inner.instance!
    }
    
    let locationManager: CLLocationManager = CLLocationManager()
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        
        // 设定为最佳精度
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // 响应位置变化的最小距离(m)
        self.locationManager.distanceFilter = 5.0
    }
    
    // 请求定位服务授权
    func requestWhenInUseAuthorization() {
        if CLLocationManager.authorizationStatus() == .NotDetermined {
            self.locationManager.requestWhenInUseAuthorization()
        }
    }
    
    // 开始定位服务
    func startUpdating() {
        // 开启电子罗盘
        if CLLocationManager.headingAvailable() {
            self.locationManager.startUpdatingHeading()
        }
        // 开启定位
        if CLLocationManager.locationServicesEnabled() {
            self.locationManager.startUpdatingLocation()
        }
    }
    
    // MARK: CLLocationManagerDelegate
    // 位置更新
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        println(locations)
    }
    
    // 方向更新（正北为0度）
    func locationManager(manager: CLLocationManager!, didUpdateHeading newHeading: CLHeading!) {
        println(newHeading)
    }
    
    // 方向更新过滤
    func locationManagerShouldDisplayHeadingCalibration(manager: CLLocationManager!) -> Bool {
        return true
    }
    
    // 授权状态
    func locationManager(manager: CLLocationManager!, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        if status == .AuthorizedAlways || status == .AuthorizedWhenInUse {
            // 开启电子罗盘
            if CLLocationManager.headingAvailable() {
                manager.startUpdatingHeading()
            }
            // 开启定位
            if CLLocationManager.locationServicesEnabled() {
                manager.startUpdatingLocation()
            }
        }
    }
}

/**
 *   MGLocationManager的代理
 */
@objc protocol MGLocationManagerDelegate {
    // 位置更新
    optional func locationManagerDidUpdateLocations(location: CLLocation!)
}