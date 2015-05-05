//
//  MGYouCell.swift
//  MuGuangIOS
//
//  Created by ZhangHao on 15/5/4.
//  Copyright (c) 2015年 北京目光璀璨科技有限公司. All rights reserved.
//

import UIKit

enum MGYouCellStyle {
    case Image
    case Button
}


class MGYouCell: UITableViewCell {

    @IBOutlet weak var avatarView: MGAvatarImageView!
    
    @IBOutlet weak var backView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var thumbPhoto: UIImageView!
    @IBOutlet weak var focusButton: UIButton!
    
    var clickedAvatar: (() -> Void)?

    var cellStyle: MGYouCellStyle {
        didSet {
            if self.cellStyle == .Image {
                self.focusButton.hidden = true
                self.thumbPhoto.hidden = false
            } else if self.cellStyle == .Button {
                self.focusButton.hidden = false
                self.thumbPhoto.hidden = true
            }
        }
    }
    
    required init(coder aDecoder: NSCoder) {
        cellStyle = .Image
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backView.image = UIImage(named: "message_you_background")?.resizableImageWithCapInsets(UIEdgeInsetsMake(10, 15, 10, 15), resizingMode: UIImageResizingMode.Stretch)
        self.avatarView.borderWidth = 2
        self.nameLabel.textColor    = UIColor.blackColor()
        self.timeLabel.textColor    = UIColor.transformColor(kTextColorGray, alpha: 1.0)
        self.nameLabel.font         = UIFont.systemFontOfSize(12)
        self.timeLabel.font         = UIFont.systemFontOfSize(10)
        
        // 按钮样式
        self.focusButton.setTitle("已关注", forState: .Normal)
        self.focusButton.setBackgroundImage(UIColor.imageFromColor(UIColor.transformColor(kTextColorRed, alpha: 1.0), size: self.focusButton.frame.size), forState: .Normal)
        self.focusButton.setTitle("关注Ta", forState: .Selected)
        self.focusButton.setBackgroundImage(UIColor.imageFromColor(UIColor.transformColor(kTextColorGray, alpha: 1.0), size: self.focusButton.frame.size), forState: .Selected)
        self.focusButton.layer.cornerRadius = 5
        self.focusButton.layer.masksToBounds = true
        self.focusButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.focusButton.titleLabel?.font = UIFont.systemFontOfSize(12)
        self.focusButton.adjustsImageWhenHighlighted = false
        self.focusButton.addTarget(self, action: Selector("methodForFocusButton:"), forControlEvents: .TouchUpInside)
        
        var tapGR: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("methodForTouchAvatar:"))
        self.avatarView.addGestureRecognizer(tapGR)
    }

    func methodForTouchAvatar(tap: UITapGestureRecognizer) {
        if let clicked = self.clickedAvatar {
            clicked()
        }
    }
    
    func methodForFocusButton(sender: UIButton) {
        sender.selected = !sender.selected
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


}
