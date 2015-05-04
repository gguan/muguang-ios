//
//  MGPhotoCellExt.swift
//  MuGuangIOS
//
//  Created by William Hu on 4/29/15.
//  Copyright (c) 2015 北京目光璀璨科技有限公司. All rights reserved.
//

import Foundation

extension MGPublishPhotoTableViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count + 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(
            "MGPhotoCollectionCell", forIndexPath: indexPath) as! MGPhotoCollectionCell
        
        if indexPath.row == self.images.count {
            cell.image.image                 = UIImage(named: "add.png")
            cell.deleteButton.hidden         = true
            cell.image.transform             = CGAffineTransformMakeScale(0.5, 0.5)

        }else {
            //cell.image.image               = UIImage(named: "close.png")
            cell.contentView.backgroundColor = UIColor.clearColor()
            cell.deleteButton.hidden         = false
            
            cell.deleteImageAlertClosure     = { ()-> () in
                self.alertClosure!(indexPath: indexPath)
            }
            
        }
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == self.images.count {
            //添加图片
            self.addImageToPublish!()
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(10, 6, 10, 6)
    }
   
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let screenWidth = UIScreen.mainScreen().bounds.size.width - 6
        let space:Int = 6
        let realWidth = (CGFloat(screenWidth) - 2 * CGFloat(space))/3.0
        return CGSize(width: realWidth, height: realWidth)
    }
    
    //两行之间
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 1.0
    }
    //两个cell之间
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 1.0
    }
    
    
}
