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
        return filterDescriptors.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! PhotoFilterCollectionViewCell
        cell.filteredImageView.contentMode = .ScaleAspectFill
        cell.filteredImageView.inputImage = filteredImageView.inputImage
        
        if !filters.isEmpty {
            cell.filteredImageView.filter = filters[indexPath.item]
            cell.filterNameLabel.text = filterDescriptors[indexPath.item].filterDisplayName
        }
        return cell
    }
}

extension MGPublishViewController : UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if !filters.isEmpty {
            filteredImageView.filter = filters[indexPath.item]
            filteredImageView.backgroundColor = UIColor.yellowColor()
        }
    }
}