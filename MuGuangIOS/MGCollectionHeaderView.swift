//
//  MGCollectionHeaderView.swift
//  MuGuangIOS
//
//  Created by ZhangHao on 15/4/24.
//  Copyright (c) 2015年 北京目光璀璨科技有限公司. All rights reserved.
//

import UIKit
import QuartzCore
import CoreImage

let kUserInfoHeaderBlurViewAlpha: CGFloat = 1

class MGCollectionHeaderView: UICollectionReusableView {
    // 封面
    @IBOutlet weak var coverView: UIImageView!
    // 模糊背景
    @IBOutlet weak var blurView: FXBlurView!
    // 内容的容器
    @IBOutlet weak var contentView: UIView!
    // 城市
    @IBOutlet weak var cityLabel: UILabel!
    // 头像＋用户名
    @IBOutlet weak var avatarView: MGAvatarView!
    // 个人说明
    @IBOutlet weak var briefLabel: UILabel!
    // 按钮
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
    // 名字Label
    @IBOutlet weak var nameLabel: UILabel!
//    // 分割线
//    lazy var separateLine: CALayer = {
//        var line: CALayer = CALayer()
//        line.backgroundColor = UIColor.transformColor(kSeparateLineColorRed, alpha: 1.0).CGColor
//        self.buttonView.layer.addSublayer(line)
//        return line
//    }()
    
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

    // 封面加红色蒙版
    func setCoverImageByBlur(image: UIImage?) {
        // 模糊滤镜
//        var filterImage = image?.blurredImageWithRadius(2, iterations: 3, tintColor: UIColor.transformColor(kTextColorRed, alpha: 1))
//        // 蒙版
//        var targetSize = self.coverView.bounds.size
//        UIGraphicsBeginImageContext(targetSize)
//        var context: CGContextRef = UIGraphicsGetCurrentContext();
//        filterImage?.drawInRect(self.coverView.bounds)
//        
////        var color = UIColor.transformColor("d81e04", alpha: 1)
////        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
////        color.getRed(&r, green: &g, blue: &b, alpha: &a)
////        // overlay a red rectangle
////        CGContextSetBlendMode(context, kCGBlendModeOverlay)
////        CGContextSetRGBFillColor (context, r, g, b, a);
//        CGContextFillRect(context, self.coverView.bounds)
//        
//        // redraw gem
//        filterImage?.drawInRect(self.coverView.bounds, blendMode: kCGBlendModeDestinationIn, alpha: 1.0)
//        filterImage = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();

        self.coverView.image = image
    }
    
    override func awakeFromNib() {
    
        self.blurView.blurRadius = 10
        self.blurView.tintColor = UIColor.whiteColor()
        self.blurView.dynamic = false
        self.blurView.alpha = kUserInfoHeaderBlurViewAlpha

        self.briefLabel.textColor = UIColor.whiteColor()
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
        
        var tapGR1 = UITapGestureRecognizer(target: self, action: Selector("methodForTapAvatar:"))
        self.avatarView.addGestureRecognizer(tapGR1)
        
        var tapGR2 = UITapGestureRecognizer(target: self, action: Selector("methodForTapCover:"))
        self.contentView.addGestureRecognizer(tapGR2)
    }
    
    // 点击的手势
    func methodForTapAvatar(tap: UITapGestureRecognizer) {
        self.delegate?.clickedAvatar()
    }
    func methodForTapCover(tap: UITapGestureRecognizer) {
        self.delegate?.clickedCover()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        self.separateLine.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), 0.5)
        self.photoButton.countLabel.textColor = UIColor.transformColor(kTextColorRed, alpha: 1.0)
        self.photoButton.textLabel.textColor = UIColor.transformColor(kTextColorRed, alpha: 1.0)

    }
}

protocol MGCollectionHeaderViewDelegate: NSObjectProtocol {
    /**
    *  点击封面
    */
    func clickedCover()
    /**
    *  点击头像
    */
    func clickedAvatar()
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