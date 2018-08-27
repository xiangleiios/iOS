//
//  QFDownloadManager.h
//
//  QFPlayer
//


#import <UIKit/UIKit.h>
#import "QFSessionModel.h"

// 缓存主目录
#define QFCachesDirectory [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]stringByAppendingPathComponent:@"ZFCache"]

// 保存文件名
#define QFFileName(url)  [[url componentsSeparatedByString:@"/"] lastObject]

// 文件的存放路径（caches）
#define QFFileFullpath(url) [QFCachesDirectory stringByAppendingPathComponent:QFFileName(url)]

// 文件的已下载长度
#define QFDownloadLength(url) [[[NSFileManager defaultManager] attributesOfItemAtPath:QFFileFullpath(url) error:nil][NSFileSize] integerValue]

// 存储文件信息的路径（caches）
#define QFDownloadDetailPath [QFCachesDirectory stringByAppendingPathComponent:@"downloadDetail.data"]

@protocol QFDownloadDelegate <NSObject>
/** 下载中的回调 */
- (void)downloadResponse:(QFSessionModel *)sessionModel;

@end

@interface QFDownloadManager : NSObject

/** 保存所有下载相关信息字典 */
@property (nonatomic, strong, readonly) NSMutableDictionary *sessionModels;
/** 所有本地存储的所有下载信息数据数组 */
@property (nonatomic, strong, readonly) NSMutableArray *sessionModelsArray;
/** 下载完成的模型数组*/
@property (nonatomic, strong, readonly) NSMutableArray *downloadedArray;
/** 下载中的模型数组*/
@property (nonatomic, strong, readonly) NSMutableArray *downloadingArray;
/** ZFDownloadDelegate */
@property (nonatomic, assign) id<QFDownloadDelegate> delegate;

/**
 *  单例
 *
 *  @return 返回单例对象
 */
+ (instancetype)sharedInstance;

/**
 * 归档
 */
- (void)save:(NSArray *)sessionModels;

/**
 * 读取model
 */
- (NSArray *)getSessionModels;

/**
 *  开启任务下载资源
 *
 *  @param url           下载地址
 *  @param progressBlock 回调下载进度
 *  @param stateBlock    下载状态
 */
- (void)download:(NSString *)url progress:(QFDownloadProgressBlock)progressBlock state:(QFDownloadStateBlock)stateBlock;

/**
 *  查询该资源的下载进度值
 *
 *  @param url 下载地址
 *
 *  @return 返回下载进度值
 */
- (CGFloat)progress:(NSString *)url;

/**
 *  获取该资源总大小
 *
 *  @param url 下载地址
 *
 *  @return 资源总大小
 */
- (NSInteger)fileTotalLength:(NSString *)url;

/**
 *  判断该资源是否下载完成
 *
 *  @param url 下载地址
 *
 *  @return YES: 完成
 */
- (BOOL)isCompletion:(NSString *)url;

/**
 *  删除该资源
 *
 *  @param url 下载地址
 */
- (void)deleteFile:(NSString *)url;

/**
 *  清空所有下载资源
 */
- (void)deleteAllFile;

/**
 *  开始下载
 */
- (void)start:(NSString *)url;

/**
 *  暂停下载
 */
- (void)pause:(NSString *)url;

/**
 *  判断当前url是否正在下载
 *
 *  @param url   视频url
 *  @param block 下载进度
 *
 *  @return 是否在下载
 */
- (BOOL)isFileDownloadingForUrl:(NSString *)url withProgressBlock:(QFDownloadProgressBlock)block;

/**
 *  正在下载的视频URL的数组
 *
 *  @return 视频URL的数组
 */
- (NSArray *)currentDownloads;

@end
