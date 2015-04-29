//
//  MGSetingCell.swift
//  MuGuangIOS
//
//  Created by ZhangHao on 15/4/28.
//  Copyright (c) 2015年 北京目光璀璨科技有限公司. All rights reserved.
//

import UIKit

class MGSettingCell: UITableViewCell {

    // 背景灰色圆角View
    @IBOutlet weak var backView: UIView!
    // 红色箭头
    @IBOutlet weak var redArrow: UIImageView!

    // 名字
    @IBOutlet weak var nameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backView.backgroundColor = UIColor.transformColor(kColorLightGray, alpha: 1.0)
        self.backView.layer.cornerRadius = kCellCornerRadius
        self.nameLabel.textColor = UIColor.transformColor(kTextColorGray, alpha: 1.0)
        self.nameLabel.font = UIFont.systemFontOfSize(12.0)
        self.nameLabel.textAlignment = .Left
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
