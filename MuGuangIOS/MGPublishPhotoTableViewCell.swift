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
    
    var images: NSMutableArray!
    
    //提醒是否删除图片等
    var alertClosure:((indexPath: NSIndexPath)->())?
    
    //添加图片
    var addImageToPublish:(()-> ())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.collectionView.backgroundColor = UIColor.clearColor()
        self.collectionView.scrollEnabled   = false
    }
    
    

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
