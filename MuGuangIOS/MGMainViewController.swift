//
//  MGMainViewController.swift
//  MuGuangIOS
//
//  Created by ZH on 15/4/15.
//  Copyright (c) 2015年 北京目光璀璨科技有限公司. All rights reserved.
//

import UIKit
import CoreLocation
import CoreMotion

let kScaleLabelHeight: CGFloat = 20

/**
 *  主页面
 */
class MGMainViewController: MGBaseViewController, AwesomeMenuDelegate, MGLocationManagerDelegate, MGCardDelegate, TGCameraDelegate {
    
    // 模糊背景
    let blurView: FXBlurView = FXBlurView(frame: CGRectZero)
    // 相机视图
    var cameraView: MGCameraView = MGCameraView(frame: CGRectZero)
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
    // 加速计
    let motionManager: CMMotionManager = CMMotionManager()

    #if DEBUG
        // 加速计、经纬度数据展示图
        let monitorView: MGMonitorView = MGMonitorView(frame: CGRectZero)
    #endif
    
    // 数据源
    var dataSource: [CLLocation] = Array()
    
    // 卡片数组
    var cardArray: [MGCard] = Array()
    

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        /**
        * 测试
        */
        //FIXME: need delete
        //let btn = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
        //self.methodForButton(btn)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        // 未登录的话 push到登录界面
        
        if  NSUserDefaults.standardUserDefaults().valueForKey(kAccessToken) == nil {
            var mainStoryboard = UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
            var launchingVC = mainStoryboard.instantiateViewControllerWithIdentifier("MGLaunchingViewController") as! MGLaunchingViewController
            launchingVC.testBlcok = {() -> Void in
                //println("i am block")
            }
            
            self.navigationController?.pushViewController(launchingVC, animated: false)
        }
        
        self.view.backgroundColor = UIColor.whiteColor()
        self.navigationController?.navigationBarHidden = true
        
        blurView.hidden = true
        blurView.userInteractionEnabled = false
        blurView.tintColor = UIColor.clearColor()
        // 关闭BlurView的动态模糊效果，否则会大量占用CPU时间
        blurView.dynamic = false
        
        cameraView.addTapAction { (isRunning) -> Void in
            if isRunning {
                // 停止定位、加速计
                MGLocationManager.shared.stopUpdating()
                // 拍照
                self.cameraView.takePhoto({ (aImage) -> Void in
                    // 模糊效果
                    self.blurView.hidden = false
                    self.blurView.alpha = 0
                    self.blurView.blurRadius = 10
                    self.blurView.updateAsynchronously(true, completion: { () -> Void in
                        UIView.animateWithDuration(0.35, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: { () -> Void in
                            self.blurView.alpha = 1
                            }, completion: nil)
                    })
                })
            } else {
                // 开始定位、加速计
                MGLocationManager.shared.startUpdating()
                self.cameraView.startRunning()
                self.blurView.hidden = true
                self.blurView.blurRadius = 0
            }
        }
        
        self.view.addSubview(self.cameraView)
        self.view.addSubview(self.blurView)
        self.makeVerticalSlider()
        self.view.addSubview(self.scaleLabel)
        
        /**
         *  添加布局
         */
        self.cameraView.mas_makeConstraints { make in
            make.edges.equalTo()(self.view)
        }

        self.blurView.mas_makeConstraints { make in
            make.edges.equalTo()(self.view)
        }
        
        // 发布按钮
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
        
        // 开启定位
        self.setupLocationService()
        // 开启加速计
        self.setupMotionManager()
        
        #if DEBUG
            self.view.addSubview(self.monitorView)
            self.monitorView.mas_makeConstraints { make in
                make.top.equalTo()(self.view).offset()(50)
                make.width.equalTo()(self.view)
                make.height.equalTo()(160)
            }
        #endif
        
        self.dataSource = [
            CLLocation(latitude: 39.91160739, longitude: 116.48525809),
            CLLocation(latitude: 39.90160739, longitude: 116.47525809),
            CLLocation(latitude: 39.92160739, longitude: 116.49525809)
        ]
        self.reloadCard()
        self.makeAwesomeMenu()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("refreshCardFrame:"), name: kLocationNotificationDidUpdateHeading, object: nil)
    }
    
    // 刷新卡片
    func reloadCard() {
        self.cardArray.removeAll(keepCapacity: false)
        if self.dataSource.isEmpty {
            return
        }
        for (index, item) in enumerate(self.dataSource) {
            var card: MGCard = MGCard(frame: CGRectMake(0, 0, 213, 88))
            card.delegate = self
            card.center = self.view.center
            var y1 = self.view.center.y
            var y2 = CGFloat(CGFloat(arc4random() % 50) - 25.0)
            card.center.y = y1 + y2
            card.index = index
            self.cardArray.append(card)
        }
    }
    
    // 刷新卡片位置
    func refreshCardFrame(notifaction: NSNotification) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), { () -> Void in
            for item in self.cardArray {
                if let index = item.index {
                    var location: CLLocation = self.dataSource[index]
                    if self.judgeDegreeInField(MGLocationManager.shared.currentLocation, location2: location) {
                        var degree: Double = MGCLLocationHelper.calculatorDegree(MGLocationManager.shared.currentLocation!, location2: location)
                        var offsetUnit = CGRectGetWidth(self.view.frame) / 90
                        // 计算比例 然后add倒self.view
                        var offsetDegree: Double = 0
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            if MGLocationManager.shared.trueHeading > degree {
                                offsetDegree = MGLocationManager.shared.trueHeading! - degree
                                item.center.x = self.view.center.x - offsetUnit * CGFloat(offsetDegree)
                            } else {
                                offsetDegree = degree - MGLocationManager.shared.trueHeading!
                                item.center.x = self.view.center.x + offsetUnit * CGFloat(offsetDegree)
                            }
                            if item.superview == nil {
                                self.view.addSubview(item)
                            }
                        })
                    } else {
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                            item.removeFromSuperview()
                        })
                    }
                }
            }

        })
    }
    
    // 判断卡片是否在视野中
    func judgeDegreeInField(location1: CLLocation?, location2: CLLocation?) -> Bool {
        if location1 == nil || location2 == nil || MGLocationManager.shared.trueHeading == nil {
            return false
        }
        // 目标方位
        var targerDegree = MGCLLocationHelper.calculatorDegree(location1!, location2: location2!)
        return MGCLLocationHelper.judgeDegreeInField(MGLocationManager.shared.trueHeading!, targetDegree: targerDegree)

    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        /**
         *  开始运行相机（页面出现时）
         */
        self.cameraView.startRunning()
        MGLocationManager.shared.startUpdating()
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        /**
         *  停止运行相机（页面消失后）,停止加速计，停止定位
         */
        self.cameraView.stopRunning()
        MGLocationManager.shared.stopUpdating()
    }
    
    
    // 拍照按钮的回调
    func methodForButton(btn: UIButton) {
        var nav = TGCameraNavigationController.newWithCameraDelegate(self)
        self.presentViewController(nav, animated: true, completion: nil)
    }
    
    // 初始化扇形菜单
    func makeAwesomeMenu() {
        
        var itemImage = UIImage(named: "bg-addbutton")
        var itemImagePressed = UIImage(named: "bg-addbutton")
        var starImage = UIImage(named: "bg-addbutton")
        
        var item1 = AwesomeMenuItem(image: itemImage,
            highlightedImage: itemImagePressed,
            contentImage: starImage,
            highlightedContentImage: nil)
        var item2 = AwesomeMenuItem(image: itemImage,
            highlightedImage: itemImagePressed,
            contentImage: starImage,
            highlightedContentImage: nil)
        var item3 = AwesomeMenuItem(image: itemImage,
            highlightedImage: itemImagePressed,
            contentImage: starImage,
            highlightedContentImage: nil)
        
        var startItem = AwesomeMenuItem(image: itemImage,
            highlightedImage: itemImagePressed,
            contentImage: starImage,
            highlightedContentImage: nil)
        
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
    
//    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
//        self.cameraView.bounds.size = size
//    }
    
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
        switch idx {
        case 0:
            break
        case 1:
            break
        case 2:
            var second: UIStoryboard = UIStoryboard(name: "Second", bundle: NSBundle.mainBundle())
            var userVC: MGUserViewController = second.instantiateViewControllerWithIdentifier("MGUserViewController") as! MGUserViewController
            userVC.isMyInfo = true
            self.navigationController?.pushViewController(userVC, animated: true)
        default :
            break
        }
    }
    
    // MARK: 加速计
    func setupMotionManager() {
        if !self.motionManager.accelerometerAvailable {
            println("没有加速计")
            return
        }
        // 更新频率是10Hz
        self.motionManager.accelerometerUpdateInterval = 1
        self.motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.mainQueue()) { (latestAcc, error) -> Void in
//            println(latestAcc)
            var accData = latestAcc as CMAccelerometerData
            #if DEBUG
                self.monitorView.updateMotionLabel(accData.acceleration)
            #endif
        }
    }
    
    // MARK: 定位服务
    func setupLocationService() {
        switch CLLocationManager.authorizationStatus() {
        case .AuthorizedWhenInUse, .AuthorizedAlways:
            // 开始定位
            MGLocationManager.shared.startUpdating()
        case .NotDetermined:
            // 请求授权
            MGLocationManager.shared.requestWhenInUseAuthorization()
        case .Restricted, .Denied:
            // 请求授权
            let alertController = UIAlertController(
                title: "Background Location Access Disabled",
                message: "In order to be notified about adorable kittens near you, please open this app's settings and set location access to 'Always'.",
                preferredStyle: .Alert)
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
            alertController.addAction(cancelAction)
            
            let openAction = UIAlertAction(title: "Open Settings", style: .Default) { (action) in
                if let url = NSURL(string:UIApplicationOpenSettingsURLString) {
                    UIApplication.sharedApplication().openURL(url)
                }
            }
            alertController.addAction(openAction)
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    // MARK: MGCardDelegate
    // 跳转到个人信息
    func showUserInfo(index: Int) {
        var second: UIStoryboard = UIStoryboard(name: "Second", bundle: NSBundle.mainBundle())
        var userVC: MGUserViewController = second.instantiateViewControllerWithIdentifier("MGUserViewController") as! MGUserViewController
        userVC.isMyInfo = false
        self.navigationController?.pushViewController(userVC, animated: true)
    }
    
    // 跳转到卡片详情
    func showCardDetail(index: Int) {
        self.navigationController?.pushViewController(MGCardDetailController(), animated: true)
    }
    
    // MARK: TGCamera Delegate Methods
    func cameraDidCancel() {
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    func cameraDidTakePhoto(image: UIImage!) {
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    func cameraDidSelectAlbumPhoto(image: UIImage!) {
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
}

