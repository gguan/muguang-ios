//
//  MGPublishTextTableViewCell.swift
//  MuGuangIOS
//
//  Created by William Hu on 4/29/15.
//  Copyright (c) 2015 北京目光璀璨科技有限公司. All rights reserved.
//

import UIKit

class MGPublishTextTableViewCell: UITableViewCell {

    @IBOutlet weak var grayBack: UIView!
    @IBOutlet weak var textView: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.grayBack.layer.cornerRadius = 8.0

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
