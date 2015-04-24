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
    // 照片按钮
    @IBOutlet weak var photoButton: MGUserButton!
    // 关注按钮
    @IBOutlet weak var focusButton: MGUserButton!
    // 粉丝按钮
    @IBOutlet weak var funsButton: MGUserButton!
    
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
        self.delegate?.clickedFunsButton()
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
    func clickedFunsButton()
}