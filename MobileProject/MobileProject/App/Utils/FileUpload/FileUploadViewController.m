//
//  FileUploadViewController.m
//  TideNews
//
//  Created by 王文辉 on 14-4-26.
//  Copyright (c) 2014年 王文辉. All rights reserved.
//

#import "FileUploadViewController.h"
//#import "GAHTTPRequest.h"
//#import "AlertHelper.h"
@interface FileUploadViewController ()
{
    BOOL isUploading_;
//    GAHTTPRequest *request_;
}

@end

@implementation FileUploadViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"文件上传";
    self.contentImageView=[[UIImageView alloc]init];
    [self.view addSubview:self.contentImageView];
    [self.contentImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(KFit_H6S(100));
        make.height.width.mas_equalTo(KFit_H6S(350));
    }];
    self.contentImageView.image = self.contentImage;
    
    
    UIButton *but=[[UIButton alloc]init];
    [self.view addSubview:but];
    [but mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.contentImageView.mas_bottom).mas_offset(KFit_H6S(110));
        make.width.mas_equalTo(KFit_W6S(530));
        make.height.mas_equalTo(KFit_H6S(80));
    }];
    but.layer.cornerRadius=KFit_H6S(40);
    but.backgroundColor=kRGBColor(251, 189, 44);
    [but setTitle:@"上传文件" forState:UIControlStateNormal];
    [but addTarget:self action:@selector(actionUpload:) forControlEvents:UIControlEventTouchUpInside];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//- (void) dealloc
//{
//    [request_ cancel];
//    request_ = nil;
//}

#pragma mark - Action

- (void) handleSuccess:(NSString *)url
{
    [self.delegate fildUploadDone:url controller:self];
    [self.navigationController popViewControllerAnimated:YES];
}

//- (void) handleError
//{
//    [AlertHelper showAlert:@"文件上传失败，请重试！"];
//    [self actionUpload:[self.view viewWithTag:500]];
//}

- (void)actionUpload:(id)sender
{
    isUploading_ = !isUploading_;
    UIActivityIndicatorView *loadingView = (UIActivityIndicatorView *)[self.view viewWithTag:501];
    UIView *shadowView = [self.view viewWithTag:502];
    if (isUploading_) {
        [MBProgressHUD showMessage:@"正在上传..." ToView:self.view];
        [sender setImage:[UIImage imageNamed:@"cancel_btn.png"] forState:UIControlStateNormal];
        loadingView.hidden = NO;
        shadowView.hidden = NO;
        [loadingView startAnimating];
        
        //
        BOOL isVideo = (self.mediaUrl==nil?NO:YES);
        NSString *url=[NSString stringWithFormat:POSTFileUpload,[User UserOb].token];
        if (isVideo) {
            NSDate *date = [NSDate date];
            NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
            [dateformatter setDateFormat:@"YYYY-MM-dd-HH-mm-ss"];
            NSString *dateName = [dateformatter stringFromDate:date];
            NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
            NSString *pathName = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.mp4",dateName]];
            NSLog(@"沙盒：%@",pathName);
            //转码配置
            AVURLAsset *asset = [AVURLAsset URLAssetWithURL:self.mediaUrl options:nil];
            AVAssetExportSession *exportSession= [[AVAssetExportSession alloc] initWithAsset:asset presetName:AVAssetExportPresetMediumQuality];
            exportSession.shouldOptimizeForNetworkUse = YES;
            exportSession.outputURL = [NSURL fileURLWithPath:pathName];
            exportSession.outputFileType = AVFileTypeMPEG4;
            [exportSession exportAsynchronouslyWithCompletionHandler:^{
                int exportStatus = exportSession.status;
                switch (exportStatus)     {
                    case AVAssetExportSessionStatusFailed:
                    {
                        // log error to text view
                        NSError *exportError = exportSession.error;
                        NSLog (@"AVAssetExportSessionStatusFailed: %@", exportError);
                        break;
                    }
                    case AVAssetExportSessionStatusCompleted:
                    {
                        NSData *videoData = [NSData dataWithContentsOfFile:pathName];
                        [[AFHTTPSessionManager manager] POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                            [formData appendPartWithFileData:videoData name:@"video_file" fileName:@"shiping.mp4" mimeType:@"video/quicktime"];
                        } progress:^(NSProgress * _Nonnull uploadProgress) {
                            
                        } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                            NSLog(@"视屏成功=============%@",responseObject);
                            [MBProgressHUD hideHUDForView:self.view];
                            //上传之后删除压缩文件
                             NSFileManager* fileManager=[NSFileManager defaultManager];
                            BOOL blDele= [fileManager removeItemAtPath:pathName error:nil];
                            if (blDele) {
                                NSLog(@"dele success");
                            }else {
                                NSLog(@"dele fail");
                            }
                            if (kResponseObjectStatusCodeIsEqual(200)) {
                            [self.navigationController popViewControllerAnimated:NO];
                            [self.delegate fildUploadDone:responseObject[@"data"] controller:self];
                            }else{
                                [MBProgressHUD showAutoMessage:responseObject[@"message"]];
                            }
                            
                        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                            [MBProgressHUD hideHUDForView:self.view];
                        }];
                    }
                }
            }];
            
            //转码配置
//            AVURLAsset *asset = [AVURLAsset URLAssetWithURL:self.mediaUrl options:nil];
//            AVAssetExportSession *exportSession= [[AVAssetExportSession alloc] initWithAsset:asset presetName:AVAssetExportPresetMediumQuality];
//            exportSession.shouldOptimizeForNetworkUse = YES;
////            exportSession.outputURL = [NSURL fileURLWithPath:self.mediaUrl];
//            exportSession.outputFileType = AVFileTypeMPEG4;
//            [exportSession exportAsynchronouslyWithCompletionHandler:^{ int exportStatus = exportSession.status;
//            KKLog(@"%d",exportStatus);
//            switch (exportStatus) {
//                case AVAssetExportSessionStatusFailed: {
//                    // log error to text view
//                    NSError *exportError = exportSession.error;
//                    NSLog (@"AVAssetExportSessionStatusFailed: %@", exportError);
//                    break; }
//                case AVAssetExportSessionStatusCompleted: {
//                    KKLog(@"视频转码成功");
//                    NSData *data = [NSData dataWithContentsOfFile:model.sandBoxFilePath];
////                    model.fileData = data;
//                    }
//                }
//            }];
     
            
        }else{
                AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
                [manager POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                     [formData appendPartWithFileData:UIImageJPEGRepresentation(self.contentImage, 0.1) name:@"image_file" fileName:@"tupian.png" mimeType:@"image/png"];
                } progress:^(NSProgress * _Nonnull uploadProgress) {
                    
                } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    NSLog(@"成功返货=============%@",responseObject);
                    [MBProgressHUD hideHUDForView:self.view];
                    if (kResponseObjectStatusCodeIsEqual(200)) {
                    [self.navigationController popViewControllerAnimated:YES];
                    [self.delegate fildUploadDone:responseObject[@"data"] controller:self];
                    }else{
                        [MBProgressHUD showAutoMessage:responseObject[@"message"]];
                    }
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    [MBProgressHUD hideHUDForView:self.view];
                }];
        }
        
    } else {
        [sender setImage:[UIImage imageNamed:@"upload_btn.png"] forState:UIControlStateNormal];
        shadowView.hidden = YES;
        [loadingView stopAnimating];
        
//        [request_ cancel];
//        request_ = nil;
    }
}

//#pragma mark - GAHttpRequest
//
//- (void) completedWithData:(NSData *)data AndRequest:(GAHTTPRequest *)request
//{
//    NSString *url = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//    [self performSelectorOnMainThread:@selector(handleSuccess:) withObject:url waitUntilDone:NO];
//}
//
//- (void) failedWithError:(NSError *)error AndRequest:(GAHTTPRequest *)request
//{
//    [self performSelectorOnMainThread:@selector(handleError) withObject:nil waitUntilDone:NO];
//}

@end
