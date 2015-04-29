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
        let identifier = "MGPublishPhotoCellIdentifier"
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as! UITableViewCell
        return cell
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return 1
//    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 312.0
    }
}