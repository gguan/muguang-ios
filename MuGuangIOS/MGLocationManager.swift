//
//  MGLocationManager.swift
//  MuGuangIOS
//
//  Created by ZhangHao on 15/4/20.
//  Copyright (c) 2015年 北京目光璀璨科技有限公司. All rights reserved.
//

import UIKit
import CoreLocation
//import MapKit

let kLocationNotificationDidUpdateLocations = "locationManagerDidUpdateLocations"
let kLocationNotificationDidUpdateHeading = "locationManagerDidUpdateHeading"

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
    
    weak var delegate: MGLocationManagerDelegate?
    
    // 当前方向
    var trueHeading: Double?
    // 当前经纬度
    var currentLocation: CLLocation?
    
    override init() {
        super.init()
        self.locationManager.delegate = self
        
        // 设定为最佳精度
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        // 响应位置变化的最小距离(m)
        self.locationManager.distanceFilter = 5.0
        self.locationManager.headingFilter = 5.0
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
    
    // 停止定位服务
    func stopUpdating() {
        self.locationManager.stopUpdatingHeading()
        self.locationManager.stopUpdatingLocation()
    }
    
    // MARK: CLLocationManagerDelegate
    // 位置更新
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
//        println("=======",locations)
        self.currentLocation = locations[0] as? CLLocation
        self.reverseGeoder(self.currentLocation!, complete: { (address) -> Void in
            // do something
        })
        NSNotificationCenter.defaultCenter().postNotificationName(kLocationNotificationDidUpdateLocations, object: self.currentLocation)
    }
    
    // 方向更新（正北为0度）
    func locationManager(manager: CLLocationManager!, didUpdateHeading newHeading: CLHeading!) {
//        println("----方向----",newHeading)
        self.trueHeading = newHeading.trueHeading
        NSNotificationCenter.defaultCenter().postNotificationName(kLocationNotificationDidUpdateHeading, object: self.trueHeading)
    }
    
    // 方向更新校准
//    func locationManagerShouldDisplayHeadingCalibration(manager: CLLocationManager!) -> Bool {
//        return true
//    }
    
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
    
    // 经纬度反向解析
    func reverseGeoder(location: CLLocation, complete: (address: String) -> Void) {
        var geoCoder: CLGeocoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
            if error == nil {
                for item in placemarks {
                    var mark: CLPlacemark = item as! CLPlacemark
                    var city = mark.addressDictionary["State"] as! String
                    var subLocality = mark.addressDictionary["SubLocality"] as! String
                    var street = mark.addressDictionary["Street"] as! String
                    var name = mark.addressDictionary["Name"] as! String
                    println(city + subLocality + street + name)
                    complete(address: (city + subLocality + street + name))
                }
            } else {
                println("reverseGeocodeLocation error")
            }
        })
    }
}

/**
 *   MGLocationManager的代理
 */
@objc protocol MGLocationManagerDelegate {
    // 位置更新
    optional func locationManagerDidUpdateLocations(location: CLLocation!)
    // 方向更新
    optional func locationManagerDidUpdateHeading(head: CLHeading!)
}