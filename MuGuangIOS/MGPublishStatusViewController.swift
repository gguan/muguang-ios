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

    var images: NSArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = false
        
        images = ["","","",""]
        //self.contentView.backgroundColor = UIColor.clearColor()

        
//        self.contentView.frame = CGRectMake(0, 0, self.view.frame.width, 1500)

//        
//        self.scrollView.contentSize = self.contentView.frame.size
//        
//        
//      
//        var left: NSLayoutConstraint = NSLayoutConstraint(item: self.contentView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Left, multiplier: 1.0, constant: 0.0)
//        self.view.addConstraint(left)
//        
//        var rightConstraint: NSLayoutConstraint = NSLayoutConstraint(item: self.contentView, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: self.view, attribute: NSLayoutAttribute.Right, multiplier: 1.0, constant: 0.0)
//        self.view.addConstraint(rightConstraint)
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
