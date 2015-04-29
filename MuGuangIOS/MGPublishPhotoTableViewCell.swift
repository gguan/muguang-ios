//
//  MGPublishPhotoTableViewCell.swift
//  MuGuangIOS
//
//  Created by William Hu on 4/29/15.
//  Copyright (c) 2015 北京目光璀璨科技有限公司. All rights reserved.
//

import UIKit

class MGPublishPhotoTableViewCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var images = ["","",""]

    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView.backgroundColor = UIColor.redColor()
        
        
        
        
        //self.collectionView.collectionViewLayout.invalidateLayout()
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        
//        let screenWidth = UIScreen.mainScreen().bounds.size.width
//        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
//        layout.itemSize = CGSize(width: screenWidth / 3, height: screenWidth / 3)
//        layout.minimumInteritemSpacing = 0
//        layout.minimumLineSpacing = 0
//        self.collectionView.collectionViewLayout = layout
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
