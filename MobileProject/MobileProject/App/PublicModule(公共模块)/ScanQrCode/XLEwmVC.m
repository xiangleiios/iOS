//
//  XLEwmVC.m
//  FSZX
//
//  Created by zsgy on 16/11/8.
//  Copyright © 2016年 王文辉. All rights reserved.
//

#import "XLEwmVC.h"
#import <AVFoundation/AVFoundation.h>
#import "XLSmV.h"
#import "XLSMWebVC.h"
#import "FMSingle.h"



@interface XLEwmVC ()<AVCaptureMetadataOutputObjectsDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

/** 会话对象 */
@property (nonatomic, strong) AVCaptureSession *session;
/** 图层类 */
@property (nonatomic, strong) AVCaptureVideoPreviewLayer *previewLayer;
@property (nonatomic, strong) XLSmV *scanningView;

@property (nonatomic, strong) UIButton *right_Button;
@property (nonatomic, assign) BOOL first_push;





@end

@implementation XLEwmVC

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // 创建扫描边框
    self.scanningView = [[XLSmV alloc] initWithFrame:self.view.frame outsideViewLayer:self.view.layer];
    [self.view addSubview:self.scanningView];
//        [self.navigationController.navigationBar setTintColor:[UIColor colorWithRed:164/255.0 green:173/255.0 blue:181/255.0 alpha:1]];
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.navigationController.navigationBar.barTintColor = [UIColor purpleColor];
    
    self.navigationItem.title = @"扫一扫";
    
    // 二维码扫描
    [self setupScanningQRCode];
    
    self.first_push = YES;
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"相册" style:(UIBarButtonItemStyleDone) target:self action:@selector(rightBarButtonItenAction)];
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - - - rightBarButtonItenAction 的点击事件
- (void)rightBarButtonItenAction {
    [self readImageFromAlbum];
}

#pragma mark - - - 从相册中读取照片
- (void)readImageFromAlbum {
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init]; // 创建对象
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary; //（选择类型）表示仅仅从相册中选取照片
    imagePicker.delegate = self; // 指定代理，因此我们要实现UIImagePickerControllerDelegate,  UINavigationControllerDelegate协议
    [self presentViewController:imagePicker animated:YES completion:nil]; // 显示相册
}

#pragma mark - - - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    
    [self dismissViewControllerAnimated:YES completion:^{
        [self scanQRCodeFromPhotosInTheAlbum:image];
    }];
}

/** 从相册中识别二维码, 并进行界面跳转 */
- (void)scanQRCodeFromPhotosInTheAlbum:(UIImage *)image {
    // CIDetector(CIDetector可用于人脸识别)进行图片解析，从而使我们可以便捷的从相册中获取到二维码
    // 声明一个CIDetector，并设定识别类型 CIDetectorTypeQRCode
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{ CIDetectorAccuracy : CIDetectorAccuracyHigh }];
    
    // 取得识别结果
    NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
    for (int index = 0; index < [features count]; index ++) {
        CIQRCodeFeature *feature = [features objectAtIndex:index];
        NSString *scannedResult = feature.messageString;
//        KKLog(@"result:%@",scannedResult);
        
        if (self.first_push) {
            XLSMWebVC *jumpVC = [[XLSMWebVC alloc] init];
            jumpVC.jump_URL = scannedResult;
 
            [self.navigationController pushViewController:jumpVC animated:YES];
            
            self.first_push = NO;
        }
    }
}


#pragma mark - - - 二维码扫描
- (void)setupScanningQRCode {
    // 1、获取摄像设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // 2、创建输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    
    // 3、创建输出流
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    
    // 4、设置代理 在主线程里刷新
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // 设置扫描范围(每一个取值0～1，以屏幕右上角为坐标原点)
    // 注：微信二维码的扫描范围是整个屏幕， 这里并没有做处理（可不用设置）
    output.rectOfInterest = CGRectMake(0.05, 0.2, 0.7, 0.6);
    
    // 5、 初始化链接对象（会话对象）
    self.session = [[AVCaptureSession alloc] init];
    // 高质量采集率
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    
    // 5.1 添加会话输入
    [_session addInput:input];
    
    // 5.2 添加会话输出
    [_session addOutput:output];
    
    // 6、设置输出数据类型，需要将元数据输出添加到会话后，才能指定元数据类型，否则会报错
    // 设置扫码支持的编码格式(如下设置条形码和二维码兼容)
    output.metadataObjectTypes = @[AVMetadataObjectTypeQRCode, AVMetadataObjectTypeEAN13Code,  AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
    
    // 7、实例化预览图层, 传递_session是为了告诉图层将来显示什么内容
    self.previewLayer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    _previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _previewLayer.frame = self.view.layer.bounds;
    
    // 8、将图层插入当前视图
    [self.view.layer insertSublayer:_previewLayer atIndex:0];
    
    // 9、启动会话
    [_session startRunning];
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    // 会频繁的扫描，调用代理方法
    
    // 0. 扫描成功之后的提示音
    [self playSoundEffect:@"sound.caf"];
    
    // 1. 如果扫描完成，停止会话
    [self.session stopRunning];
    
    // 2. 删除预览图层
    [self.previewLayer removeFromSuperlayer];
    
    // 3. 设置界面显示扫描结果
    if (metadataObjects.count > 0) {
        AVMetadataMachineReadableCodeObject *obj = metadataObjects[0];
        
//        KKLog(@"metadataObjects = %@", metadataObjects);
        [FMSingle shareSingle].yfQrCode = obj.stringValue;
       
    }
    [self.navigationController popViewControllerAnimated:YES];
}

// 移除定时器
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.scanningView removeTimer];
    [self.scanningView removeFromSuperview];
    self.scanningView = nil;
    //    KKLog(@" - - -- viewDidAppear");
}
#pragma mark - - - 扫描提示声
/**
 *  播放完成回调函数
 *
 *  @param soundID    系统声音ID
 *  @param clientData 回调时传递的数据
 */
void soundCompleteCallback(SystemSoundID soundID,void * clientData){
//    KKLog(@"播放完成...");
}

/**
 *  播放音效文件
 *
 *  @param name 音频文件名称
 */
- (void)playSoundEffect:(NSString *)name{
    NSString *audioFile = [[NSBundle mainBundle] pathForResource:name ofType:nil];
    NSURL *fileUrl = [NSURL fileURLWithPath:audioFile];
    // 1.获得系统声音ID
    SystemSoundID soundID = 0;
    /**
     * inFileUrl:音频文件url
     * outSystemSoundID:声音id（此函数会将音效文件加入到系统音频服务中并返回一个长整形ID）
     */
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(fileUrl), &soundID);
    
    // 如果需要在播放完之后执行某些操作，可以调用如下方法注册一个播放完成回调函数
    AudioServicesAddSystemSoundCompletion(soundID, NULL, NULL, soundCompleteCallback, NULL);
    
    // 2.播放音频
    AudioServicesPlaySystemSound(soundID);//播放音效
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
