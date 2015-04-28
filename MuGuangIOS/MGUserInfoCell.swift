//
//  MGUserInfoCell.swift
//  MuGuangIOS
//
//  Created by ZhangHao on 15/4/28.
//  Copyright (c) 2015年 北京目光璀璨科技有限公司. All rights reserved.
//

import UIKit

/**
*  设置页面设置个人信息的cell
*/
class MGUserInfoCell: UITableViewCell {

    // 背景色view
    @IBOutlet weak var backView: UIView!
    // 头像
    @IBOutlet weak var avatarView: MGAvatarImageView!
    // 名字
    @IBOutlet weak var nameLabel: UILabel!
    // 个人说明
    @IBOutlet weak var briefLabel: UILabel!
    // 性别
    @IBOutlet weak var sex: UIImageView!
    
    // 设置性别
    func setSexIcon(sexString: String?) {
        if sexString == "1" {
            self.sex.image = UIImage(named: "sex1")
        } else if sexString == "2" {
            self.sex.image = UIImage(named: "sex2")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backView.backgroundColor = UIColor.transformColor(kColorLightGray, alpha: 1.0)
        self.backView.layer.cornerRadius = kCellCornerRadius
        self.avatarView.borderColor = UIColor.transformColor(kTextColorWhite, alpha: 0.5)
        
        self.nameLabel.textColor = UIColor.transformColor(kTextColorGray, alpha: 1.0)
        self.nameLabel.font = UIFont.systemFontOfSize(12.0)
        self.nameLabel.textAlignment = .Left
        self.nameLabel.preferredMaxLayoutWidth = 200
        
        self.briefLabel.textColor = UIColor.transformColor(kTextColorGray, alpha: 1.0)
        self.briefLabel.font = UIFont.systemFontOfSize(12.0)
        self.briefLabel.textAlignment = .Left
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
