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
            let identifier      = "MGPublishPhotoCellIdentifier"
            var cell            = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! MGPublishPhotoTableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.alertClosure   = {()->() in
                let alertController = UIAlertController(title: "删除", message: "确信删除吗？", preferredStyle: UIAlertControllerStyle.ActionSheet)
                let action = UIAlertAction(title: "删除", style: UIAlertActionStyle.Default, handler: { (action:UIAlertAction!) -> Void in
                    
                })
                alertController.addAction(action)
                self.presentViewController(alertController, animated: true, completion: nil)
            }
            return cell
        }else if indexPath.row == 1 {
            let identifier = "MGPublishTextTableViewCell"
            var cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! MGPublishTextTableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.textView.backgroundColor = UIColor.MGGrayColor()
            cell.grayBack.backgroundColor = UIColor.MGGrayColor()
            cell.scrollToShowKeyboard = { () -> Void in
                
                self.tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: UITableViewScrollPosition.Top, animated: true)
            }
            cell.scrollToHideKeyboard = { () -> Void in
                
                self.tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
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