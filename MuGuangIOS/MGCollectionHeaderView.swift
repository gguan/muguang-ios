//
//  MGCollectionHeaderView.swift
//  MuGuangIOS
//
//  Created by ZhangHao on 15/4/24.
//  Copyright (c) 2015年 北京目光璀璨科技有限公司. All rights reserved.
//

import UIKit

class MGCollectionHeaderView: UICollectionReusableView {
    // 封面
    @IBOutlet weak var coverView: UIImageView!
    // 城市
    @IBOutlet weak var cityLabel: UILabel!
    // 头像＋用户名
    @IBOutlet weak var avatarView: MGAvatarView!
    // 个人说明
    @IBOutlet weak var briefLabel: UILabel!
    @IBOutlet weak var buttonView: UIView!
    // 照片按钮
    @IBOutlet weak var photoButton: MGUserButton!
    // 关注按钮
    @IBOutlet weak var focusButton: MGUserButton!
    // 粉丝按钮
    @IBOutlet weak var funsButton: MGUserButton!
    @IBOutlet weak var otherButtons: UIView!
    // 私信按钮
    @IBOutlet weak var sendMessage: UIButton!
    // 关注按钮
    @IBOutlet weak var followButton: UIButton!
    lazy var separateLine: CALayer = {
        var line: CALayer = CALayer()
        line.backgroundColor = UIColor.transformColor(kSeparateLineColorRed, alpha: 1.0).CGColor
        self.buttonView.layer.addSublayer(line)
        return line
    }()
    
    weak var delegate: MGCollectionHeaderViewDelegate?
    // 照片按钮的方法
    @IBAction func mothodForPhotoButton(sender: AnyObject) {
        self.delegate?.clickedPhotoButton()
    }
    // 关注按钮的方法
    @IBAction func methodForFocusButton(sender: AnyObject) {
        self.delegate?.clickedFocusButton()
    }
    // 粉丝按钮的方法
    @IBAction func methodForFunsButton(sender: AnyObject) {
        self.delegate?.clickedFansButton()
    }
    // 发私信
    @IBAction func methodForSendMessage(sender: AnyObject) {
        self.delegate?.clickedSendMessage()
    }
    // 关注
    @IBAction func methodForFollow(sender: AnyObject) {
        var button = sender as! UIButton
        button.selected = !button.selected
        self.delegate?.clickedFollow()
    }

    override func awakeFromNib() {
        self.briefLabel.textColor = UIColor.transformColor(kTextColorGray, alpha: 1.0)
        self.briefLabel.font = UIFont.systemFontOfSize(12.0)
        
        self.sendMessage.backgroundColor = UIColor.transformColor(kTextColorRed, alpha: 1.0)
        self.sendMessage.layer.masksToBounds = true
        self.sendMessage.layer.cornerRadius = 5
        self.sendMessage.titleLabel?.font = UIFont.systemFontOfSize(12.0)
        self.sendMessage.setTitle("私信", forState: .Normal)
        self.sendMessage.setImage(UIImage(named: "sendMessage"), forState: .Normal)
        self.sendMessage.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.sendMessage.adjustsImageWhenHighlighted = false
        self.sendMessage.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 5)
        
        self.followButton.backgroundColor = UIColor.transformColor(kTextColorRed, alpha: 1.0)
        self.followButton.layer.masksToBounds = true
        self.followButton.layer.cornerRadius = 5
        self.followButton.titleLabel?.font = UIFont.systemFontOfSize(12.0)
        self.followButton.setTitle("关注Ta", forState: .Normal)
        self.followButton.setTitle("已关注", forState: .Selected)
        self.followButton.setImage(UIImage(named: "add_follow"), forState: .Normal)
        self.followButton.setImage(UIImage(named: "followed"), forState: .Selected)
        self.followButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.separateLine.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), 0.5)
    }
}

protocol MGCollectionHeaderViewDelegate: NSObjectProtocol {
    /**
    *  点击照片
    */
    func clickedPhotoButton()
    /**
    *  点击关注
    */
    func clickedFocusButton()
    /**
    *  点击粉丝
    */
    func clickedFansButton()
    /**
    *  点击发私信
    */
    func clickedSendMessage()
    /**
    *  点击关注
    */
    func clickedFollow()
}