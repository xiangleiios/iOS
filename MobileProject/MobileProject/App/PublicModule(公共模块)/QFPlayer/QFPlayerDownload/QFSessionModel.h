//
//  QFNSURLSession.h
//
//  QFPlayer
//


#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DownloadState){
    DownloadStateStart = 0,     /** 下载中 */
    DownloadStateSuspended,     /** 下载暂停 */
    DownloadStateCompleted,     /** 下载完成 */
    DownloadStateFailed         /** 下载失败 */
};

typedef void(^QFDownloadProgressBlock)(CGFloat progress, NSString *speed, NSString *remainingTime, NSString *writtenSize, NSString *totalSize);
typedef void(^QFDownloadStateBlock)(DownloadState state);

@interface QFSessionModel : NSObject <NSCoding>

/** 流 */
@property (nonatomic, strong) NSOutputStream *stream;

/** 下载地址 */
@property (nonatomic, copy) NSString *url;
/** 开始下载时间 */
@property (nonatomic, strong) NSDate *startTime;
/** 文件名 */
@property (nonatomic, copy) NSString *fileName;
/** 文件大小 */
@property (nonatomic, copy) NSString *totalSize;

/** 获得服务器这次请求 返回数据的总长度 */
@property (nonatomic, assign) NSInteger totalLength;

/** 下载进度 */
@property (nonatomic, copy) QFDownloadProgressBlock progressBlock;

/** 下载状态 */
@property (nonatomic, copy) QFDownloadStateBlock stateBlock;

- (float)calculateFileSizeInUnit:(unsigned long long)contentLength;

- (NSString *)calculateUnit:(unsigned long long)contentLength;
@end
