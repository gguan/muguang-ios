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
        return self.images.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(
            "MGPhotoCollectionCell", forIndexPath: indexPath) as! MGPhotoCollectionCell
        //cell.image.image = UIImage(named: "close.png")
        cell.contentView.backgroundColor = UIColor.whiteColor()
        cell.backgroundColor = UIColor.greenColor()
        return cell
    }
    
//    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
//        
//    }
//    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(10, 10, 10, 10)
    }
   
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let screenWidth = UIScreen.mainScreen().bounds.size.width
        let space:Int = 15
        let realWidth = (CGFloat(screenWidth) - 4 * CGFloat(space))/3.0
        return CGSize(width: realWidth, height: screenWidth/3.5)
    }
    
    //两行之间
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 5.0
    }
    //两个cell之间
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 1.0
    }
    
    
}
