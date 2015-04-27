//
//  MGUserViewController.swift
//  MuGuangIOS
//
//  Created by ZhangHao on 15/4/21.
//  Copyright (c) 2015年 北京目光璀璨科技有限公司. All rights reserved.
//

import UIKit

let kTextColorRed = "f3361d"
let kTextColorWhite = "ffffff"
let kTextColorGray = "686868"
let kSeparateLineColorRed = "fab5ac"

extension UIColor {
    // 转换颜色 HEX -> RGB
    class func transformColor(colorString: String!, alpha: CGFloat!) -> UIColor {
        var scanner = NSScanner(string: colorString)
        var color: UInt32 = 0;
        scanner.scanHexInt(&color)
        let mask = 0x000000FF
        let r = CGFloat(Float(Int(color >> 16) & mask) / 255.0)
        let g = CGFloat(Float(Int(color >> 8) & mask) / 255.0)
        let b = CGFloat(Float(Int(color) & mask) / 255.0)
        return UIColor(red: r, green: g, blue: b, alpha: CGFloat(alpha))
    }
}

class MGUserViewController: MGBaseViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, MGCollectionHeaderViewDelegate {
    
    @IBOutlet weak var photoView: UICollectionView!
    // 返回按钮的方法
    @IBAction func methodForBackButton(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // 是否是个人信息页
    var isMyInfo: Bool = false
    // 设置按钮
    @IBOutlet weak var settingButton: UIButton!
    
    // 设置按钮的方法
    @IBAction func methodForSettingButton(sender: AnyObject) {
        if self.isMyInfo {
            self.performSegueWithIdentifier("pushToSetting", sender: self)
        } else {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        // Do any additional setup after loading the view.
        if self.isMyInfo {
            self.settingButton.setImage(UIImage(named: "setting"), forState: .Normal)
        } else {
            self.settingButton.setImage(UIImage(named: "set_limits"), forState: .Normal)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(5,5,5,5)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        var width = (CGRectGetWidth(self.view.frame) - 5 * 4) / 3
        return CGSizeMake(width, width)
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        // 设置headerView
        var reusableView: MGCollectionHeaderView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "MGCollectionHeaderView", forIndexPath: indexPath) as! MGCollectionHeaderView
        reusableView.setCoverImageByCIFilter(UIImage(named: "cover_placeholder"))
        reusableView.avatarView.avatarView.image = UIImage(named: "avatar_placeholder")
        reusableView.avatarView.setAvatarTitle("满-江-红")
        reusableView.delegate = self
        reusableView.briefLabel.text = "壮志饥餐胡虏肉，笑谈渴饮匈奴血。待从头、收拾旧山河，朝天阙。"
        if self.isMyInfo {
            reusableView.otherButtons.hidden = true
        } else {
            reusableView.otherButtons.hidden = false
            reusableView.frame.size.height = 300 + 30
        }
        return reusableView
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("MGPhotoCollectionViewCell", forIndexPath: indexPath) as! MGPhotoCollectionViewCell
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        println(indexPath)
    }
    
    // MARK: MGCollectionHeaderViewDelegate
    // 头像
    func clickedAvatar() {
        println("头像")
    }
    // 照片
    func clickedPhotoButton() {
        println("照片")
    }
    // 关注
    func clickedFocusButton() {
        println("关注")
    }
    // 粉丝
    func clickedFansButton() {
        println("粉丝")
    }
    // 发私信
    func clickedSendMessage() {
        println("发私信")
    }
    // 关注
    func clickedFollow() {
        println("关注")
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "pushToCardDetail" {
            println("==pushToCardDetail")
        } else if segue.identifier == "pushToSetting" {
            println("==pushToSetting")
        } else if segue.identifier == "pushToFocus" {
            println("==pushToFocus")
        } else if segue.identifier == "pushToFans" {
            println("==pushToFans")
        }
    }

}
