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
    
    var scrollToShowKeyboard:(()-> Void)?
    var scrollToHideKeyboard:(()-> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.textView.delegate           = self
        self.textView.returnKeyType      = UIReturnKeyType.Done
        self.grayBack.layer.cornerRadius = 8.0
        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func textViewDidBeginEditing(textView: UITextView) {
        scrollToShowKeyboard!()
    }
    func textViewDidEndEditing(textView: UITextView) {
        
    }
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            scrollToHideKeyboard!()
            textView.resignFirstResponder()
        }
        return true
    }
    
    
    //MARK: Might be usefull later
    
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
