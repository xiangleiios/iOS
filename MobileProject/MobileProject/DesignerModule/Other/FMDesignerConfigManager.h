//
//  jiaConfigManager.h
//  MobileProject 关于模块中一些配置文件
//
//  Created by Mingoy on 16/9/20.
//  Copyright © 2016年 Mingoy. All rights reserved.
//

#import <Foundation/Foundation.h>

#define FMDesignerConfigManagerInstance [FMDesignerConfigManager sharedInstance]

@interface FMDesignerConfigManager : NSObject

+ (FMDesignerConfigManager *)sharedInstance;

//网络请求前缀
@property (strong, nonatomic) NSString *prefixNetWorkUrl;

@end
