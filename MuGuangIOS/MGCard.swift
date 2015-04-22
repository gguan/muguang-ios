//
//  MGCard.swift
//  MuGuangIOS
//
//  Created by ZhangHao on 15/4/21.
//  Copyright (c) 2015年 北京目光璀璨科技有限公司. All rights reserved.
//

import UIKit

// 边框宽
let kCardBorderWidth: CGFloat  = 3.0
// 头像的直径
let kCardAvatarWidth: CGFloat  = 35
// 卡片背景的宽
let kCardWidth: CGFloat        = 205.0
// 卡片背景的高
let kCardHeight: CGFloat       = 80.0
// 缩略图的宽
let kCardPictureWidth: CGFloat = 60.0
// 卡片的圆角
let kCardRadiuWidth: CGFloat   = 18.0
// 间距
let kCardPadding: CGFloat      = 5

/**
*  用户头像
*/
class MGAvatar: UIImageView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.masksToBounds = true
        self.layer.cornerRadius = kCardAvatarWidth / 2
        self.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.38).CGColor
        self.layer.borderWidth = kCardBorderWidth - 1
        self.backgroundColor = UIColor.grayColor()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}

/**
*  主界面附近动态的卡片
*/
class MGCard: UIView {
    // 头像
    let avatar: MGAvatar = MGAvatar(frame: CGRectZero)
    // 模糊的背景
    let blurView: FXBlurView = FXBlurView(frame: CGRectZero)
    // 名字
    let nameLabel: UILabel = UILabel(frame: CGRectZero)
    // 性别
    let sex: UIImageView = UIImageView(frame: CGRectZero)
    // 文字
    let textLabel: UILabel = UILabel(frame: CGRectZero)
    // 距离
    let distanceLabel: UILabel = UILabel(frame: CGRectZero)
    // 时间Logo
    let timeLogo: UIImageView = UIImageView(frame: CGRectZero)
    // 时间
    let timeLabel: UILabel = UILabel(frame: CGRectZero)
    // 缩略图
    let thumb: UIImageView = UIImageView(frame: CGRectZero)
    
    weak var delegate: MGCardDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        self.addSubview(blurView)
        self.addSubview(avatar)
        self.addSubview(nameLabel)
        self.addSubview(sex)
        self.addSubview(textLabel)
        self.addSubview(distanceLabel)
        self.addSubview(timeLogo)
        self.addSubview(timeLabel)
        self.addSubview(thumb)
        
        // 头像
        avatar.userInteractionEnabled = true
        
        // 模糊层
        blurView.layer.masksToBounds = true
        blurView.layer.cornerRadius = kCardRadiuWidth
        blurView.layer.borderWidth = kCardBorderWidth
        blurView.layer.borderColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.38).CGColor
        blurView.blurRadius = 10.0
        blurView.tintColor = UIColor.clearColor()

        // 名字
        nameLabel.numberOfLines = 1
        nameLabel.lineBreakMode = .ByTruncatingTail
        nameLabel.textAlignment = NSTextAlignment.Left
        nameLabel.textColor = UIColor.whiteColor()
        nameLabel.text = "李白李白李白李白李白李白"
        nameLabel.font = UIFont.boldSystemFontOfSize(13)

        // 性别
        sex.backgroundColor = UIColor.blueColor()
        
        // 文字
        textLabel.numberOfLines = 0
        textLabel.lineBreakMode = .ByTruncatingTail
        textLabel.textColor = UIColor.whiteColor()
        textLabel.text = "朝辞白帝彩云间，千里江陵一日还。两岸猿声啼不尽，轻舟已过万重山。"
        textLabel.font = UIFont.systemFontOfSize(13)

        // 距离
        distanceLabel.textColor = UIColor.whiteColor()
        distanceLabel.text = "距离800m"
        distanceLabel.font = UIFont.systemFontOfSize(11)

        // 时间logo
        timeLogo.backgroundColor = UIColor.yellowColor()
            
        // 时间
        timeLabel.textColor = UIColor.whiteColor()
        timeLabel.text = "5小时前"
        timeLabel.font = UIFont.systemFontOfSize(11)
        
        // 缩略图
        thumb.backgroundColor = UIColor.greenColor()
    
        
        // 添加布局
        // 头像
        avatar.mas_makeConstraints { make in
            make.top.left().equalTo()(self)
            make.width.height().equalTo()(kCardAvatarWidth)
        }
        // 模糊的背景
        blurView.mas_makeConstraints { make in
            make.left.top().equalTo()(self).offset()(kCardAvatarWidth / 2)
            make.width.equalTo()(kCardWidth)
            make.height.equalTo()(kCardHeight)
        }
        // 名字
        nameLabel.mas_makeConstraints { make in
            make.top.equalTo()(self.blurView).offset()(kCardPadding * 1.5)
            make.left.equalTo()(self.blurView).offset()(kCardAvatarWidth / 2 + kCardPadding)
            make.height.equalTo()(15)
        }
        
        // 性别
        sex.mas_makeConstraints { make in
            make.left.equalTo()(self.nameLabel.mas_right).offset()(kCardPadding)
            make.top.and().height().equalTo()(self.nameLabel)
            make.width.equalTo()(15)
        }
        // 文字
        textLabel.mas_makeConstraints { make in
            make.top.equalTo()(self.nameLabel.mas_bottom)
            make.left.equalTo()(self.blurView).offset()(kCardPadding * 2)
            make.right.equalTo()(self.thumb.mas_left).offset()(-kCardPadding)
            make.bottom.equalTo()(self.distanceLabel.mas_top)
        }
        // 距离
        distanceLabel.mas_makeConstraints { make in
            make.left.equalTo()(self.textLabel)
            make.bottom.equalTo()(self.thumb)
            make.height.equalTo()(10)
            make.right.equalTo()(self.timeLogo.mas_left).offset()(-kCardPadding)
        }
        // 时间Logo
        timeLogo.mas_makeConstraints { make in
            make.right.equalTo()(self.timeLabel.mas_left).offset()(-kCardPadding)
            make.bottom.and().height().equalTo()(self.distanceLabel)
            make.height.and().width().equalTo()(self.distanceLabel.mas_height)
        }
        // 时间
        timeLabel.mas_makeConstraints { make in
            make.right.equalTo()(self.thumb.mas_left).offset()(-kCardPadding)
            make.bottom.and().height().equalTo()(self.distanceLabel)
            make.width.equalTo()(40)
            make.height.equalTo()(self.distanceLabel)
        }
        // 缩略图
        thumb.mas_makeConstraints { make in
            make.right.equalTo()(self.blurView).offset()(-kCardPadding * 2)
            make.top.equalTo()(self.blurView).offset()(kCardPadding * 2)
            make.bottom.equalTo()(self.blurView).offset()(-kCardPadding * 2)
            make.width.equalTo()(kCardPictureWidth)
        }
        
        
        // 添加手势
        var panGR: UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: Selector("methodForPanGestureRecognizer:"))
        self.addGestureRecognizer(panGR)
        
        var tapAvatar = UITapGestureRecognizer(target: self, action: Selector("tapAvatar:"))
        self.avatar.addGestureRecognizer(tapAvatar)
        
        var tapBlurView = UITapGestureRecognizer(target: self, action: Selector("tapBlurView:"))
        self.blurView.addGestureRecognizer(tapBlurView)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // 点击头像
    func tapAvatar(tap: UITapGestureRecognizer) {
        self.delegate?.showUserInfo!()
    }
    
    // 点击内容
    func tapBlurView(tap: UITapGestureRecognizer) {
        self.delegate?.showCardDetail!()
    }
    
    // drag的手势
    func methodForPanGestureRecognizer(pan: UIPanGestureRecognizer) {
        // 只有相机在非运行状态下才能移动view
        for var next = self.superview; next != nil; next = next?.superview {
            if let responder = next?.nextResponder() {
                if responder.isKindOfClass(MGMainViewController.classForCoder()) {
                    var viewController: MGMainViewController = responder as! MGMainViewController
                    if let captureSession = viewController.cameraView.captureSession {
                        if !captureSession.running {
                            var translation = pan.translationInView(self.superview!)
                            pan.view?.center = CGPointMake(pan.view!.center.x + translation.x,
                                pan.view!.center.y + translation.y)
                            pan.setTranslation(CGPointMake(0, 0), inView: self.superview)
                        }
                    }
                    break
                }
            }
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var width = CGRectGetWidth(blurView.frame) - kCardPictureWidth - kCardPadding * 4 - kCardAvatarWidth / 2 - 20
//        nameLabel.preferredMaxLayoutWidth = width
        var originSize = nameLabel.frame.size
        var size = nameLabel.sizeThatFits(CGSizeMake(width, originSize.height))
        if size.width > width {
            nameLabel.frame.size = CGSizeMake(width, size.height)
        } else {
            nameLabel.frame.size = CGSizeMake(size.width, size.height)
        }
        // 更新性别图片的位置
        sex.frame.origin = CGPointMake(CGRectGetMaxX(nameLabel.frame) + kCardPadding, sex.frame.origin.y)
        super.layoutSubviews()
    }
}

// 卡片的回调
@objc protocol MGCardDelegate {
    optional func showUserInfo()
    optional func showCardDetail()
}
