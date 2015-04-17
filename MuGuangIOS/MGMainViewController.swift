//
//  MGMainViewController.swift
//  MuGuangIOS
//
//  Created by ZH on 15/4/15.
//  Copyright (c) 2015年 北京目光璀璨科技有限公司. All rights reserved.
//

import UIKit

let kScaleLabelHeight: CGFloat = 30
/**
 *  主页面
 */
class MGMainViewController: MGBaseViewController, AwesomeMenuDelegate {
    
    // 模糊背景
    let pictureView: UIImageView = UIImageView(frame: CGRectZero)
    let blurView: FXBlurView = FXBlurView(frame: CGRectZero)
    // 相机视图
    let cameraView: MGCameraView = MGCameraView(frame: CGRectZero)
    // 比例尺的标签
    let scaleLabel: UILabel = {
        var label = UILabel(frame: CGRectZero)
        label.layer.masksToBounds = true
        label.layer.cornerRadius = kScaleLabelHeight / 2
        label.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        label.textColor = UIColor.whiteColor()
        label.font = UIFont.systemFontOfSize(13.0)
        label.textAlignment = .Center
        return label
    }()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        pictureView.hidden = true
        blurView.hidden = true
        blurView.userInteractionEnabled = false
        cameraView.addTapAction { (isRunning) -> Void in
            if isRunning {
                // 拍照
                self.cameraView.takePhoto({ (aImage) -> Void in
                    // MARK:模糊效果待优化
                    self.pictureView.image = aImage
                    self.pictureView.hidden = false
                    self.blurView.hidden = false
//                    UIView.animateWithDuration(2, animations: { () -> Void in
//                        self.blurView.blurRadius = 40
//                    })
                    
                    UIView.animateWithDuration(2, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                        self.blurView.blurRadius = 40
                    }, completion: { (finsih) -> Void in
                        
                    })
                    
//                    if let image = aImage {
//                        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
//                            var context = CIContext(options: nil)
//                            var inputImage = CIImage(image: image)
//                            var filter = CIFilter(name: "CIGaussianBlur", withInputParameters: [kCIInputImageKey:inputImage, "inputRadius" : 10])
//                            var outputImage = filter.outputImage
//                            var outImage = context.createCGImage(outputImage, fromRect: outputImage.extent())
//                            
//                            dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                                self.blurView.image = UIImage(CGImage: outImage)
//                                self.blurView.hidden = false
//                            })
//                        })
//                    }
                })
                self.cameraView.stopRunning()
            } else {
                self.cameraView.startRunning()
                self.pictureView.hidden = true
                self.blurView.hidden = true
                self.blurView.blurRadius = 0
            }
        }
        
        self.view.addSubview(self.cameraView)
        self.view.addSubview(self.pictureView)
        self.view.addSubview(self.blurView)
        self.makeAwesomeMenu()
        self.makeVerticalSlider()
        self.view.addSubview(self.scaleLabel)
        /**
         *  添加布局
         */
        self.cameraView.mas_makeConstraints { make in
            make.edges.equalTo()(self.view)
        }
        
        self.pictureView.mas_makeConstraints { make in
            make.edges.equalTo()(self.view)
        }
        
        self.blurView.mas_makeConstraints { make in
            make.edges.equalTo()(self.view)
        }
        
        var button = UIButton(frame: CGRectZero)
        button.setTitle("发布", forState: .Normal)
        button.setTitleColor(UIColor.blueColor(), forState: .Normal)
        button.addTarget(self, action: Selector("methodForButton:"), forControlEvents: .TouchUpInside)
        self.view.addSubview(button)
        
        button.mas_makeConstraints { make in
            make.width.equalTo()(50)
            make.height.equalTo()(40)
            make.centerX.equalTo()(self.view)
            make.bottom.equalTo()(self.view).with().offset()(-50)
        }
    }
    
    // 按钮的回调
    func methodForButton(btn: UIButton) {
        var storyBoard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
        var viewController = storyBoard.instantiateViewControllerWithIdentifier("MGPublishViewController") as? UIViewController
        if let vc = viewController {
            self.presentViewController(vc, animated: true, completion: nil)
        }
    }
    
    // view转image
//    func getImageFromView(view: UIView!) -> UIImage {
//        UIGraphicsBeginImageContextWithOptions(view.bounds.size, true, view.layer.contentsScale)
//        view.layer.renderInContext(UIGraphicsGetCurrentContext())
//        let image = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return image
//    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        /**
         *  开始运行相机（页面出现时）
         */
        self.cameraView.startRunning()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        /**
         *  停止运行相机（页面消失后）
         */
        self.cameraView.stopRunning()
    }
    
    // 初始化扇形菜单
    func makeAwesomeMenu() {
        
        var itemImage = UIImage(named: "bg-addbutton")
//        var itemImagePressed = UIImage(named: "")
//        var starImage = UIImage(named: "")
        
        var item1 = AwesomeMenuItem(image: itemImage, highlightedImage: nil)
        var item2 = AwesomeMenuItem(image: itemImage, highlightedImage: nil)
        var item3 = AwesomeMenuItem(image: itemImage, highlightedImage: nil)
        
        var startItem = AwesomeMenuItem(image: itemImage, highlightedImage: nil)
        
        var menu: AwesomeMenu = AwesomeMenu(frame: CGRectZero, startItem: startItem, menuItems: [item1, item2, item3])
        menu.delegate = self
        menu.startPoint     = CGPointMake(50, self.view.frame.size.height - 50);
        menu.rotateAngle    = 0.0
        menu.menuWholeAngle = CGFloat(M_PI_2)
        menu.timeOffset     = 0.036
        menu.farRadius      = 90.0
        menu.endRadius      = 70.0
        menu.nearRadius     = 60.0
        self.view.addSubview(menu)
        
        // 添加约束
        menu.mas_makeConstraints { make in
            make.edges.equalTo()(self.view)
        }
    }
    
    // 滑杆
    func makeVerticalSlider() {
        var slider = MGVerticalSlider(frame: CGRectMake(0, 0, 300, 30))
        slider.center = CGPointMake(CGRectGetWidth(self.view.frame) - 50, CGRectGetHeight(self.view.frame) / 2)
        slider.setThumbImage(UIImage(named: "bg-addbutton"), forState: .Normal)
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.addTarget(self, action: Selector("methodForSlider:"), forControlEvents: .ValueChanged)
        self.view.addSubview(slider)
    }
    
    // 滑杆的回调
    func methodForSlider(slider: MGVerticalSlider) {
        self.scaleLabel.text = "查看半径：\(Int(slider.value)) km"
        var size = self.scaleLabel.text?.sizeWithAttributes([NSFontAttributeName : self.scaleLabel.font])
        self.scaleLabel.frame = CGRectMake((CGRectGetWidth(self.view.frame) - size!.width - 10) / 2, 30, size!.width + 10, kScaleLabelHeight)
    }
    
    // MARK: AwesomeMenuDelegate
    func awesomeMenu(menu: AwesomeMenu!, didSelectIndex idx: Int) {
        println(idx)
    }
    
}
