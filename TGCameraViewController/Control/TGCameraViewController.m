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

#import "MGVideoCamera.h"

static NSString* const kTGCacheSatureKey = @"TGCacheSatureKey";
static NSString* const kTGCacheCurveKey = @"TGCacheCurveKey";
static NSString* const kTGCacheVignetteKey = @"TGCacheVignetteKey";

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

@property (nonatomic, strong) MGFilterPhotoCollectionViewCell *selectCell;

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


@property (strong, nonatomic) IBOutlet TGCameraFilterView *filterView;

@property (strong, nonatomic) IBOutlet TGCameraFilterView *mgFilterView;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (strong, nonatomic) NSCache *cachePhoto;

@property (nonatomic,strong) UIView *detailFilterView;

@property (nonatomic, strong) NSArray *filterDescriptors;

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
    
    
    UINib *cellNib = [UINib nibWithNibName:@"MGFilterPhotoCollectionViewCell" bundle:nil];
    [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"mgCell"];
    
    if (CGRectGetHeight([[UIScreen mainScreen] bounds]) <= 480) {
        _topViewHeight.constant = 0;
    }
    
    _filterDescriptors = @[@"1",@"2",@"3"];

    _camera = [TGCamera cameraWithFlashButton:_flashButton];
    _origionalPhoto = [UIImage new];
//    _cachePhoto = [NSCache new];
    _captureView.backgroundColor = [UIColor clearColor];
    
    _topLeftView.transform = CGAffineTransformMakeRotation(0);
    _topRightView.transform = CGAffineTransformMakeRotation(M_PI_2);
    _bottomLeftView.transform = CGAffineTransformMakeRotation(-M_PI_2);
    _bottomRightView.transform = CGAffineTransformMakeRotation(M_PI_2*2);
    
    
    if ([_filterView isDescendantOfView:self.view]) {
        [_filterView removeFromSuperviewAnimated];
    } else {
//        [_filterView addToView:self.view aboveView:_bottomView];
        [self.actionsView addSubview:_mgFilterView];
        _mgFilterView.backgroundColor = [UIColor redColor];
        //[self.view sendSubviewToBack:_filterView];
//        [self.view sendSubviewToBack:_photoView];
    }
    
    
    /**********************实时滤镜*****************/
    _videoCamera = [MGVideoCamera cameraWithFlashButton:_flashButton];
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
    
    _previewImage.frame = _captureView.frame;
    
    _nextView.hidden = YES;
    
    [self deviceOrientationDidChangeNotification];
    
    ////[_camera startRunning];
    
    _separatorView.hidden = YES;
    
    [TGCameraSlideView hideSlideUpView:_slideUpView slideDownView:_slideDownView atView:_captureView completion:^{
        _topLeftView.hidden =
        _topRightView.hidden =
        _bottomLeftView.hidden =
        _bottomRightView.hidden = NO;
        
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
    }
    
    _selectCell = (MGFilterPhotoCollectionViewCell *)[_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    _selectCell.filterImage.layer.borderWidth = 2.0;
    _selectCell.filterImage.layer.borderColor = [UIColor redColor].CGColor;
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [_camera stopRunning];
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
    UIImage *photo = [TGAlbum imageWithMediaInfo:info];
    
    TGPhotoViewController *viewController = [TGPhotoViewController newWithDelegate:_delegate photo:photo];
    [viewController setAlbumPhoto:YES];
    [self.navigationController pushViewController:viewController animated:NO];
    
    [self dismissViewControllerAnimated:YES completion:nil];
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
    [_camera changeFlashModeWithButton:_flashButton];
}

- (IBAction)shotTapped
{
    _shotButton.enabled =
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
    
    [_camera takePhotoWithCaptureView:_captureView videoOrientation:videoOrientation cropSize:_captureView.frame.size
                           completion:^(UIImage *photo) {
                               [self.view addSubview:_previewImage];
                               _origionalPhoto = photo;
                               _previewImage.image = photo;
                               _nextView.hidden = NO;
                               _previewImage.hidden = NO;
//                               TGPhotoViewController *viewController = [TGPhotoViewController newWithDelegate:_delegate photo:photo];
//                               [self.navigationController pushViewController:viewController animated:YES];
                           }];
    
    
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
    [_camera toogleWithFlashButton:_flashButton];
}

- (IBAction)handleTapGesture:(UITapGestureRecognizer *)recognizer
{
    CGPoint touchPoint = [recognizer locationInView:_captureView];
    [_camera focusView:_captureView inTouchPoint:touchPoint];
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
    _nextView.hidden =
    _previewImage.hidden =
    _shotButton.enabled = YES;
}
- (IBAction)next:(id)sender {
}

- (IBAction)defaultFilterTapped:(UIButton *)button
{
    [self addDetailViewToButton:button];
    _previewImage.hidden = YES;
    if (_previewImage.hidden) {
        ////[_camera stopRunning];
        
        [_videoCamera insertSublayerWithCaptureView:self.captureView atRootView:self.view];
        [_videoCamera startRunning];
    }else{
        ////[_videoCamera stopRunning];
        ////[_camera startRunning];
        
        _previewImage.image = _origionalPhoto;
    }
}

- (IBAction)satureFilterTapped:(UIButton *)button
{
    [self addDetailViewToButton:button];
//    if ([_cachePhoto objectForKey:kTGCacheSatureKey]) {
//        _previewImage.image = [_cachePhoto objectForKey:kTGCacheSatureKey];
//    } else {
//        [_cachePhoto setObject:[_origionalPhoto saturateImage:1.8 withContrast:1] forKey:kTGCacheSatureKey];
//        _previewImage.image = [_cachePhoto objectForKey:kTGCacheSatureKey];
//    }
//    
}

- (IBAction)curveFilterTapped:(UIButton *)button
{
    [self addDetailViewToButton:button];
    
//    if ([_cachePhoto objectForKey:kTGCacheCurveKey]) {
//        _previewImage.image = [_cachePhoto objectForKey:kTGCacheCurveKey];
//    } else {
//        [_cachePhoto setObject:[_origionalPhoto curveFilter] forKey:kTGCacheCurveKey];
//        _previewImage.image = [_cachePhoto objectForKey:kTGCacheCurveKey];
//    }
}

- (IBAction)vignetteFilterTapped:(UIButton *)button
{
    [self addDetailViewToButton:button];
    
//    if ([_cachePhoto objectForKey:kTGCacheVignetteKey]) {
//        _previewImage.image = [_cachePhoto objectForKey:kTGCacheVignetteKey];
//    } else {
//        [_cachePhoto setObject:[_origionalPhoto vignetteWithRadius:0 intensity:6] forKey:kTGCacheVignetteKey];
//        _previewImage.image = [_cachePhoto objectForKey:kTGCacheVignetteKey];
//    }
}

- (void)addDetailViewToButton:(UIButton *)button
{
    [_detailFilterView removeFromSuperview];
    
    CGFloat height = 2.5;
    
    CGRect frame = button.frame;
    frame.size.height = height;
    frame.origin.x = 0;
    frame.origin.y = CGRectGetMaxY(button.frame) - height;
    
    _detailFilterView = [[UIView alloc] initWithFrame:frame];
    _detailFilterView.backgroundColor = [TGCameraColor orangeColor];
    _detailFilterView.userInteractionEnabled = NO;
    
    [button addSubview:_detailFilterView];
}


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

    cell.filterName.text = _filterDescriptors[indexPath.row];
    
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //选中的filter添加选中状态
    [self addBorderLayerToSelectCell:indexPath];
    
    if (indexPath.row > 0)
    {
        [_videoCamera insertSublayerWithCaptureView:self.captureView atRootView:self.view];
        
        if (indexPath.row == 1) {
            _videoCamera.filter = [CIFilter filterWithName:@"CIGaussianBlur"];
        }
        
        if (indexPath.row == 2) {
            _videoCamera.filter = [CIFilter filterWithName:@"CIVibrance"];
        }
        
        
        
        [_videoCamera startRunning];
    }
}


- (void) addBorderLayerToSelectCell:(NSIndexPath *) indexPath
{
    if (_selectCell) {
        _selectCell.filterImage.layer.borderWidth = 0.0;
        _selectCell.filterImage.layer.borderColor = [UIColor whiteColor].CGColor;
    }
    _selectCell = (MGFilterPhotoCollectionViewCell *)[_collectionView cellForItemAtIndexPath:indexPath];
    _selectCell.filterImage.layer.borderWidth = 2.0;
    _selectCell.filterImage.layer.borderColor = [UIColor redColor].CGColor;
}

@end