//
//  FMNetworkHelper.h
//  MobileProject
//
//  Created by Mingo on 2017/7/9.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BANetManager.h>

/// 请求成功的block
typedef void(^FMRequestSuccess)(id responseObject);

/// 请求失败的block
typedef void(^FMRequestFailure)(NSError *error);

/*! 进度  */
typedef void (^FMProgress)(NSProgress *progress);

/*! 定义上传进度 block */
typedef void( ^ FMUploadProgress)(int64_t bytesProgress,
                                  int64_t totalBytesProgress);
/*! 定义下载进度 block */
typedef void( ^ FMDownloadProgress)(int64_t bytesProgress,
                                    int64_t totalBytesProgress);

@interface FMNetworkHelper : NSObject

#pragma mark - 网络请求的类方法 --- get / post / put / delete
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
                                                  progress:(FMDownloadProgress)progress;

#pragma mark - 网络请求的类方法 --- post
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
                                                   progress:(FMDownloadProgress)progress;


+ (void)fm_request_postWithUrlString:(NSString *)urlString
                                                isNeedCache:(BOOL)isNeedCache
                                                 parameters:(NSDictionary *)parameters
                                               successBlock:(FMRequestSuccess)successBlock
                                               failureBlock:(FMRequestFailure)failureBlock;



#pragma mark - 网络请求的类方法 --- put
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
                                                  progress:(FMDownloadProgress)progress;
#pragma mark - 网络请求的类方法 --- delete
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
                                                     progress:(FMDownloadProgress)progress;

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
                                                    failure:(FMRequestFailure)failure;

#pragma mark - 网络请求的类方法 --- 上传图片(多图)
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
                                            upLoadProgress:(FMUploadProgress)progress;
#pragma mark - 网络请求的类方法 --- 视频上传
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
                     uploadProgress:(FMUploadProgress)progress;

#pragma mark - 网络请求的类方法 --- 文件下载
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
                                           downLoadProgress:(FMDownloadProgress)progress;

#pragma mark - 网络状态监测
/*!
 *  开启实时网络状态监测，通过Block回调实时获取(此方法可多次调用)
 */
+ (void)fm_startNetWorkMonitoringWithBlock:(BANetworkStatusBlock)networkStatus;

#pragma mark - 自定义请求头
/**
 *  自定义请求头
 */
+ (void)fm_setValue:(NSString *)value forHTTPHeaderKey:(NSString *)HTTPHeaderKey;

#pragma mark - 取消 Http 请求
/*!
 *  取消所有 Http 请求
 */
+ (void)fm_cancelAllRequest;

/*!
 *  取消指定 URL 的 Http 请求
 */
+ (void)fm_cancelRequestWithURL:(NSString *)URL;

@end
