//
//  JFYCamera Controller.m
//  StreamMedia(Study)
//
//  Created by vcyber on 16/5/9.
//  Copyright © 2016年 vcyber. All rights reserved.
//

#import "JFYCameraController.h"
#import <AVFoundation/AVFoundation.h>

typedef void(^PropertyChangeBlock)(AVCaptureDevice *captureDevice);

@interface JFYCameraController ()

@property (nonatomic, strong) AVCaptureSession *captureSession; //负责输入和输出设备之间的数据传递
@property (nonatomic, strong) AVCaptureDeviceInput *captureDeviceInput; //负责从AVCaptureDevice获得输入数据
@property (nonatomic, strong) AVCaptureStillImageOutput *captureStillImageOutput; //照片输出流
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *captureVideoPreviewLayer; //相机拍摄预览图层

@property (weak, nonatomic) IBOutlet UIView *viewContain;
@property (weak, nonatomic) IBOutlet UIButton *takeBtn; //拍照按钮
@property (weak, nonatomic) IBOutlet UIButton *flashOnBtn; //闪光灯打开btn
@property (weak, nonatomic) IBOutlet UIButton *flashOffBtn; //闪光灯关闭btn
@property (weak, nonatomic) IBOutlet UIButton *flashAutoBtn; //闪光灯自动btn

@property (weak, nonatomic) IBOutlet UIButton *changeCamera; //摄像头切换
@property (nonatomic, strong) UIView *focusCursor;

@end

@implementation JFYCameraController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createFocusCursor];
    
    //初始化会话
    _captureSession = [[AVCaptureSession alloc] init];
    if ([_captureSession canSetSessionPreset:AVCaptureSessionPresetiFrame1280x720]) { //设置分辨率
        _captureSession.sessionPreset = AVCaptureSessionPresetiFrame1280x720;
    }
    //获取输入的设备
    AVCaptureDevice *captureDevice = [self getCamerDeviceWithPositon:AVCaptureDevicePositionBack]; //获取后置摄像头
    if (!captureDevice) {
        NSLog(@"后摄头获取失败");
        return;
    }
    
    //初始化设备输出对象,用于获得输出数据
    NSError *error = nil;
    _captureDeviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:captureDevice error:&error];
    if (error) {
        NSLog(@"获取设备输入对象时出错,原因:%@", error.localizedDescription);
        return;
    }
    
    //初始化输出对象 用于获得输出数据
    _captureStillImageOutput = [[AVCaptureStillImageOutput alloc] init];
    NSDictionary *outputSetting = @{AVVideoCodecKey:AVVideoCodecJPEG};
    [_captureStillImageOutput setOutputSettings:outputSetting]; //输出设置
    
    //将设备输入添加到会话中
    if ([_captureSession canAddInput:_captureDeviceInput]) {
        [_captureSession addInput:_captureDeviceInput];
    }
    
    //将设备输出添加到会话中
    if ([_captureSession canAddOutput:_captureStillImageOutput]) {
        [_captureSession addOutput:_captureStillImageOutput];
    }
    
    //创建视频预览层,用于实时展示摄像头状态
    _captureVideoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    
    CALayer *layer = self.viewContain.layer;
    layer.masksToBounds = YES;
    
    _captureVideoPreviewLayer.frame = layer.bounds;
    _captureVideoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill; //设置填充模式
    //将视频预览图层添加到界面中
    [layer insertSublayer:_captureVideoPreviewLayer below:nil];
    
    [self addNotificationToCaptureDevice:captureDevice];
    [self addGestureRecognizer];
    [self setFlashModeBtnStatus];
    
}

- (void)createFocusCursor {
    
    self.focusCursor = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 50)];
    self.focusCursor.center = self.view.center;
    self.focusCursor.backgroundColor = [UIColor blackColor];
    self.focusCursor.layer.borderWidth = 3;
    [self.viewContain addSubview:self.focusCursor];
}


#pragma mark --UI事件处理
#pragma mark --拍照
- (IBAction)takeBtnClick:(id)sender {
    //根据设备输出获得连接
    AVCaptureConnection *captureConnection = [self.captureStillImageOutput connectionWithMediaType:AVMediaTypeVideo];
    //根据连接取得设备输出的数据
    [self.captureStillImageOutput captureStillImageAsynchronouslyFromConnection:captureConnection completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        if (imageDataSampleBuffer) {
            NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
            UIImage *image = [UIImage imageWithData:imageData];
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
        }
        
    }];
}

#pragma mark --切换摄像头
- (IBAction)toggleBtnClick:(id)sender {
    AVCaptureDevice *currentDevice = [self.captureDeviceInput device];
    AVCaptureDevicePosition currentPosition = [currentDevice position];
    [self removeNotificationFromCaptureDevice:currentDevice];
    AVCaptureDevice *toChangeDevice;
    AVCaptureDevicePosition toChangePosition = AVCaptureDevicePositionFront;
    if (currentPosition == AVCaptureDevicePositionUnspecified || currentPosition == AVCaptureDevicePositionFront) {
        
        toChangePosition = AVCaptureDevicePositionBack;
        
    }
    toChangeDevice = [self getCamerDeviceWithPositon:toChangePosition];
    [self addNotificationToCaptureDevice:toChangeDevice];
    //获取要调整的设备输入对象
    AVCaptureDeviceInput *toChangeDeviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:toChangeDevice error:nil];
    
    //改变会话的配置前一定要先开启配置,配置完成后提交配置改变
    [self.captureSession beginConfiguration];
    //移除原有输入对象
    [self.captureSession removeInput:self.captureDeviceInput];
    //添加新的输入对象
    if ([self.captureSession canAddInput:toChangeDeviceInput]) {
        [self.captureSession addInput:toChangeDeviceInput];
        self.captureDeviceInput = toChangeDeviceInput;
    }
    
    [self.captureSession commitConfiguration];
    
    [self setFlashModeBtnStatus];
}

#pragma mark 自动闪光灯
- (IBAction)flashAutoClick:(id)sender {
    [self setFlashMode:AVCaptureFlashModeAuto];
}

#pragma mark 关闭闪光灯
- (IBAction)flashOffClick:(id)sender {
    [self setFlashMode:AVCaptureFlashModeOff];
}

#pragma mark 打开闪光灯
- (IBAction)flashOnClick:(id)sender {
    [self setFlashMode:AVCaptureFlashModeOn];
}



//通知
- (void)addNotificationToCaptureDevice:(AVCaptureDevice *)captureDevice {
    
    //注意添加区域改变捕获通知必须首先设置设备允许捕获
    [self changeDeviceProperty:^(AVCaptureDevice *captureDevice) {
        
        captureDevice.subjectAreaChangeMonitoringEnabled = YES;
    }];
    //捕获区域发生改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(areaChange:) name:AVCaptureDeviceSubjectAreaDidChangeNotification object:captureDevice];
    
}

//移除通知
- (void)removeNotificationFromCaptureDevice:(AVCaptureDevice *)captureDevice {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVCaptureDeviceSubjectAreaDidChangeNotification object:captureDevice];
}

//移除所有的通知
- (void)removeAllNotification {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)addNotificationToCaptureSession:(AVCaptureSession *)captureSession {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sessionRuntimeError:) name:AVCaptureSessionRuntimeErrorNotification object:captureSession];
}

- (void)areaChange:(NSNotification *)noti {
    
    NSLog(@"捕获区域改变");
}

- (void)sessionRuntimeError:(NSNotification *)noti {
    
    NSLog(@"会话发生失败");
}

/**
 *  改变设备属性的方法
 *
 *  @param propertyChange 属性改变的操作
 */
- (void)changeDeviceProperty:(PropertyChangeBlock)propertyChange {
    AVCaptureDevice *captureDevice = [self.captureDeviceInput device];
    NSError *error =nil;
    //hzuyi改变设备的属性首选调用lockForConfiguration:调完之后使用unlockForConfiguration:方法解锁
    if ([captureDevice lockForConfiguration:&error]) {
        PropertyChangeBlock(captureDevice);
        [captureDevice unlockForConfiguration];
    }else {
        NSLog(@"改变设备属性时错误:%@", error.localizedDescription);
    }
    
}

- (AVCaptureDevice *)getCamerDeviceWithPositon:(AVCaptureDevicePosition)position {
    
    NSArray *cameras = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for (AVCaptureDevice *camera in cameras) {
        if ([camera position] == position) {
            return camera;
        }
    }
    return nil;
}

/**
 *  设置闪光灯的模式
 *
 *  @param flashMode 闪光灯模式
 */
- (void)setFlashMode:(AVCaptureFlashMode)flashMode {
    [self changeDeviceProperty:^(AVCaptureDevice *captureDevice) {
        if ([captureDevice isFlashModeSupported:flashMode]) {
            [captureDevice setFlashMode:flashMode];
            [self setFlashModeBtnStatus];
        }
        
    }];
    
}

/**
 *  设置聚焦模式
 *
 *  @param focusMode 聚焦模式
 */
- (void)setFocusMode:(AVCaptureFocusMode)focusMode {
    
    [self changeDeviceProperty:^(AVCaptureDevice *captureDevice) {
        
        if ([captureDevice isFocusModeSupported:focusMode]) {
            [captureDevice setFocusMode:focusMode];
        }
    }];
}

/**
 *  设置曝光模式
 *
 *  @param exposureMode 曝光模式
 */
- (void)setExposureMode:(AVCaptureExposureMode)exposureMode {
    
    [self changeDeviceProperty:^(AVCaptureDevice *captureDevice) {
        if ([captureDevice isExposureModeSupported:exposureMode]) {
            [captureDevice setExposureMode:exposureMode];
        }
        
    }];
}

/**
 *  设置聚焦点
 *
 *  @param focusMode    聚焦模式
 *  @param exposureMode 曝光模式
 *  @param point        聚焦点
 */
- (void)foucsWithMode:(AVCaptureFocusMode)focusMode exposureMode:(AVCaptureExposureMode)exposureMode atPoint:(CGPoint)point {
    
    [self changeDeviceProperty:^(AVCaptureDevice *captureDevice) {
       
        if ([captureDevice isFocusModeSupported:focusMode]) {
            [captureDevice setFocusMode:AVCaptureFocusModeAutoFocus];
        }
        if ([captureDevice isFocusPointOfInterestSupported]) {
            [captureDevice setFocusPointOfInterest:point];
        }
        if ([captureDevice isExposureModeSupported:exposureMode]) {
            [captureDevice setExposureMode:AVCaptureExposureModeAutoExpose];
        }
        if ([captureDevice isExposurePointOfInterestSupported]) {
            [captureDevice setExposurePointOfInterest:point];
        }
        
    }];
    
}

/**
 *  添加手势,点按时聚焦
 */
- (void)addGestureRecognizer {
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapScreen:)];
    [self.viewContain addGestureRecognizer:tap];
}

- (void)tapScreen:(UITapGestureRecognizer *)tap {
    
    CGPoint point = [tap locationInView:self.viewContain];
    //将UI坐标转化为摄像头坐标
    CGPoint cameraPoint = [self.captureVideoPreviewLayer captureDevicePointOfInterestForPoint:point];
    [self setFocusCursorWithPoint:point];
    [self foucsWithMode:AVCaptureFocusModeAutoFocus exposureMode:AVCaptureExposureModeAutoExpose atPoint:cameraPoint];
}

/**
 *  设置闪光灯状态
 */
- (void)setFlashModeBtnStatus {
    
    AVCaptureDevice *captureDevice = [self.captureDeviceInput device];
    AVCaptureFlashMode flashMode = captureDevice.flashMode;
    if ([captureDevice isFlashAvailable]) {
        self.flashAutoBtn.hidden = NO;
        self.flashOnBtn.hidden = NO;
        self.flashOffBtn.hidden = NO;
        self.flashAutoBtn.enabled = YES;
        self.flashOffBtn.enabled = YES;
        self.flashOnBtn.enabled = YES;
        switch (flashMode) {
            case AVCaptureFlashModeOn:
                self.flashOnBtn.enabled = NO;
                break;
            case AVCaptureFlashModeOff:
                self.flashOffBtn.enabled = NO;;
                break;
            case AVCaptureFlashModeAuto:
                self.flashAutoBtn.enabled = NO;
                break;
                
            default:
                break;
        }
    }else {
        
        self.flashOffBtn.hidden = YES;
        self.flashOnBtn.hidden = YES;
        self.flashAutoBtn.hidden = YES;
    }
}

/**
 *  设置聚焦光标的位置
 *
 *  @param point 光标的位置
 */
- (void)setFocusCursorWithPoint:(CGPoint)point {
    self.focusCursor.center = point;
    self.focusCursor.transform = CGAffineTransformMakeScale(1.5, 1.5);
    self.focusCursor.alpha = 1.0;
    [UIView animateWithDuration:1.0 animations:^{
        self.focusCursor.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        
        self.focusCursor.alpha= 0;
    }];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    [self.captureSession startRunning];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
    [self.captureSession stopRunning];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
