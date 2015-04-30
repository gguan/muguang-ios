//
//  MGPublishStatusViewController.swift
//  MuGuangIOS
//
//  Created by William Hu on 4/27/15.
//  Copyright (c) 2015 北京目光璀璨科技有限公司. All rights reserved.
//

import UIKit

class MGPublishStatusViewController: UIViewController {
   
    @IBOutlet weak var tableView: UITableView!

    var images: NSMutableArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = false
        self.tableView.backgroundColor = UIColor.whiteColor()
        self.tableView.separatorStyle  = UITableViewCellSeparatorStyle.None
        images = ["","","","","","",""]
        
    }


    override func viewDidLayoutSubviews() {

        super.viewDidLayoutSubviews()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
