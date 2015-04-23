//
//  MGButton.swift
//  MuGuangIOS
//
//  Created by ZhangHao on 15/4/23.
//  Copyright (c) 2015年 北京目光璀璨科技有限公司. All rights reserved.
//

import UIKit

class MGButton: UIButton {

    var tapAction: ((button: UIButton) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addTarget(self, action: Selector("methodForClicked:"), forControlEvents: .TouchUpInside)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func methodForClicked(button: UIButton) {
        if let closure = tapAction {
            closure(button: button)
        }
    }
    
    func addClicked(clicked: (button: UIButton) -> Void) {
        self.tapAction = clicked
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
