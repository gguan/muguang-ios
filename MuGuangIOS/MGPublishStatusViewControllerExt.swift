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
        }else if indexPath.row == 1 {
            let identifier = "MGPublishTextTableViewCell"
            var cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! MGPublishTextTableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.textView.backgroundColor = UIColor.MGGrayColor()
            cell.grayBack.backgroundColor = UIColor.MGGrayColor()
            cell.scrollForKeyboard = { () -> Void in
                
                self.tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Top, animated: true)
            }
            return cell
        }else {
            let identifier = "blankCell"
            var cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! UITableViewCell
            
            return cell
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return 1
//    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            let screenHeight    = UIScreen.mainScreen().bounds.size.width - 6
            let space:Int       = 6
            let realHeight      = (CGFloat(screenHeight) - 2 * CGFloat(space))/3.0
            return realHeight * CGFloat(self.images.count+3-1)/3.0
        }else if indexPath.row == 1{
            return 203.0
        }else {
            return 223.0
        }
    }
}