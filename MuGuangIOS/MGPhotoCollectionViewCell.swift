//
//  MGPhotoCollectionViewCell.swift
//  MuGuangIOS
//
//  Created by ZhangHao on 15/4/27.
//  Copyright (c) 2015年 北京目光璀璨科技有限公司. All rights reserved.
//

import UIKit

class MGPhotoCollectionViewCell: UICollectionViewCell {
    lazy var imageView: UIImageView = {
       var view = UIImageView(frame: CGRectZero)
        view.backgroundColor = UIColor.clearColor()
        self.contentView.addSubview(view)
        return view
    }()
    
    lazy var backView: UIView = {
        var view = UIView(frame: CGRectZero)
        view.backgroundColor = UIColor.transformColor("000000", alpha: 0.6)
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 6
        self.contentView.addSubview(view)
        return view
    }()
    
    lazy var iconView: UIImageView = {
        var view = UIImageView(frame: CGRectZero)
        view.backgroundColor = UIColor.clearColor()
        view.image = UIImage(named: "photo_count")
        return view
    }()
    
    lazy var countLabel: UILabel = {
        var label = UILabel(frame: CGRectZero)
        label.backgroundColor = UIColor.clearColor()
        label.textColor = UIColor.whiteColor()
        label.textAlignment = .Right
        label.font = UIFont.systemFontOfSize(9)
        label.text = "9"
        return label
    }()
    
    override func awakeFromNib() {
        imageView.frame = self.bounds
        backView.mas_makeConstraints { make in
            make.width.equalTo()(24)
            make.height.equalTo()(12)
            make.bottom.right().equalTo()(self).offset()(-5)
        }
        
        backView.addSubview(iconView)
        backView.addSubview(countLabel)
        
        iconView.mas_makeConstraints { make in
            make.width.equalTo()(12)
            make.height.equalTo()(10)
            make.left.equalTo()(self.backView).offset()(3)
            make.centerY.equalTo()(self.backView)
        }
        
        countLabel.mas_makeConstraints { make in
            make.width.equalTo()(10)
            make.height.equalTo()(10)
            make.right.equalTo()(self.backView).offset()(-3)
            make.centerY.equalTo()(self.backView)
        }
    }
}
