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

class MGUserViewController: MGBaseViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, MGCollectionHeaderViewDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIScrollViewDelegate {
    
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
        if kind == UICollectionElementKindSectionHeader {
            // 设置headerView
            reusableView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "MGCollectionHeaderView", forIndexPath: indexPath) as? MGCollectionHeaderView
            reusableView!.setCoverImageByCIFilter(UIImage(named: "cover_placeholder"))
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
            reusableView?.setCoverImageByCIFilter(image)
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
        
    }

}

class StickyHeaderCollectionViewFlowLayout: UICollectionViewFlowLayout {
    
    override func layoutAttributesForElementsInRect(rect: CGRect) -> [AnyObject]? {
        
//        var answer: [UICollectionViewLayoutAttributes] = super.layoutAttributesForElementsInRect(rect)! as! [UICollectionViewLayoutAttributes]
//        let contentOffset = collectionView!.contentOffset
//        
//        var missingSections = NSMutableIndexSet()
//        
//        for layoutAttributes in answer {
//            if (layoutAttributes.representedElementCategory == .Cell) {
//                if let indexPath = layoutAttributes.indexPath {
//                    missingSections.addIndex(layoutAttributes.indexPath.section)
//                }
//            }
//        }
//        
//        for layoutAttributes in answer {
//            if let representedElementKind = layoutAttributes.representedElementKind {
//                if representedElementKind == UICollectionElementKindSectionHeader {
//                    if let indexPath = layoutAttributes.indexPath {
//                        missingSections.removeIndex(indexPath.section)
//                    }
//                }
//            }
//        }
//        
//        missingSections.enumerateIndexesUsingBlock { idx, stop in
//            let indexPath = NSIndexPath(forItem: 0, inSection: idx)
//            if let layoutAttributes = self.layoutAttributesForSupplementaryViewOfKind(UICollectionElementKindSectionHeader, atIndexPath: indexPath) {
//                answer.append(layoutAttributes)
//            }
//        }
//        
//        for layoutAttributes in answer {
//            if let representedElementKind = layoutAttributes.representedElementKind {
//                if representedElementKind == UICollectionElementKindSectionHeader {
//                    let section = layoutAttributes.indexPath!.section
//                    let numberOfItemsInSection = collectionView!.numberOfItemsInSection(section)
//                    
//                    let firstCellIndexPath = NSIndexPath(forItem: 0, inSection: section)!
//                    let lastCellIndexPath = NSIndexPath(forItem: max(0, (numberOfItemsInSection - 1)), inSection: section)!
//                    
//                    
//                    let (firstCellAttributes: UICollectionViewLayoutAttributes, lastCellAttributes: UICollectionViewLayoutAttributes) = {
//                        if (self.collectionView!.numberOfItemsInSection(section) > 0) {
//                            return (
//                                self.layoutAttributesForItemAtIndexPath(firstCellIndexPath),
//                                self.layoutAttributesForItemAtIndexPath(lastCellIndexPath))
//                        } else {
//                            return (
//                                self.layoutAttributesForSupplementaryViewOfKind(UICollectionElementKindSectionHeader, atIndexPath: firstCellIndexPath),
//                                self.layoutAttributesForSupplementaryViewOfKind(UICollectionElementKindSectionFooter, atIndexPath: lastCellIndexPath))
//                        }
//                        }()
//                    
//                    let headerHeight = CGRectGetHeight(layoutAttributes.frame)
//                    var origin = layoutAttributes.frame.origin
//                    
//                    origin.y = min(max(contentOffset.y, (CGRectGetMinY(firstCellAttributes.frame) - headerHeight)), (CGRectGetMaxY(lastCellAttributes.frame) - headerHeight))
//                    
//                    layoutAttributes.zIndex = 1024
//                    layoutAttributes.frame = CGRect(origin: origin, size: layoutAttributes.frame.size)
//                }
//            }
//        }
//        
//        return answer
        
        
        // The rect should compensate the header size
        var parallaxHeaderReferenceSize: CGFloat = 0
        var adjustedRect = rect;
        adjustedRect.origin.y -= parallaxHeaderReferenceSize
    
        var allItems: [UICollectionViewLayoutAttributes] = super.layoutAttributesForElementsInRect(adjustedRect) as! [UICollectionViewLayoutAttributes]
        
        var headers = NSMutableDictionary()
        var lastCells = NSMutableDictionary()
        var visibleParallexHeader = false
        
        for (index, item) in enumerate(allItems) {
            var attributes = item as UICollectionViewLayoutAttributes
            var frame = attributes.frame
            frame.origin.y += parallaxHeaderReferenceSize
            attributes.frame = frame
            
            var indexPath = attributes.indexPath
            if let representedElementKind = attributes.representedElementKind {
                if representedElementKind == UICollectionElementKindSectionHeader {
                    headers.setObject(attributes, forKey: indexPath.section)
                } else if representedElementKind == UICollectionElementKindSectionFooter {
                    
                } else {
                    var currentAttribute = lastCells.objectForKey(indexPath.section) as? UICollectionViewLayoutAttributes
                    if (currentAttribute == nil) || (indexPath.row > currentAttribute?.indexPath.row) {
                        lastCells.setObject(attributes, forKey: indexPath.section)
                    }
                    if indexPath.item == 0 && indexPath.section == 0 {
                        visibleParallexHeader = true
                    }
                }
            }
            attributes.zIndex = 1
        }
        
        if (CGRectGetMinY(rect) <= 0) {
            visibleParallexHeader = true
        }
        
        /*
        if visibleParallexHeader && !CGSizeEqualToSize(CGSizeZero, CGSizeMake(0, parallaxHeaderReferenceSize)) {
            var currentAttribute =
        }

        if (visibleParallexHeader && ! CGSizeEqualToSize(CGSizeZero, self.parallaxHeaderReferenceSize)) {
            CSStickyHeaderFlowLayoutAttributes *currentAttribute = [CSStickyHeaderFlowLayoutAttributes layoutAttributesForSupplementaryViewOfKind:CSStickyHeaderParallaxHeader withIndexPath:[NSIndexPath indexPathWithIndex:0]];
            CGRect frame = currentAttribute.frame;
            frame.size.width = self.parallaxHeaderReferenceSize.width;
            frame.size.height = self.parallaxHeaderReferenceSize.height;
            
            CGRect bounds = self.collectionView.bounds;
            CGFloat maxY = CGRectGetMaxY(frame);
            
            // make sure the frame won't be negative values
            CGFloat y = MIN(maxY - self.parallaxHeaderMinimumReferenceSize.height, bounds.origin.y + self.collectionView.contentInset.top);
            CGFloat height = MAX(0, -y + maxY);
            
            
            CGFloat maxHeight = self.parallaxHeaderReferenceSize.height;
            CGFloat minHeight = self.parallaxHeaderMinimumReferenceSize.height;
            CGFloat progressiveness = (height - minHeight)/(maxHeight - minHeight);
            currentAttribute.progressiveness = progressiveness;
            
            // if zIndex < 0 would prevents tap from recognized right under navigation bar
            currentAttribute.zIndex = 0;
            
            // When parallaxHeaderAlwaysOnTop is enabled, we will check when we should update the y position
            if (self.parallaxHeaderAlwaysOnTop && height <= self.parallaxHeaderMinimumReferenceSize.height) {
                CGFloat insetTop = self.collectionView.contentInset.top;
                // Always stick to top but under the nav bar
                y = self.collectionView.contentOffset.y + insetTop;
                currentAttribute.zIndex = 2000;
            }
            
            currentAttribute.frame = (CGRect){
                frame.origin.x,
                y,
                frame.size.width,
                height,
            };
            
            
            [allItems addObject:currentAttribute];
        }
        */
        
        lastCells.enumerateKeysAndObjectsUsingBlock { (key, obj, stop) -> Void in
            var indexPath = obj.indexPath as NSIndexPath
            var indexPathKey = indexPath.section
            var head = headers[indexPathKey] as? UICollectionViewLayoutAttributes
            if let header = head {
                var newHeader = self.layoutAttributesForSupplementaryViewOfKind(UICollectionElementKindSectionHeader, atIndexPath: NSIndexPath(forItem: 0, inSection: indexPath.section))
                if let h = newHeader {
                    allItems.append(header)
                }
            }
            var attributes = lastCells[indexPathKey] as! UICollectionViewLayoutAttributes
            var currentBounds = self.collectionView!.bounds
            attributes.zIndex = 1024
            attributes.hidden = false
            
            var origin = attributes.frame.origin
            
            var sectionMaxY = CGRectGetMaxY(attributes.frame) - attributes.frame.size.height;
            var y = CGRectGetMaxY(currentBounds) - currentBounds.size.height + self.collectionView!.contentInset.top
            
            var maxY = min(max(y, attributes.frame.origin.y), sectionMaxY)
            
            
            origin.y = maxY
            
            attributes.frame = CGRectMake(origin.x, origin.y, attributes.frame.size.width, attributes.frame.size.height)
        

        }
        
        return allItems
    }
    
    override func shouldInvalidateLayoutForBoundsChange(newBounds: CGRect) -> Bool {
        return true
    }
    
    override func prepareLayout() {
        super.prepareLayout()
    }
}
