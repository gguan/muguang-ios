//
//  MGAvatarView.swift
//  ArcLabel
//
//  Created by ZhangHao on 15/4/23.
//  Copyright (c) 2015年 ZhangHao. All rights reserved.
//

import UIKit

class MGAvatarView: UIView {
    let arcView = ArcView(frame: CGRectZero)
    let avatarView = UIImageView(frame: CGRectZero)
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.grayColor()
        
        arcView.backgroundColor = UIColor.purpleColor()
        arcView.text = "啊呦，今天天气不错哦"
        arcView.font = UIFont.systemFontOfSize(18.0)
        arcView.radius = 60
        arcView.shiftV = 30
        
        avatarView.layer.masksToBounds = true
        avatarView.layer.cornerRadius = 55
        avatarView.layer.borderWidth = 5
        avatarView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).CGColor
        avatarView.backgroundColor = UIColor.greenColor()
        
        self.addSubview(arcView)
        self.addSubview(avatarView)
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.arcView.frame = self.bounds
        var x = (self.frame.size.width - 110) / 2
        var y = (self.frame.size.height - 110) / 2
        self.avatarView.frame = CGRectMake(x, y, 110, 110)
    }
}
