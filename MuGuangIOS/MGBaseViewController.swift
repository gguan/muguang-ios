//
//  MGBaseViewController.swift
//  MuGuangIOS
//
//  Created by ZH on 15/4/15.
//  Copyright (c) 2015年 北京目光璀璨科技有限公司. All rights reserved.
//

import UIKit

/**
 *  自定义UIViewController的基类
 */
class MGBaseViewController: UIViewController {
    
    // 页面跳转传递参数的数组
    var paramArray: Array<AnyObject>?
    
    /**
     *便利构造器
     */
    convenience init(params: Array<AnyObject>) {
        self.init()
        self.paramArray = params
    }

    deinit {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
