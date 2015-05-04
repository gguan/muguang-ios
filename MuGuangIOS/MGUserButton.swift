//
//  MGUserButton.swift
//  MuGuangIOS
//
//  Created by ZhangHao on 15/4/24.
//  Copyright (c) 2015年 北京目光璀璨科技有限公司. All rights reserved.
//

import UIKit

class MGUserButton: UIButton {

    // 文字Label
    let textLabel = UILabel(frame: CGRectZero)
    // 数字Label
    let countLabel = UILabel(frame: CGRectZero)
    // 是否显示右侧的分割线
    var showLine: Bool = true
    // 右侧的分割线
    lazy var rightLine: CALayer = {
        var line: CALayer = CALayer()
        line.backgroundColor = UIColor.transformColor(kTextColorWhite, alpha: 0.5).CGColor
        self.layer.addSublayer(line)
        return line
    }()

    override func awakeFromNib() {
        self.showsTouchWhenHighlighted = true
            
        countLabel.textAlignment = .Center
        textLabel.textAlignment = .Center
        
        countLabel.font = UIFont.systemFontOfSize(12.0)
        textLabel.font = UIFont.systemFontOfSize(9.0)
        
        countLabel.textColor = UIColor.whiteColor()
        textLabel.textColor = UIColor.whiteColor()

        
        self.addSubview(textLabel)
        self.addSubview(countLabel)
        
        var height = CGRectGetHeight(self.frame) / 2
        countLabel.mas_makeConstraints { make in
            make.top.equalTo()(self).offset()(3)
            make.left.equalTo()(self)
            make.right.equalTo()(self)
            make.height.equalTo()(height)
        }
        textLabel.mas_makeConstraints { make in
            make.top.equalTo()(self.countLabel.mas_bottom).offset()(-2)
            make.left.equalTo()(self)
            make.right.equalTo()(self)
            make.bottom.equalTo()(self)
        }
        self.setTitle("", forState: .Normal)
    } 
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if showLine {
            var width = CGRectGetWidth(self.frame)
            var lineHeight = CGRectGetHeight(self.frame) - 6
            rightLine.frame = CGRectMake(width, 3, 0.5, lineHeight)
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
