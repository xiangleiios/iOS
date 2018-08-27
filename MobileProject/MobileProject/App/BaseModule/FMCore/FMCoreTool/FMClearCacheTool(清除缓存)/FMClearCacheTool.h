//
//  FMClearCacheTool.h
//  MobileProject
//
//  Created by Mingo on 2017/8/14.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FMClearCacheTool : NSObject

/*s*
 *  获取path路径下文件夹的大小
 *  @param path 要获取的文件夹 路径
 *  @return 返回path路径下文件夹的大小
 */
+ (NSString *)fm_getCacheSizeWithFilePath:(NSString *)path;

/*s*
 *  获取path路径下文件夹的大小
 *  @param path 要获取的文件夹 路径
 *  @return 返回path路径下文件夹的大小
 */
+ (CGFloat)fm_getCacheCGFloatSizeWithFilePath:(NSString *)path;

/**
 *  清除path路径下文件夹的缓存
 *  @param path  要清除缓存的文件夹 路径
 *  @return 是否清除成功
 */
+ (BOOL)fm_clearCacheWithFilePath:(NSString *)path;

@end
