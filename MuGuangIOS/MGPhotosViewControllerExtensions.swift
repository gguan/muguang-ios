//
//  MGPhotosViewController.swift
//  MuGuangIOS
//
//  Created by William Hu on 4/16/15.
//  Copyright (c) 2015 北京目光璀璨科技有限公司. All rights reserved.
//


extension MGPublishViewController : UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! UICollectionViewCell
        cell.backgroundColor = UIColor.redColor()
        return cell
    }
}