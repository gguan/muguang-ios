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
    // 圆形头像边框
    let borderView = UIImageView(frame: CGRectZero)
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
        arcView.color = UIColor.transformColor(kTextColorWhite, alpha: 1.0)
        arcView.font = UIFont.systemFontOfSize(15.0)
        arcView.radius = 60
        arcView.shiftV = 30
        
        avatarView.layer.masksToBounds = true
        avatarView.layer.cornerRadius = 50
        
        borderView.layer.masksToBounds = true
        borderView.layer.cornerRadius = 55
        borderView.layer.borderWidth = 5
        borderView.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).CGColor
        
        borderView.addSubview(avatarView)
        self.addSubview(arcView)
        self.addSubview(borderView)
    }
    
    // 设置文字
    func setAvatarTitle(string: NSString!) {
        arcView.text = string as String
        var width = string.boundingRectWithSize(arcView.frame.size, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: arcView.font], context: nil).width
        arcView.arcDegree = (width * CGFloat(M_PI)) / 180
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.arcView.frame = self.bounds
        var x = (self.frame.size.width - 110) / 2
        var y = (self.frame.size.height - 110) / 2
        self.borderView.frame = CGRectMake(x, y, 110, 110)
        self.avatarView.frame = CGRectInset(self.borderView.bounds, 5, 5)
    }
}
