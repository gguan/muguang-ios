//
//  MGAvatarView.swift
//  ArcLabel
//
//  Created by ZhangHao on 15/4/23.
//  Copyright (c) 2015年 ZhangHao. All rights reserved.
//

import UIKit

// 带边框的头像
class MGAvatarImageView: UIView {
    // 圆形头像
    let avatarView = UIImageView(frame: CGRectZero)
    // 圆形头像边框
    let borderView = UIImageView(frame: CGRectZero)
    // 边框宽度
    var borderWidth: CGFloat = 5 {
        didSet {
            self.layoutIfNeeded()
        }
    }
    // 边框颜色
    var borderColor: UIColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5) {
        didSet {
            self.layoutIfNeeded()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        self.backgroundColor = UIColor.clearColor()
    }
    
    func setAvatarImage(image: UIImage?) {
        self.avatarView.image = image
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if borderView.superview == nil {
            self.addSubview(borderView)
        }
        if avatarView.superview == nil {
            borderView.addSubview(avatarView)
        }
        self.borderView.frame = self.bounds
        self.avatarView.frame = CGRectInset(self.borderView.bounds, self.borderWidth, self.borderWidth)
        
        avatarView.layer.masksToBounds = true
        avatarView.layer.cornerRadius = avatarView.frame.size.width / 2
        
        borderView.layer.masksToBounds = true
        borderView.layer.cornerRadius = borderView.frame.size.width / 2
        borderView.layer.borderWidth = self.borderWidth
        borderView.layer.borderColor = borderColor.CGColor
    }
}

class MGAvatarView: UIView {
    // 弧形Label
    let arcView = ArcView(frame: CGRectZero)
    // 圆形头像
    let avatar = MGAvatarImageView(frame: CGRectZero)

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    /**
    设置头像
    */
    func setAvatarImage(image: UIImage?) {
        self.avatar.setAvatarImage(image)
    }
    
    override func awakeFromNib() {
        self.backgroundColor = UIColor.clearColor()
        
        arcView.backgroundColor = UIColor.clearColor()
        arcView.text = "啊呦，今天天气不错哦"
        arcView.color = UIColor.transformColor(kTextColorWhite, alpha: 1.0)
        arcView.font = UIFont.systemFontOfSize(15.0)
        arcView.radius = 60
        arcView.shiftV = 30
    
        self.addSubview(arcView)
        self.addSubview(avatar)

    }
    
    // 设置文字
    func setAvatarTitle(string: NSString!) {
        arcView.text = string as String
        var width = string.boundingRectWithSize(arcView.frame.size, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: [NSFontAttributeName: arcView.font], context: nil).width
        arcView.arcDegree = (width * CGFloat(M_PI)) / 180
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.arcView.frame = self.bounds.rectByInsetting(dx: -20, dy: -20)
        self.avatar.frame = self.bounds
    }
}
