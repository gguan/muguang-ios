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
    
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureUI()
        
        images = ["","","","","","",""]
        
        self.imagePicker.delegate = self
        
        MGAPIManager.sharedInstance.qiniuUploadToken({ (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) -> Void in
            println(responseObject)
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
            println(error.localizedDescription)
                println(operation.responseData)
                println(operation.responseObject)
        })
        
    }

    
    func configureUI () {
        self.navigationController?.navigationBarHidden = false
        self.tableView.backgroundColor = UIColor.whiteColor()
        self.tableView.separatorStyle  = UITableViewCellSeparatorStyle.None
        self.title = "编辑"
        
        //右上角button
        let rightBtn = UIButton(frame: CGRectMake(0, 0, 100, 50))
        rightBtn.setTitle("发布", forState: UIControlState.Normal)
        rightBtn.addTarget(self, action: "publishStatus", forControlEvents: UIControlEvents.TouchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: rightBtn)
    }

    func publishStatus () {
        // API: need to be done
//        self.navigationController?.popToRootViewControllerAnimated(true)
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {

        super.viewDidLayoutSubviews()
        
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        MGAPIManager.sharedInstance.publishStatus(["":""], success: { (operation: AFHTTPRequestOperation!, responseObject: AnyObject!) -> Void in
            println(operation.response)
            println(responseObject)
            }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                //更新token： 403错误就是token 过期 :)， 404呢？
                
//                println(operation.response)
//                println(error.description)
//                println(operation.responseObject)
                
                if let error = operation.responseObject["error"] as? String {
                    if error == "401 Unauthorized" {
                        //出现登录页面
                        MGTool.sharedInstance.popAuthPage(self.navigationController)
                    }
                }
        })
        
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
