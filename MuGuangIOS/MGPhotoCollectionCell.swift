//
//  MGPhotoCollectionCell.swift
//  MuGuangIOS
//
//  Created by William Hu on 4/29/15.
//  Copyright (c) 2015 北京目光璀璨科技有限公司. All rights reserved.
//

import UIKit

class MGPhotoCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var image: UIImageView!

    @IBOutlet weak var deleteButton: UIButton!
    
    //删除图片
    var deleteImageAlertClosure: (()-> ())?
        
    @IBAction func deleteImage (sender: AnyObject) {
        deleteImageAlertClosure!()
    }
}
