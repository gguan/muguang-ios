//
//  MGPublishStatusViewController.swift
//  MuGuangIOS
//
//  Created by William Hu on 4/27/15.
//  Copyright (c) 2015 北京目光璀璨科技有限公司. All rights reserved.
//

import UIKit

class MGPublishStatusViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = false
        self.view.backgroundColor = UIColor.greenColor()
        self.scrollView.contentSize = CGSizeMake(320, 800)
        // Do any additional setup after loading the view.
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
