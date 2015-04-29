//
//  MGSettingViewController.swift
//  MuGuangIOS
//
//  Created by ZhangHao on 15/4/27.
//  Copyright (c) 2015年 北京目光璀璨科技有限公司. All rights reserved.
//

import UIKit

class MGSettingViewController: MGBaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!

    @IBOutlet weak var logoutButton: UIButton!
    let dataSource: Array<Array<String>> = [["个人信息"], ["修改密码", "绑定账号", "邀请好友"], ["消息推送", "只允许我关注的人与我私聊", "关于目光", "清理缓存", "意见反馈", "用户协议"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        // 设置退出按钮的样式
        logoutButton.setTitle("退出登录", forState: .Normal)
        logoutButton.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        logoutButton.backgroundColor     = UIColor.transformColor(kTextColorRed, alpha: 1.0)
        logoutButton.layer.cornerRadius  = 6
        logoutButton.layer.masksToBounds = true
        
        // 设置FooterView的高度
        self.tableView.tableFooterView?.frame.size.height = 60
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
    
    // MARK: - UITableViewDataSource, UITableViewDelegate
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return dataSource.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource[section].count
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        var height: CGFloat = 0
        switch section {
        case 0:
            height = 5
        case 1:
            height = 8
        case 2:
            height = 8
        default:
            height = 0
        }
        return height
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        var view = UIView()
        view.backgroundColor = UIColor.clearColor()
        return view
    }
//    
//    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
//        return section == 2 ? 60 : 0
//    }
    
//    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//        if section != 2 {
//            return nil
//        }
//        var footerView = tableView.dequeueReusableCellWithIdentifier("MGSettingFooterView") as? UITableViewCell
//        var button = footerView?.viewWithTag(111) as? UIButton
//        button?.backgroundColor     = UIColor.transformColor(kTextColorRed, alpha: 1.0)
//        button?.layer.cornerRadius  = 6
//        button?.layer.masksToBounds = true
//        return footerView
//    }
//    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        var height: CGFloat = 40
        if indexPath.row == 0 && indexPath.section == 0 {
            height = 65
        }
        return height
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                var cell = tableView.dequeueReusableCellWithIdentifier("MGUserInfoCell", forIndexPath: indexPath) as! MGUserInfoCell
                cell.avatarView.setAvatarImage(UIImage(named: "avatar_placeholder"))
                cell.avatarView.borderWidth = 2
                cell.nameLabel.text         = "目光"
                cell.briefLabel.text        = "彪悍的人生，无需解释！"
                cell.setSexIcon("2")
                return cell
            }
        } else if indexPath.section == 1 {
            var cell = tableView.dequeueReusableCellWithIdentifier("MGSettingCell", forIndexPath: indexPath) as! MGSettingCell
            cell.nameLabel.text = dataSource[indexPath.section][indexPath.row]
            return cell
        } else if indexPath.section == 2 {
            var cell = tableView.dequeueReusableCellWithIdentifier("MGSettingCell", forIndexPath: indexPath) as! MGSettingCell
            cell.nameLabel.text = dataSource[indexPath.section][indexPath.row]
            for v in cell.backView.subviews {
                if v.isKindOfClass(UISwitch.self) {
                    v.removeFromSuperview()
                }
            }
            if indexPath.row == 1 {
                cell.redArrow.hidden = true
                var switchView: UISwitch = UISwitch(frame: CGRectZero)
                switchView.onTintColor = UIColor.transformColor(kTextColorRed, alpha: 1.0)
                cell.backView.addSubview(switchView)
                switchView.mas_makeConstraints({ make in
                    make.width.equalTo()(50)
                    make.height.equalTo()(30)
                    make.right.equalTo()(cell.backView).offset()(-15)
                    make.centerY.equalTo()(cell.backView)
                })
            } else {
                cell.redArrow.hidden = false
            }
            return cell
        }

        return UITableViewCell()
    }
    
    // 退出登录
    @IBAction func methodForLogout(sender: AnyObject) {
        println("logout")
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
