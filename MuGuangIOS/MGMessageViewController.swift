//
//  MGMessageViewController.swift
//  MuGuangIOS
//
//  Created by ZhangHao on 15/5/4.
//  Copyright (c) 2015年 北京目光璀璨科技有限公司. All rights reserved.
//

import UIKit

class MGMessageViewController: MGBaseViewController {

    @IBOutlet weak var separateLine: UIView!
    @IBOutlet weak var activityLine: UIView!
    // 私信按钮
    @IBOutlet weak var messageButton: UIButton!
    // 赞按钮
    @IBOutlet weak var praiseButton: UIButton!
    // 你按钮
    @IBOutlet weak var youButton: UIButton!
    
    var currentButton: UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.resetBackButton()
        // 设置分隔线的颜色
        self.separateLine.backgroundColor = UIColor.transformColor(kTextColorGray, alpha: 1.0)
        self.activityLine.backgroundColor = UIColor.transformColor(kTextColorRed, alpha: 1.0)
        // 设置按钮样式
        self.messageButton.setTitleColor(UIColor.transformColor(kTextColorGray, alpha: 1.0), forState: .Normal)
        self.praiseButton.setTitleColor(UIColor.transformColor(kTextColorGray, alpha: 1.0), forState: .Normal)
        self.youButton.setTitleColor(UIColor.transformColor(kTextColorGray, alpha: 1.0), forState: .Normal)
        self.messageButton.setTitleColor(UIColor.transformColor(kTextColorRed, alpha: 1.0), forState: .Selected)
        self.praiseButton.setTitleColor(UIColor.transformColor(kTextColorRed, alpha: 1.0), forState: .Selected)
        self.youButton.setTitleColor(UIColor.transformColor(kTextColorRed, alpha: 1.0), forState: .Selected)
        self.messageButton.titleLabel?.font = UIFont.systemFontOfSize(15)
        self.praiseButton.titleLabel?.font = UIFont.systemFontOfSize(15)
        self.youButton.titleLabel?.font = UIFont.systemFontOfSize(15)
        // 默认选中消息
        self.messageButton.selected = true
        self.currentButton = self.messageButton
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
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

    // MARK: Button Method
    func updateActivityLineFrame(sender: UIButton) {
        UIView.animateWithDuration(0.25, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.5, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            self.activityLine.center.x = sender.center.x
        }, completion: nil)
        currentButton?.selected = false
        sender.selected = true
        currentButton = sender
    }
    
    @IBAction func clickMessageButton(sender: UIButton) {
        self.updateActivityLineFrame(sender)
    }
    
    @IBAction func clickPraiseButton(sender: UIButton) {
        self.updateActivityLineFrame(sender)
    }
    
    @IBAction func clickYouButton(sender: UIButton) {
        self.updateActivityLineFrame(sender)
    }
    
}
