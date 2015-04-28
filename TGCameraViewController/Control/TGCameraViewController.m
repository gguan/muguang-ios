//
//  TGCameraViewController.m
//  TGCameraViewController
//
//  Created by Bruno Tortato Furtado on 13/09/14.
//  Copyright (c) 2014 Tudo Gostoso Internet. All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import "TGCameraViewController.h"
#import "TGPhotoViewController.h"
#import "TGCameraSlideView.h"
#import "TGCameraFilterView.h"
#import "UIImage+CameraFilters.h"
#import "TGCameraColor.h"
#import "MGFilterPhotoCollectionViewCell.h"
#import "CIFilter+mgFiliters.h"
#import "MGVideoCamera.h"
#import "CALayer+Additions.h"

@interface TGCameraViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate>

@property (strong, nonatomic) IBOutlet UIView *captureView;
@property (strong, nonatomic) IBOutlet UIImageView *topLeftView;
@property (strong, nonatomic) IBOutlet UIImageView *topRightView;
@property (strong, nonatomic) IBOutlet UIImageView *bottomLeftView;
@property (strong, nonatomic) IBOutlet UIImageView *bottomRightView;
@property (strong, nonatomic) IBOutlet UIView *separatorView;
@property (strong, nonatomic) IBOutlet UIView *actionsView;
@property (strong, nonatomic) IBOutlet UIButton *gridButton;
@property (strong, nonatomic) IBOutlet UIButton *toggleButton;
@property (strong, nonatomic) IBOutlet UIButton *shotButton;
@property (strong, nonatomic) IBOutlet UIButton *albumButton;
@property (strong, nonatomic) IBOutlet UIButton *flashButton;

@property (strong, nonatomic) IBOutlet TGCameraSlideView *slideUpView;
@property (strong, nonatomic) IBOutlet TGCameraSlideView *slideDownView;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewHeight;

//@property (nonatomic, strong) MGFilterPhotoCollectionViewCell *selectCell;
@property (nonatomic, strong) NSIndexPath *selectedIndexPath;

//处理图片
@property (strong, nonatomic) TGCamera *camera;

//处理视频output （实时滤镜）
@property (nonatomic, strong) MGVideoCamera *videoCamera;

@property (nonatomic) BOOL wasLoaded;
@property (nonatomic,strong) UIImage *origionalPhoto;
@property (strong, nonatomic) IBOutlet UIImageView *previewImage;
@property (strong, nonatomic) IBOutlet UIView *nextView;

- (IBAction)closeTapped;
- (IBAction)gridTapped;
- (IBAction)flashTapped;
- (IBAction)shotTapped;
- (IBAction)albumTapped;
- (IBAction)toggleTapped;
- (IBAction)handleTapGesture:(UITapGestureRecognizer *)recognizer;

- (void)deviceOrientationDidChangeNotification;
- (AVCaptureVideoOrientation)videoOrientationForDeviceOrientation:(UIDeviceOrientation)deviceOrientation;
- (void)viewWillDisappearWithCompletion:(void (^)(void))completion;


@property (strong, nonatomic) IBOutlet TGCameraFilterView *mgFilterView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) NSCache *cachePhoto;

@property (nonatomic,strong) UIView *detailFilterView;

@property (nonatomic, strong) NSArray *filterDescriptors;

@property (nonatomic) BOOL isStillImageCamera;

//当前的滤镜
@property (nonatomic, strong) NSDictionary *currentFilter;

@property (nonatomic) BOOL isFromAlbum;

@end



@implementation TGCameraViewController


- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _isFromAlbum = NO;
    
    UINib *cellNib = [UINib nibWithNibName:@"MGFilterPhotoCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"mgCell"];
    
    if (CGRectGetHeight([[UIScreen mainScreen] bounds]) <= 480) {
        _topViewHeight.constant = 0;
    }
    
    
    //初始化滤镜
    _filterDescriptors = @[
                           @{@"filter":[CIFilter filterWithName:@"CIGaussianBlur"],@"name":@"None"},
                           @{@"filter":[CIFilter curve1Filter],@"name":@"Delicious"},
                           @{@"filter":[CIFilter vignetteFilter],@"name":@"Yupi"},
                           @{@"filter":[CIFilter filterWithName:@"CIGaussianBlur"],@"name":@"GaussianBlur"},
                           @{@"filter":[CIFilter filterWithName:@"CIPhotoEffectMono"],@"name":@"Mono"},
                           @{@"filter":[CIFilter filterWithName:@"CIPhotoEffectInstant"],@"name":@"Instant"},
                           @{@"filter":[CIFilter filterWithName:@"CIPhotoEffectFade"],@"name":@"Fade"}];

    _currentFilter = _filterDescriptors[0];
    
    //初始化静态图片Output（默认的）
    _isStillImageCamera = YES;
    _camera = [TGCamera cameraWithFlashButton:_flashButton];
    
    /**********************初始化Video output滤镜*****************/
    _videoCamera = [MGVideoCamera cameraWithFlashButton:_flashButton];
    
    //添加滤镜视图
    [self.actionsView addSubview:_mgFilterView];
    
    //初始化cache 和 原始图片
    _origionalPhoto = [UIImage new];
    _cachePhoto = [NSCache new];
    
    
    _captureView.backgroundColor = [UIColor clearColor];
    _topLeftView.transform = CGAffineTransformMakeRotation(0);
    _topRightView.transform = CGAffineTransformMakeRotation(M_PI_2);
    _bottomLeftView.transform = CGAffineTransformMakeRotation(-M_PI_2);
    _bottomRightView.transform = CGAffineTransformMakeRotation(M_PI_2*2);
    
    
    
    
//    if ([_mgFilterView isDescendantOfView:self.view]) {
//
//    } else {
////        [_filterView addToView:self.view aboveView:_bottomView];
//        [self.actionsView addSubview:_mgFilterView];
//        _mgFilterView.backgroundColor = [UIColor redColor];
//        //[self.view sendSubviewToBack:_filterView];
////        [self.view sendSubviewToBack:_photoView];
//    }
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(deviceOrientationDidChangeNotification)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
    
    _separatorView.hidden = NO;
    
    _actionsView.hidden = YES;
    _nextView.hidden = YES;
    _topLeftView.hidden =
    _topRightView.hidden =
    _bottomLeftView.hidden =
    _bottomRightView.hidden = YES;
    
    _gridButton.enabled =
    _toggleButton.enabled =
    _shotButton.enabled =
    _albumButton.enabled =
    _flashButton.enabled = NO;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    
    if (!_isFromAlbum) {
        _previewImage.frame = _captureView.frame;
        [self.view addSubview:_previewImage];
        
        
        [self deviceOrientationDidChangeNotification];
        
        _separatorView.hidden = YES;
        
        [TGCameraSlideView hideSlideUpView:_slideUpView slideDownView:_slideDownView atView:_captureView completion:^{
            _topLeftView.hidden =
            _topRightView.hidden =
            _bottomLeftView.hidden =
            _bottomRightView.hidden = YES;
            
            _actionsView.hidden = NO;
            
            _gridButton.enabled =
            _toggleButton.enabled =
            _shotButton.enabled =
            _albumButton.enabled =
            _flashButton.enabled = YES;
        }];
        
        if (_wasLoaded == NO) {
            _wasLoaded = YES;
            
            [_camera insertSublayerWithCaptureView:_captureView atRootView:self.view];
            
            [_videoCamera insertSublayerWithCaptureView:self.captureView atRootView:self.view];
        }
        
    }
    
    
    
    //设置默认滤镜None
    [self setDefaultFilterToNone];
    
    [self next:nil];
}

//初始化
- (void) setDefaultFilterToNone
{
    [_camera startRunning];
    
    //默认第一项选中
    _selectedIndexPath = [NSIndexPath indexPathForItem:0 inSection:0];
    [self addBorderLayerToSelectCell:_selectedIndexPath];
    
    
    //未照相的时候先隐藏
    _previewImage.hidden = YES;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [_camera stopRunning];
    [_videoCamera stopRunning];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (BOOL)prefersStatusBarHidden
{
    return YES;
}

- (void)dealloc
{
    _captureView = nil;
    _topLeftView = nil;
    _topRightView = nil;
    _bottomLeftView = nil;
    _bottomRightView = nil;
    _separatorView = nil;
    _actionsView = nil;
    _gridButton = nil;
    _toggleButton = nil;
    _shotButton = nil;
    _albumButton = nil;
    _flashButton = nil;
    _slideUpView = nil;
    _slideDownView = nil;
    _camera = nil;
}

#pragma mark -
#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:^{
        UIImage *photo = [TGAlbum imageWithMediaInfo:info];
        _previewImage.hidden = NO;
        _previewImage.image = photo;
        _origionalPhoto = photo;
        _isFromAlbum = YES;
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -
#pragma mark - Actions

- (IBAction)closeTapped
{
    if ([_delegate respondsToSelector:@selector(cameraDidCancel)]) {
        [_delegate cameraDidCancel];
    }
}

- (IBAction)gridTapped
{
    [_camera disPlayGridView];
}

- (IBAction)flashTapped
{
    if (_isStillImageCamera) {
        [_camera changeFlashModeWithButton:_flashButton];
    }else
        [_videoCamera changeFlashModeWithButton:_flashButton];
    
}

- (IBAction)shotTapped
{
    //_shotButton.enabled =
    _albumButton.enabled = NO;
    
    UIDeviceOrientation deviceOrientation = [[UIDevice currentDevice] orientation];
    AVCaptureVideoOrientation videoOrientation = [self videoOrientationForDeviceOrientation:deviceOrientation];
    
//    [self viewWillDisappearWithCompletion:^{
//        [_camera takePhotoWithCaptureView:_captureView videoOrientation:videoOrientation cropSize:_captureView.frame.size
//        completion:^(UIImage *photo) {
//            TGPhotoViewController *viewController = [TGPhotoViewController newWithDelegate:_delegate photo:photo];
//            [self.navigationController pushViewController:viewController animated:YES];
//        }];
//    }];
    
    if (_isStillImageCamera)
    {
        // 静态照相
        [_camera takePhotoWithCaptureView:_captureView videoOrientation:videoOrientation cropSize:_captureView.frame.size
                               completion:^(UIImage *photo) {
                                   _origionalPhoto      = photo;
                                   _previewImage.image  = photo;
                                   _nextView.hidden     = NO;
                                   _previewImage.hidden = NO;
                                   [_camera stopRunning];
                               }];
    }else {
        //实时
        /*
            UIImage *im = [_videoCamera captureImage];
            if (im) {
                _previewImage.hidden = NO;
                _previewImage.image  = im;
                _nextView.hidden     = NO;
                _origionalPhoto      = im;
                [self.view addSubview:_previewImage];
                [self.view bringSubviewToFront:_previewImage];
                [_videoCamera stopRunning];
            }
         */
        
        //启动照片
        [self cameraStaring];
        
        [_camera takePhotoWithCaptureView:_captureView
                         videoOrientation:videoOrientation
                                 cropSize:_captureView.frame.size
                               completion:^(UIImage *photo) {

                                   _origionalPhoto      = photo;
                                   _nextView.hidden     = NO;
                                   _previewImage.hidden = NO;
                                   
                                   
                                   //在照好的照片添加对应的滤镜
                                   if ([_currentFilter[@"name"] isEqualToString:@"None"]) {
                                       _previewImage.image = photo;
                                   }else
                                   {
                                       _previewImage.image = [_origionalPhoto addFilter:_currentFilter[@"filter"]];
                                   }
                                   [_camera stopRunning];
                                   [self.view.layer bringSublayerToFront:_videoCamera.previewLayer];
                                   _isStillImageCamera = NO;
                                   
                                   
        }];
        
       
    }
}
- (void) saveDone
{
    NSLog(@"save done");
}
- (IBAction)albumTapped
{
    _shotButton.enabled =
    _albumButton.enabled = NO;
    
    [self viewWillDisappearWithCompletion:^{
        UIImagePickerController *pickerController = [TGAlbum imagePickerControllerWithDelegate:self];
        [self presentViewController:pickerController animated:YES completion:nil];
    }];
}

- (IBAction)toggleTapped
{
    if (_isStillImageCamera) {
        [_camera toogleWithFlashButton:_flashButton];
    }else
        [_videoCamera toogleWithFlashButton:_flashButton];
    
}

- (IBAction)handleTapGesture:(UITapGestureRecognizer *)recognizer
{
    CGPoint touchPoint = [recognizer locationInView:self.view];
    
    if (!CGRectContainsPoint(self.captureView.frame, touchPoint)) {
        return;
    }
    
    if (_isStillImageCamera) {
        //CGPoint touchPoint = [recognizer locationInView:_captureView];
        [_camera focusView:self.view inTouchPoint:touchPoint];
    }else
    {
        //CGPoint touchPoint = [recognizer locationInView:self.view];
        [_videoCamera focusView:self.view inTouchPoint:touchPoint];
    }
}

#pragma mark -
#pragma mark - Private methods

- (void)deviceOrientationDidChangeNotification
{
    UIDeviceOrientation orientation = [UIDevice.currentDevice orientation];
    NSInteger degress;
    
    switch (orientation) {
        case UIDeviceOrientationFaceUp:
        case UIDeviceOrientationPortrait:
        case UIDeviceOrientationUnknown:
            degress = 0;
            break;
            
        case UIDeviceOrientationLandscapeLeft:
            degress = 90;
            break;
            
        case UIDeviceOrientationFaceDown:
        case UIDeviceOrientationPortraitUpsideDown:
            degress = 180;
            break;
            
        case UIDeviceOrientationLandscapeRight:
            degress = 270;
            break;
    }
    
    CGFloat radians = degress * M_PI / 180;
    CGAffineTransform transform = CGAffineTransformMakeRotation(radians);
    
    [UIView animateWithDuration:.5f animations:^{
        _gridButton.transform =
        _toggleButton.transform =
        _albumButton.transform =
        _flashButton.transform = transform;
    }];
}

- (AVCaptureVideoOrientation)videoOrientationForDeviceOrientation:(UIDeviceOrientation)deviceOrientation
{
    AVCaptureVideoOrientation result = (AVCaptureVideoOrientation) deviceOrientation;
    
    switch (deviceOrientation) {
        case UIDeviceOrientationLandscapeLeft:
            result = AVCaptureVideoOrientationLandscapeRight;
            break;
            
        case UIDeviceOrientationLandscapeRight:
            result = AVCaptureVideoOrientationLandscapeLeft;
            break;
            
        default:
            break;
    }
    
    return result;
}

- (void)viewWillDisappearWithCompletion:(void (^)(void))completion
{
    _actionsView.hidden = YES;
    
    [TGCameraSlideView showSlideUpView:_slideUpView slideDownView:_slideDownView atView:_captureView completion:^{
        completion();
    }];
}
- (IBAction)retake:(id)sender {
    
    _albumButton.enabled = YES;
    
    //删除当前预览图片
    _previewImage.hidden = YES;
    
    //隐藏下一步和重拍View
    _nextView.hidden =
    _shotButton.enabled = YES;
    
    //滤镜Index＝0 不加滤镜那么使用stillImageOutPut
    MGFilterPhotoCollectionViewCell *selectCell = (MGFilterPhotoCollectionViewCell *)[_collectionView cellForItemAtIndexPath:_selectedIndexPath];
    if ([selectCell.filterName.text isEqualToString:@"None"]) {
        
        //启动相机
        [_videoCamera stopRunning];
        [_camera startRunning];
        _isStillImageCamera = YES;
        [self.view.layer bringSublayerToFront:_camera.previewLayer];
    }else{
        //启动VideoCamera
        [_filterDescriptors enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ([selectCell.filterName.text isEqualToString:obj[@"name"]])
            {
                [_camera stopRunning];
                CIFilter *currentFilter = obj[@"filter"];
                //[_videoCamera insertSublayerWithCaptureView:self.captureView atRootView:self.view];
                _videoCamera.filter = currentFilter;
                [_videoCamera startRunning];
                [self.view.layer bringSublayerToFront:_videoCamera.previewLayer];
            }
        }];
        _isStillImageCamera = NO;
    }

}
- (IBAction)next:(id)sender {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MGPublishStatusViewController *publishStatusVC = [storyboard instantiateViewControllerWithIdentifier:@"MGPublishStatusViewController"];
    [self.navigationController pushViewController:publishStatusVC animated:YES];
}


- (void) savePhoto
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        //UIImageWriteToSavedPhotosAlbum(photo, self, @selector(saveDone), nil);
        
        //保存原始图片
        UIImageWriteToSavedPhotosAlbum(_origionalPhoto, nil, nil, nil);
        
        //保存滤镜图片
        UIImageWriteToSavedPhotosAlbum(_previewImage.image, nil, nil, nil);
        
    });
}
#pragma mark - CollectionViewDelete methods
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _filterDescriptors.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MGFilterPhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"mgCell" forIndexPath:indexPath];
    
    cell.filterName.text = _filterDescriptors[indexPath.row][@"name"];
    cell.filterImage.image = [UIImage imageNamed:@"test.png"];
    
    if (_selectedIndexPath!= nil && [_selectedIndexPath compare:indexPath] == NSOrderedSame) {
        cell.filterImage.layer.borderWidth = 2.0;
    }else
        cell.filterImage.layer.borderWidth = 0.0;
    
    if (indexPath.row > 0) {
        NSString *cacheKey = [NSString stringWithFormat:@"%@KEY",_filterDescriptors[indexPath.row][@"name"]];
        if ([_cachePhoto objectForKey:cacheKey]) {
            cell.filterImage.image = [_cachePhoto objectForKey:cacheKey];
        }else{
            [_cachePhoto setObject:[cell.filterImage.image addFilter:_filterDescriptors[indexPath.row][@"filter"]] forKey:cacheKey];
            cell.filterImage.image = [_cachePhoto objectForKey:cacheKey];
        }
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //当前滤镜
    _currentFilter = _filterDescriptors[indexPath.row];
    
    //第一次选None不需要任何操作
    if (_selectedIndexPath == indexPath) {
        return;
    }
    //选中的filter添加选中状态
    [self addBorderLayerToSelectCell:indexPath];
    
    if (indexPath.row > 0)
    {
        if (_isStillImageCamera) {
            if(_previewImage.hidden)
            {
                //照相前 （停止Image camera, 启动实时）
                [self changeToVideoCameraWithFilter:_filterDescriptors[indexPath.row][@"filter"] ];
            }else
            {
                //照相后
                //对照片加滤镜
                [self changeToFilter:indexPath];
            }
        }else{
            if (_previewImage.hidden) {
                //实时滤镜，准备下次拍摄
                [self videoCameraStarting];
                _videoCamera.filter = _filterDescriptors[indexPath.row][@"filter"];
                
            }else{
                //照相后
                //对照片加滤镜
                [self changeToFilter:indexPath];
            }
        }

    }else
    {
        if (!_previewImage.hidden)
        {
            //照相后
            //不需要加滤镜 直接显示原图片
            if (_origionalPhoto) {
                _previewImage.image = _origionalPhoto;
            }
            
        }else {
            
            //None 不加filter的情况
            [self cameraStaring];
        }
        
    }
}

- (void) cameraStaring
{
    [_camera startRunning];
    [_videoCamera stopRunning];
    [self.view.layer bringSublayerToFront:_camera.previewLayer];
    _isStillImageCamera = YES;
}
- (void) videoCameraStarting
{
    [_camera stopRunning];
    [_videoCamera startRunning];
    [self.view.layer bringSublayerToFront:_videoCamera.previewLayer];
    _isStillImageCamera = NO;
}


- (void) changeToVideoCameraWithFilter:(CIFilter *) filter {
    
    [self videoCameraStarting];
    
    _videoCamera.filter = filter;
}


- (void) changeToFilter:(NSIndexPath *) indexPath
{
    NSString *filterName = _filterDescriptors[indexPath.row][@"name"];
    if ([_cachePhoto objectForKey:filterName]) {
        _previewImage.image = [_cachePhoto objectForKey:filterName];
    } else {
        CIFilter *f = _filterDescriptors[indexPath.row][@"filter"];
        [_cachePhoto setObject:[_origionalPhoto addFilter:f] forKey:filterName];
        _previewImage.image = [_cachePhoto objectForKey:filterName];
    }
}


- (void) addBorderLayerToSelectCell:(NSIndexPath *) indexPath
{
    MGFilterPhotoCollectionViewCell *selectCell = (MGFilterPhotoCollectionViewCell *)[_collectionView cellForItemAtIndexPath:_selectedIndexPath];
    if (selectCell) {
        selectCell.filterImage.layer.borderWidth = 0.0;
    }
    selectCell = (MGFilterPhotoCollectionViewCell *)[_collectionView cellForItemAtIndexPath:indexPath];
    _selectedIndexPath = indexPath;
    selectCell.filterName.text = _filterDescriptors[indexPath.row][@"name"];
    selectCell.filterImage.layer.borderWidth = 2.0;
    selectCell.filterImage.layer.borderColor = [UIColor redColor].CGColor;
}

@end