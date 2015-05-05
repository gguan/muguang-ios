//
//  MGPrivateMessageViewCell.swift
//  MuGuangIOS
//
//  Created by ZhangHao on 15/5/4.
//  Copyright (c) 2015年 北京目光璀璨科技有限公司. All rights reserved.
//

import UIKit

class MGPrivateMessageViewCell: UITableViewCell {

    @IBOutlet weak var grayView: UIView!
    @IBOutlet weak var avatarView: MGAvatarImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var number: UILabel!
    
    var clickedAvatar: (() -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.grayView.layer.masksToBounds = true
        self.grayView.layer.cornerRadius  = 5
        self.grayView.backgroundColor     = UIColor.transformColor(kColorLightGray, alpha: 1.0)
        self.avatarView.borderWidth       = 2
        self.nameLabel.textColor          = UIColor.blackColor()
        self.contentLabel.textColor       = UIColor.transformColor(kTextColorGray, alpha: 1.0)
        self.timeLabel.textColor          = UIColor.transformColor(kTextColorGray, alpha: 1.0)
        self.nameLabel.font               = UIFont.systemFontOfSize(12)
        self.contentLabel.font            = UIFont.systemFontOfSize(12)
        self.timeLabel.font               = UIFont.systemFontOfSize(10)
        self.number.font                  = UIFont.systemFontOfSize(9)
        self.number.textColor             = UIColor.whiteColor()
        self.number.textAlignment         = .Center
        self.number.backgroundColor       = UIColor.transformColor(kTextColorRed, alpha: 1.0)
        self.number.layer.masksToBounds   = true
        self.number.layer.cornerRadius    = 6
        
        var tapGR: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("methodForTouchAvatar:"))
        self.avatarView.addGestureRecognizer(tapGR)
    }
    
    func methodForTouchAvatar(tap: UITapGestureRecognizer) {
        if let clicked = self.clickedAvatar {
            clicked()
        }
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
