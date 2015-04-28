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

    // 封面加红色蒙版
    func setCoverImageByCIFilter(image: UIImage?) {
        // 模糊滤镜
        var filter: CIFilter = CIFilter(name: "CIGaussianBlur")
        filter.setValue(CIImage(CGImage: image!.CGImage), forKey: kCIInputImageKey)
        filter.setValue(2, forKey: "inputRadius")
        
//        let eaglContext = EAGLContext(API: EAGLRenderingAPI.OpenGLES2)
//        let options = [kCIContextWorkingColorSpace : NSNull()]
//        var ctx: CIContext =  CIContext(EAGLContext: eaglContext, options: options)
//
//        var outputImage = filter.outputImage
//        var filterImage = UIImage(CGImage: ctx.createCGImage(outputImage, fromRect: outputImage.extent()))

//        outputImage.imageByApplyingTransform(CGAffineTransformMakeTranslation(image!.size.width, image!.size.height))

        var outputImage = filter.outputImage

        // 从新生成图片大小
        var scale = UIScreen.mainScreen().scale
        var rect: CGRect = outputImage.extent()
        rect.origin.x    += (rect.size.width  - image!.size.width * scale ) / 2
        rect.origin.y    += (rect.size.height - image!.size.height * scale) / 2
        rect.size.width  = image!.size.width * scale
        rect.size.height = image!.size.height * scale

        var context: CIContext = CIContext(options: nil);
        var cgimg: CGImageRef  = context.createCGImage(outputImage, fromRect: rect);

        var filterImage = UIImage(CGImage: cgimg)
        
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


        self.coverView.image = filterImage
        self.coverView.contentMode = UIViewContentMode.ScaleAspectFill
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
        
        var redLayer = CALayer()
        redLayer.backgroundColor = UIColor.transformColor(kTextColorRed, alpha: 0.5).CGColor
        self.coverView.layer.addSublayer(redLayer)
        
        var tapGR1 = UITapGestureRecognizer(target: self, action: Selector("methodForTapAvatar:"))
        self.avatarView.addGestureRecognizer(tapGR1)
        
        self.coverView.userInteractionEnabled = true
        var tapGR2 = UITapGestureRecognizer(target: self, action: Selector("methodForTapCover:"))
        self.coverView.addGestureRecognizer(tapGR2)
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
        self.separateLine.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), 0.5)
        var redLayer = self.coverView.layer.sublayers[0] as? CALayer
        redLayer?.frame = self.coverView.bounds
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