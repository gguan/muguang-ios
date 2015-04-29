//
//  MGPublishStatusViewControllerExt.swift
//  MuGuangIOS
//
//  Created by William Hu on 4/28/15.
//  Copyright (c) 2015 北京目光璀璨科技有限公司. All rights reserved.
//

import Foundation

extension MGPublishStatusViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let identifier = "MGPublishPhotoCellIdentifier"
            var cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! MGPublishPhotoTableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            return cell
        }else {
            let identifier = "MGPublishTextTableViewCell"
            var cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! MGPublishTextTableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.textView.backgroundColor = UIColor.MGGrayColor()
            cell.grayBack.backgroundColor = UIColor.MGGrayColor()
//            cell.contentView.backgroundColor = UIColor.whiteColor()
            return cell
        }
        
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return 1
//    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 120.0 * CGFloat(self.images.count+3-1)/3.0
        }else {
            return 203.0
        }
    }
}