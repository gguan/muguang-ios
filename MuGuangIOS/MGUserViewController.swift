//
//  MGUserViewController.swift
//  MuGuangIOS
//
//  Created by ZhangHao on 15/4/21.
//  Copyright (c) 2015年 北京目光璀璨科技有限公司. All rights reserved.
//

import UIKit

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

let kUserInfoCollectionPadding: CGFloat = 1
let kUserInfoCollectionItemOfRow: CGFloat = 3

class MGUserViewController: MGBaseViewController, UICollectionViewDataSource, UICollectionViewDelegate, MGCollectionHeaderViewDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate {
    
    @IBOutlet weak var photoView: UICollectionView!
    // 返回按钮的方法
    @IBAction func methodForBackButton(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    // 是否是个人信息页
    var isMyInfo: Bool = false
    var isSetAvatar: Bool = false
    // 设置按钮
    @IBOutlet weak var settingButton: UIButton!
    
    // 设置按钮的方法
    @IBAction func methodForSettingButton(sender: AnyObject) {
        if self.isMyInfo {
            self.performSegueWithIdentifier("pushToSetting", sender: self)
        } else {
            var actionSheet = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil)
            actionSheet.tag = 200
            actionSheet.addButtonWithTitle("加入黑名单")
            actionSheet.addButtonWithTitle("不让Ta看我的动态")
            actionSheet.showInView(self.view)
        }
    }
    
    var reusableView: MGCollectionHeaderView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        // Do any additional setup after loading the view.
        if self.isMyInfo {
            self.settingButton.setImage(UIImage(named: "setting"), forState: .Normal)
        } else {
            self.settingButton.setImage(UIImage(named: "set_limits"), forState: .Normal)
        }
        
        var flowLayout = self.photoView.collectionViewLayout as! CSStickyHeaderFlowLayout
        flowLayout.parallaxHeaderReferenceSize = CGSizeMake(self.view.frame.size.width, 300)
        flowLayout.parallaxHeaderMinimumReferenceSize = CGSizeMake(self.view.frame.size.width, 64)
        flowLayout.parallaxHeaderAlwaysOnTop = true
        
        self.photoView.registerNib(UINib(nibName: "MGCollectionHeaderView", bundle: NSBundle.mainBundle()), forSupplementaryViewOfKind: CSStickyHeaderParallaxHeader, withReuseIdentifier: CSStickyHeaderParallaxHeader)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(kUserInfoCollectionPadding, 0, 0, kUserInfoCollectionPadding)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return kUserInfoCollectionPadding
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        var width = (CGRectGetWidth(self.view.frame) - kUserInfoCollectionPadding * kUserInfoCollectionItemOfRow) / kUserInfoCollectionItemOfRow
        return CGSizeMake(width, width)
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        if kind == CSStickyHeaderParallaxHeader {
            // 设置headerView
            reusableView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: CSStickyHeaderParallaxHeader, forIndexPath: indexPath) as? MGCollectionHeaderView
            reusableView!.setCoverImageByBlur(UIImage(named: "cover_placeholder"))
            reusableView!.avatarView.setAvatarImage(UIImage(named: "avatar_placeholder"))
            reusableView!.avatarView.setAvatarTitle("满-江-红")
            reusableView!.delegate = self
            reusableView!.briefLabel.text = "壮志饥餐胡虏肉，笑谈渴饮匈奴血。待从头、收拾旧山河，朝天阙。"
            if self.isMyInfo {
                reusableView!.otherButtons.hidden = true
            } else {
                reusableView!.otherButtons.hidden = false
                reusableView!.frame.size.height = 300 + 30
            }
            return reusableView!
        }
        return UICollectionReusableView()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("MGPhotoCollectionViewCell", forIndexPath: indexPath) as! MGPhotoCollectionViewCell
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        println(indexPath)
    }
    
    // MARK: MGCollectionHeaderViewDelegate
    // 点击封面
    func clickedCover() {
        var actionSheet = UIActionSheet(title: "更换封面", delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil)
        actionSheet.tag = 300
        actionSheet.addButtonWithTitle("拍摄新照片")
        actionSheet.addButtonWithTitle("相册中挑选")
        actionSheet.showInView(self.view)
    }
    // 头像
    func clickedAvatar() {
        if self.isMyInfo {
            var actionSheet = UIActionSheet(title: "更换头像", delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil)
            actionSheet.tag = 100
            actionSheet.addButtonWithTitle("拍摄新照片")
            actionSheet.addButtonWithTitle("相册中挑选")
            actionSheet.showInView(self.view)
        } else {
            // 显示大图
        }
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
    
    // MARK: - UIActionSheetDelegate
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        println(buttonIndex)
        if actionSheet.tag == 100 {
            // 点击头像
            self.isSetAvatar = true
            if buttonIndex == 1 {
                // 拍摄新照片
                var imagePicker = UIImagePickerController()
                if UIImagePickerController.isSourceTypeAvailable(.Camera) {
                    imagePicker.sourceType = .Camera
                    imagePicker.delegate = self
                    self.presentViewController(imagePicker, animated: true, completion: nil)
                } else {
                    var alertView = UIAlertView()
                    alertView.title = "没有权限"
                    alertView.addButtonWithTitle("确定")
                    alertView.show()
                }
            } else if buttonIndex == 2 {
                // 相册中挑选
                var imagePicker = UIImagePickerController()
                if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
                    imagePicker.sourceType = .PhotoLibrary
                    imagePicker.delegate = self
                    self.presentViewController(imagePicker, animated: true, completion: nil)
                } else {
                    var alertView = UIAlertView()
                    alertView.title = "没有权限"
                    alertView.addButtonWithTitle("确定")
                    alertView.show()
                }
            }
        } else if actionSheet.tag == 200 {
            // 点击权限按钮
            if buttonIndex == 1 {
                // 加入黑名单
                
            } else if buttonIndex == 2 {
                // 不让Ta看我的动态
                
            }
        } else if actionSheet.tag == 300 {
            // 点击头像
            self.isSetAvatar = false
            if buttonIndex == 1 {
                // 拍摄新照片
                var imagePicker = UIImagePickerController()
                if UIImagePickerController.isSourceTypeAvailable(.Camera) {
                    imagePicker.sourceType = .Camera
                    imagePicker.delegate = self
                    self.presentViewController(imagePicker, animated: true, completion: nil)
                } else {
                    var alertView = UIAlertView()
                    alertView.title = "没有权限"
                    alertView.addButtonWithTitle("确定")
                    alertView.show()
                }
            } else if buttonIndex == 2 {
                // 相册中挑选
                var imagePicker = UIImagePickerController()
                if UIImagePickerController.isSourceTypeAvailable(.PhotoLibrary) {
                    imagePicker.sourceType = .PhotoLibrary
                    imagePicker.delegate = self
                    self.presentViewController(imagePicker, animated: true, completion: nil)
                } else {
                    var alertView = UIAlertView()
                    alertView.title = "没有权限"
                    alertView.addButtonWithTitle("确定")
                    alertView.show()
                }
            }
        }
    }

    // MARK: - UIImagePickerControllerDelegate
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        println(info)
        var image = info[UIImagePickerControllerOriginalImage] as! UIImage
        if self.isSetAvatar {
            // 头像
            reusableView!.avatarView.setAvatarImage(image)
        } else {
            // 封面
            reusableView?.setCoverImageByBlur(image)
            // 刷新模糊层
            reusableView?.blurView.updateAsynchronously(true, completion: nil)
        }
        picker.dismissViewControllerAnimated(true, completion: nil)
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
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        self.reusableView?.blurView.blurEnabled = false
        var offset = scrollView.contentOffset
        var alpha = offset.y / 240
        if offset.y > 0 {
            self.reusableView?.contentView.alpha = 1 - alpha
        } else {
            self.reusableView?.contentView.alpha = 1
            self.reusableView?.nameLabel.alpha = 0
            self.reusableView?.blurView.alpha = 1 + alpha * 4
        }
        if offset.y > 220 {
            self.reusableView?.nameLabel.alpha = 1
        } else {
            self.reusableView?.nameLabel.alpha = 0
        }
    }

}
