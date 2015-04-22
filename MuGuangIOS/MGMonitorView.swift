//
//  MGMonitorView.swift
//  MuGuangIOS
//
//  Created by ZhangHao on 15/4/20.
//  Copyright (c) 2015年 北京目光璀璨科技有限公司. All rights reserved.
//

import UIKit
import CoreMotion
import CoreLocation

/**
 *  主页面显示经纬度、陀螺仪状态的view
 */

class MGMonitorView: UIView {
    // 加速计
    let motionLabel: UILabel = UILabel(frame: CGRectZero)
    // 经纬度
    let locationLabel: UILabel = UILabel(frame: CGRectZero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        self.addSubview(motionLabel)
        self.addSubview(locationLabel)
        
        self.motionLabel.textColor = UIColor.whiteColor()
        self.motionLabel.numberOfLines = 0
        self.motionLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        
        self.locationLabel.textColor = UIColor.whiteColor()
        self.locationLabel.numberOfLines = 0
        self.locationLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping

    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // 更新加速计的数据
    func updateMotionLabel(acceleration: CMAcceleration) {
        var x : Double, y : Double, z : Double
        x = acceleration.x
        y = acceleration.y
        z = acceleration.z
        self.motionLabel.text = "x: \(round(x * 100)/100)\ny: \(round(y * 100)/100)\nz: \(round(z * 100)/100)\n"
    }
    
    // 更新地点
    func updateLocationLabel(location: CLLocation) {
        self.locationLabel.text = "lat: \(location.coordinate.latitude)\nlon: \(location.coordinate.longitude)\naltitude: \(location.altitude)"
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        // 添加约束
        motionLabel.mas_makeConstraints { make in
            make.width.top().equalTo()(self)
            make.height.equalTo()(CGRectGetHeight(self.frame) / 2)
        }
        
        locationLabel.mas_makeConstraints { make in
            make.width.equalTo()(self)
            make.top.equalTo()(self.motionLabel.mas_bottom)
            make.height.equalTo()(CGRectGetHeight(self.frame) / 2)
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
