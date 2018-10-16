//
//  FMNetworkHelper.m
//  MobileProject
//
//  Created by Mingo on 2017/7/9.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "FMNetworkHelper.h"
/*! 系统相册 */
#import <AssetsLibrary/ALAsset.h>
#import <AssetsLibrary/ALAssetsLibrary.h>
#import <AssetsLibrary/ALAssetsGroup.h>
#import <AssetsLibrary/ALAssetRepresentation.h>
#import "FMHelper.h"

@implementation FMNetworkHelper

#pragma mark - 网络类型判断
- (void)ba_netType {
//    BAWeak;
    [BANetManager ba_startNetWorkMonitoringWithBlock:^(BANetworkStatus status) {
        NSString *msg;
        switch (status) {
            case 0: {
                msg = @"未知网络";
            }
                break;
            case 1: {
                msg = @"没有网络";
            }
                break;
            case 2: {
                msg = @"您的网络类型为：手机 3G/4G 网络";
            }
                break;
            case 3: {
                msg = @"您的网络类型为：wifi 网络";
                /*! wifi 网络下请求网络：可以在父类写此方法，具体使用demo，详见：https://github.com/boai/BABaseProject */
            }
                break;
            default:
                break;
        }
        [MBProgressHUD showAutoMessage:msg];
    }];
}

#pragma mark - 网络请求的类方法 --- get 
/**
 网络请求的实例方法 get
 
 @param urlString 请求的地址
 @param isNeedCache 是否需要缓存，只有 get / post 请求有缓存配置
 @param parameters 请求的参数
 @param successBlock 请求成功的回调
 @param failureBlock 请求失败的回调
 @param progress 进度
 @return BAURLSessionTask
 */
+ (__kindof NSURLSessionTask *)fm_request_getWithUrlString:(NSString *)urlString
                                      isNeedCache:(BOOL)isNeedCache
                                       parameters:(NSDictionary *)parameters
                                     successBlock:(FMRequestSuccess)successBlock
                                     failureBlock:(FMRequestFailure)failureBlock
                                         progress:(FMDownloadProgress)progress {
    urlString = [urlString stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
   NSURLSessionTask *sessionTask =   [BANetManager ba_request_GETWithUrlString:urlString isNeedCache:isNeedCache parameters:parameters successBlock:^(id responseObject) {
        if (kResponseObjectStatusCodeIsEqual(404)) {
           [self fm_request404ShowLogin:responseObject];
        }else if (kResponseObjectStatusCodeIsEqual(200)){
            
        }else{
            XLAlertView *alert = [[XLAlertView alloc] initWithMessage:responseObject[@"message"] SuccessOrFailure:NO];
            [alert showPrompt];
        }
       successBlock(responseObject);
    } failureBlock:^(NSError *error) {
        KKLog(@"%@", error);
        XLAlertView *alert = [[XLAlertView alloc] initWithMessage:@"网络错误" SuccessOrFailure:NO];
        [alert showPrompt];
        failureBlock(error);
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        progress(bytesProgress,totalBytesProgress);
    }];
    
    return sessionTask;
}

/**
 网络请求的实例方法 post
 
 @param urlString 请求的地址
 @param isNeedCache 是否需要缓存，只有 get / post 请求有缓存配置
 @param parameters 请求的参数
 @param successBlock 请求成功的回调
 @param failureBlock 请求失败的回调
 @param progress 进度
 @return BAURLSessionTask
 */
+ (__kindof NSURLSessionTask *)fm_request_postWithUrlString:(NSString *)urlString
                                       isNeedCache:(BOOL)isNeedCache
                                        parameters:(NSDictionary *)parameters
                                      successBlock:(FMRequestSuccess)successBlock
                                      failureBlock:(FMRequestFailure)failureBlock
                                          progress:(FMDownloadProgress)progress {
    [FMNetworkHelper fm_setValue:[User UserOb].token forHTTPHeaderKey:@"token"];
    [FMNetworkHelper fm_setValue:@"Mobile" forHTTPHeaderKey:@"loginType"];
    NSURLSessionTask *sessionTask = [BANetManager ba_request_POSTWithUrlString:urlString isNeedCache:isNeedCache parameters:parameters successBlock:^(id responseObject) {
        if (kResponseObjectStatusCodeIsEqual(401)) {
            [MBProgressHUD showMsgHUD:@"登录失效，请重新登录"];
            XLAlertView *alert = [[XLAlertView alloc] initWithTitle:@"提示" message:@"登录失效，请重新登录" sureBtn:@"确定" cancleBtn:nil];
            [alert showXLAlertView];
            alert.resultIndex = ^(NSInteger index) {
                KKLog(@"%ld",(long)index);
                if (index == 2) {
                    [[User UserOb] UserQuit];
                    LoginVC *Loginvc = [[LoginVC alloc] init];
                    AppDelegate *delegete = (AppDelegate *)[UIApplication sharedApplication].delegate;
                    UIViewController *vc = delegete.window.rootViewController;
                    delegete.window.rootViewController = Loginvc;
                    vc = nil;
//                    [self presentViewController:Loginvc animated:YES completion:NULL];
                }
            };
        }
        successBlock(responseObject);
    } failureBlock:^(NSError *error) {
        failureBlock(error);
        XLAlertView *alert = [[XLAlertView alloc] initWithMessage:@"网络错误" SuccessOrFailure:NO];
        [alert showPrompt];
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        progress(bytesProgress,totalBytesProgress);
    }];
    return sessionTask;
}


+ (void)fm_request_postWithUrlString:(NSString *)urlString
                                                isNeedCache:(BOOL)isNeedCache
                                                 parameters:(NSDictionary *)parameters
                                               successBlock:(FMRequestSuccess)successBlock
                                               failureBlock:(FMRequestFailure)failureBlock{
    /* Configure session, choose between:
     * defaultSessionConfiguration
     * ephemeralSessionConfiguration
     * backgroundSessionConfigurationWithIdentifier:
     And set session-wide properties, such as: HTTPAdditionalHeaders,
     HTTPCookieAcceptPolicy, requestCachePolicy or timeoutIntervalForRequest.
     */
    NSURLSessionConfiguration* sessionConfig = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    /* Create session, and optionally set a NSURLSessionDelegate. */
    NSURLSession* session = [NSURLSession sessionWithConfiguration:sessionConfig delegate:nil delegateQueue:nil];
    
    /* Create the Request:
     Request (POST https://echo.paw.cloud/)
     */
    
    NSURL* URL = [NSURL URLWithString:urlString];
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:URL];
    request.HTTPMethod = @"POST";
    // Headers
//    [FMNetworkHelper fm_setValue:[User UserOb].token forHTTPHeaderKey:@"token"];
//    [FMNetworkHelper fm_setValue:@"Mobile" forHTTPHeaderKey:@"loginType"];
    [request addValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [request addValue:[User UserOb].token forHTTPHeaderField:@"token"];
    [request addValue:@"Mobile" forHTTPHeaderField:@"loginType"];
    // JSON Body
    request.HTTPBody = [NSJSONSerialization dataWithJSONObject:parameters options:kNilOptions error:NULL];
    
    /* Start a new Task */
    NSURLSessionDataTask* task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error == nil) {
            // Success
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
            KKLog(@"%@",dict);
            NSLog(@"URL Session Task Succeeded: HTTP %ld", ((NSHTTPURLResponse*)response).statusCode);
            successBlock(response);
        }
        else {
            // Failure
            NSLog(@"URL Session Task Failed: %@", [error localizedDescription]);
        }
    }];
    [task resume];
    [session finishTasksAndInvalidate];
    
}
/**
 网络请求的实例方法 put
 
 @param urlString 请求的地址
 @param parameters 请求的参数
 @param successBlock 请求成功的回调
 @param failureBlock 请求失败的回调
 @param progress 进度
 @return BAURLSessionTask
 */
+ (__kindof NSURLSessionTask *)fm_request_putWithUrlString:(NSString *)urlString
           parameters:(NSDictionary *)parameters
         successBlock:(FMRequestSuccess)successBlock
         failureBlock:(FMRequestFailure)failureBlock
          progress:(FMDownloadProgress)progress {
    NSURLSessionTask *sessionTask = [BANetManager ba_request_PUTWithUrlString:urlString parameters:parameters successBlock:^(id response) {
        successBlock(response);
    } failureBlock:^(NSError *error) {
        failureBlock(error);
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        progress(bytesProgress,totalBytesProgress);
    }];
    return sessionTask;
}

/**
 网络请求的实例方法 delete
 
 @param urlString 请求的地址
 @param parameters 请求的参数
 @param successBlock 请求成功的回调
 @param failureBlock 请求失败的回调
 @param progress 进度
 @return BAURLSessionTask
 */
+ (__kindof NSURLSessionTask *)fm_request_deleteWithUrlString:(NSString *)urlString
                                          parameters:(NSDictionary *)parameters
                                        successBlock:(FMRequestSuccess)successBlock
                                        failureBlock:(FMRequestFailure)failureBlock
                                            progress:(FMDownloadProgress)progress {
    NSURLSessionTask *sessionTask = [BANetManager ba_request_DELETEWithUrlString:urlString parameters:parameters successBlock:^(id response) {
        successBlock(response);
    } failureBlock:^(NSError *error) {
        failureBlock(error);
    } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        progress(bytesProgress,totalBytesProgress);
    }];
    return sessionTask;
}


/**
 *  上传单/多张图片 (优先用此方法)
 *
 *  @param URL        请求地址
 *  @param parameters 请求参数
 *  @param name       图片对应服务器上的字段
 *  @param images     图片数组
 *  @param fileNames  图片文件名数组, 可以为nil, 数组内的文件名默认为当前日期时间"yyyyMMddHHmmss"
 *  @param imageScale 图片文件压缩比 范围 (0.f ~ 1.f)
 *  @param imageType  图片文件的类型,例:png、jpg(默认类型)....
 *  @param progress   上传进度信息
 *  @param success    请求成功的回调
 *  @param failure    请求失败的回调
 *
 *  @return 返回的对象可取消请求,调用cancel方法
 */
+ (__kindof NSURLSessionTask *)fm_uploadImagesWithUrlString:(NSString *)urlString
                                                 parameters:(id)parameters
                                                       name:(NSString *)name
                                                     images:(NSArray<UIImage *> *)images
                                                  fileNames:(NSArray<NSString *> *)fileNames
                                                 imageScale:(CGFloat)imageScale
                                                  imageType:(NSString *)imageType
                                                   progress:(FMUploadProgress)progress
                                                    success:(FMRequestSuccess)success
                                                    failure:(FMRequestFailure)failure {
    if (urlString == nil) {
        return nil;
    }
    
    /*! 检查地址中是否有中文 */
    NSString *URLString = [NSURL URLWithString:urlString] ? urlString : [self strUTF8Encoding:urlString];
    
    //创建网络请求管理对象
    AFHTTPSessionManager *sessionManager = [AFHTTPSessionManager manager];
    //申明返回的结果是json类型
    sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
    //申明请求的数据是json类型
    sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    //如果报接受类型不一致请替换一致text/html或别的
    sessionManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"text/json",@"text/xml",@"text/plain",@"application/json", nil];
    
    NSLog(@"******************** 请求参数 ***************************");
    NSLog(@"请求头: %@\n请求方式: %@\n请求URL: %@\n请求param: %@\n\n",sessionManager.requestSerializer.HTTPRequestHeaders, @"POST",URLString, parameters);
    NSLog(@"******************************************************");
    
    NSURLSessionTask *sessionTask = [sessionManager POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        for (NSUInteger i = 0; i < images.count; i++) {
            // 图片经过等比压缩后得到的二进制文件
            NSData *imageData = UIImageJPEGRepresentation(images[i], imageScale ?: 1.f);
            // 默认图片的文件名, 若fileNames为nil就使用
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat = @"yyyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *imageFileName = [NSString stringWithFormat:@"%@%ld.%@",str,(unsigned long)i,imageType?:@"jpg"];
            
            [formData appendPartWithFileData:imageData
                                        name:name
                                    fileName:fileNames ? [NSString stringWithFormat:@"%@.%@",fileNames[i],imageType?:@"jpg"]: imageFileName
                                    mimeType:[NSString stringWithFormat:@"image/%@",imageType ?: @"jpg"]];
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        //上传进度
        dispatch_sync(dispatch_get_main_queue(), ^{
            progress ? progress(uploadProgress.completedUnitCount, uploadProgress.totalUnitCount) : nil;
        });
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"上传图片成功 = %@",responseObject);
        success ? success(responseObject) : nil;
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure ? failure(error) : nil;
    }];
    
    return sessionTask;
}


/**
 上传图片(多图) （不建议用此方法）
 
 @param urlString 上传的url
 @param parameters 上传图片预留参数---视具体情况而定 可移除
 @param imageArray 上传的图片数组
 @param fileName 上传的图片数组fileName
 @param successBlock 上传成功的回调
 @param failureBlock 上传失败的回调
 @param progress 上传进度
 @return BAURLSessionTask
 */
+ (__kindof NSURLSessionTask *)fm_uploadImageWithUrlString:(NSString *)urlString
                                       parameters:(NSDictionary *)parameters
                                       imageArray:(NSArray *)imageArray
                                         fileName:(NSString *)fileName
                                     successBlock:(FMRequestSuccess)successBlock
                                      failurBlock:(FMRequestFailure)failureBlock
                                            upLoadProgress:(FMUploadProgress)progress {
    NSURLSessionTask *sessionTask = [BANetManager ba_uploadImageWithUrlString:urlString parameters:parameters imageArray:imageArray fileName:fileName successBlock:^(id response) {
        successBlock(response);
    } failurBlock:^(NSError *error) {
        failureBlock(error);
    } upLoadProgress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        progress(bytesProgress,totalBytesProgress);
    }];
    return  sessionTask;
    
}


/**
 视频上传
 
 @param urlString 上传的url
 @param parameters 上传视频预留参数---视具体情况而定 可移除
 @param videoPath 上传视频的本地沙河路径
 @param successBlock 成功的回调
 @param failureBlock 失败的回调
 @param progress 上传的进度
 */
+ (void)fm_uploadVideoWithUrlString:(NSString *)urlString
                         parameters:(NSDictionary *)parameters
                          videoPath:(NSString *)videoPath
                       successBlock:(FMRequestSuccess)successBlock
                       failureBlock:(FMRequestFailure)failureBlock
                     uploadProgress:(FMUploadProgress)progress {
    [BANetManager ba_uploadVideoWithUrlString:urlString parameters:parameters videoPath:videoPath successBlock:^(id response) {
        successBlock(response);
    } failureBlock:^(NSError *error) {
        failureBlock(error);
    } uploadProgress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        progress(bytesProgress,totalBytesProgress);
    }];
}

/**
 文件下载
 
 @param urlString 请求的url
 @param parameters 文件下载预留参数---视具体情况而定 可移除
 @param savePath 下载文件保存路径
 @param successBlock 下载文件成功的回调
 @param failureBlock 下载文件失败的回调
 @param progress 下载文件的进度显示
 @return BAURLSessionTask
 */
+ (__kindof NSURLSessionTask *)ba_downLoadFileWithUrlString:(NSString *)urlString
                                        parameters:(NSDictionary *)parameters
                                          savaPath:(NSString *)savePath
                                      successBlock:(FMRequestSuccess)successBlock
                                      failureBlock:(FMRequestFailure)failureBlock
                                           downLoadProgress:(FMDownloadProgress)progress {
    NSURLSessionTask *sessionTask = [BANetManager ba_downLoadFileWithUrlString:urlString parameters:parameters savaPath:savePath successBlock:^(id response) {
        successBlock(response);
    } failureBlock:^(NSError *error) {
        failureBlock(error);
    } downLoadProgress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
        progress(bytesProgress,totalBytesProgress);
    }];
    return sessionTask;
}

#pragma mark - 网络状态监测
/*!
 *  开启实时网络状态监测，通过Block回调实时获取(此方法可多次调用)
 */
+ (void)fm_startNetWorkMonitoringWithBlock:(BANetworkStatusBlock)networkStatus {
    [BANetManager ba_startNetWorkMonitoringWithBlock:networkStatus];
}

#pragma mark - 自定义请求头
/**
 *  自定义请求头
 */
+ (void)fm_setValue:(NSString *)value forHTTPHeaderKey:(NSString *)HTTPHeaderKey {
    [BANetManager ba_setValue:value forHTTPHeaderKey:HTTPHeaderKey];
}

#pragma mark - 取消 Http 请求
/*!
 *  取消所有 Http 请求
 */
+ (void)fm_cancelAllRequest {
    [BANetManager ba_cancelAllRequest];
}

/*!
 *  取消指定 URL 的 Http 请求
 */
+ (void)fm_cancelRequestWithURL:(NSString *)URL {
    [BANetManager ba_cancelRequestWithURL:URL];
}

#pragma mark - url 中文格式化
+ (NSString *)strUTF8Encoding:(NSString *)str
{
    /*! ios9适配的话 打开第一个 */
    if ([[UIDevice currentDevice] systemVersion].floatValue >= 9.0)
    {
        return [str stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]];
    }
    else
    {
        return [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    }
}
+ (UIImage*)imageWithImage:(UIImage*)image
              scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext( newSize );
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

#pragma mark - 请求404token失效提示去登录
+ (void)fm_request404ShowLogin:(id)responseObject {
    [[User UserOb] UserQuit];
    UINavigationController *nav = [FMHelper fm_getCurrentNav];
    [FMHelper fm_showLoginAlertWithController:nav.visibleViewController tipsStringIfNilShowDefault:kResponseObjectMessage];
}


@end
