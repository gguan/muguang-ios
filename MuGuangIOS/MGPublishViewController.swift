//
//  MGPublishViewController.swift
//  MuGuangIOS
//
//  Created by William Hu on 4/16/15.
//  Copyright (c) 2015 北京目光璀璨科技有限公司. All rights reserved.
//

import UIKit

import AVFoundation

import QuartzCore

import ImageIO

class MGPublishViewController: UIViewController {

    let captureSession = AVCaptureSession()
    
    var captureDevice : AVCaptureDevice?
    
    var previewLayer : AVCaptureVideoPreviewLayer?
    
    @IBOutlet weak var preview: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
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
