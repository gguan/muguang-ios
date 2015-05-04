//
//  MGMarkButton.swift
//  MuGuangIOS
//
//  Created by ZhangHao on 15/5/4.
//  Copyright (c) 2015年 北京目光璀璨科技有限公司. All rights reserved.
//

import UIKit

class MGMarkButton: UIButton {

    lazy var redPoint: UIView = {
        var red = UIView(frame: CGRectZero)
        red.layer.masksToBounds = true
        red.layer.cornerRadius = 2
        red.backgroundColor = UIColor.transformColor(kTextColorRed, alpha: 1.0)
        red.hidden = true
        self.addSubview(red)
        red.mas_makeConstraints({ make in
            make.centerX.equalTo()(self.titleLabel?.mas_right).offset()(10)
            make.centerY.equalTo()(self)
            make.width.equalTo()(4)
            make.height.equalTo()(4)
        })
        return red
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.redPoint.hidden = false
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
