//
//  MGPublishTextTableViewCell.swift
//  MuGuangIOS
//
//  Created by William Hu on 4/29/15.
//  Copyright (c) 2015 北京目光璀璨科技有限公司. All rights reserved.
//

import UIKit

class MGPublishTextTableViewCell: UITableViewCell, UITextViewDelegate {

    @IBOutlet weak var grayBack: UIView!
    @IBOutlet weak var textView: UITextView!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.textView.delegate           = self
        self.grayBack.layer.cornerRadius = 8.0
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
    }
    
    
    //Might be usefull later
    
    func registerForKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "keyboardWasShown:",
            name: UIKeyboardDidShowNotification,
            object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(
            self,
            selector: "keyboardWillBeHidden:",
            name: UIKeyboardWillHideNotification,
            object: nil)
    }
    
    func keyboardWasShown(notification: NSNotification) {
        println("Keyboard was shown");
        
    }
    
    func keyboardWillBeHidden(notification: NSNotification) {
        println("Keyboard was dismissed");
    }
    
    func removeKeyboardObserver () {
        NSNotificationCenter.defaultCenter().removeObserver(self,
            name: UIKeyboardDidShowNotification,
            object: nil)
        
        NSNotificationCenter.defaultCenter().removeObserver(self,
            name: UIKeyboardWillHideNotification,
            object: nil)
    }
}
