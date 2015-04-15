//
//  ViewController.swift
//  MuGuangIOS
//
//  Created by William Hu on 15/4/15.
//  Copyright (c) 2015 William Hu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        var button: UIButton! = UIButton(frame: CGRectZero)
        button.setTitle("Test", forState: .Normal)
        self.view.addSubview(button)

        
//        button.mas_makeConstraints { (make: MASConstraintMaker!) -> Void in
//            make.center().equalTo(self.view)
//        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

