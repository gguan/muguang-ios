//
//  MGAvatarView.swift
//  ArcLabel
//
//  Created by ZhangHao on 15/4/23.
//  Copyright (c) 2015年 ZhangHao. All rights reserved.
//

import UIKit

class MGAvatarView: UIView {
    // 弧形Label
    let arcView = ArcView(frame: CGRectZero)
    // 圆形头像
    let avatarView = UIImageView(frame: CGRectZero)
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        self.backgroundColor = UIColor.clearColor()
        
        arcView.backgroundColor = UIColor.clearColor()
        arcView.text = "啊呦，今天天气不错哦"
        arcView.color = UIColor.blackColor()
        arcView.font = UIFont.systemFontOfSize(18.0)
        arcView.radius = 60
        arcView.shiftV = 30
        
        avatarView.layer.masksToBounds = true
        avatarView.layer.cornerRadius = 55
        avatarView.layer.borderWidth = 5
        avatarView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).CGColor
        avatarView.backgroundColor = UIColor.greenColor()
        avatarView.contentMode = UIViewContentMode.ScaleToFill
        
        self.addSubview(arcView)
        self.addSubview(avatarView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.arcView.frame = self.bounds
        var x = (self.frame.size.width - 110) / 2
        var y = (self.frame.size.height - 110) / 2
        self.avatarView.frame = CGRectMake(x, y, 110, 110)
    }
}
