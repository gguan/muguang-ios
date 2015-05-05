//
//  MGPraiseCell.swift
//  MuGuangIOS
//
//  Created by ZhangHao on 15/5/5.
//  Copyright (c) 2015年 北京目光璀璨科技有限公司. All rights reserved.
//

import UIKit

class MGPraiseCell: UITableViewCell {

    @IBOutlet weak var avatarView: MGAvatarImageView!
    @IBOutlet weak var backView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var thumbPhoto: UIImageView!
    @IBOutlet weak var emojiView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backView.image = UIImage(named: "message_you_background")?.resizableImageWithCapInsets(UIEdgeInsetsMake(10, 15, 10, 15), resizingMode: UIImageResizingMode.Stretch)
        self.avatarView.borderWidth = 2
        self.nameLabel.textColor    = UIColor.blackColor()
        self.timeLabel.textColor    = UIColor.transformColor(kTextColorGray, alpha: 1.0)
        self.contentLabel.textColor = UIColor.transformColor(kTextColorGray, alpha: 1.0)
        self.nameLabel.font         = UIFont.systemFontOfSize(12)
        self.timeLabel.font         = UIFont.systemFontOfSize(10)
        self.contentLabel.font      = UIFont.systemFontOfSize(12)
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
