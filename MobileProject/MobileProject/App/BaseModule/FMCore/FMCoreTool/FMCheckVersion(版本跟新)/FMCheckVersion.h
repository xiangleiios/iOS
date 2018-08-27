//
//  FMCheckVersion.h
//  MobileProject
//
//  Created by Mingo on 2017/9/19.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APPInfoModel : NSObject

@property (nonatomic, copy)     NSString *idid;
@property (nonatomic, copy)     NSString *android_url;
@property (nonatomic, assign)   NSInteger android_force;
@property (nonatomic, copy)     NSString *ios_url;
@property (nonatomic, copy)     NSString *logo_url;
@property (nonatomic, copy)     NSString *ios_version;
@property (nonatomic, copy)     NSString *android_version;
@property (nonatomic, copy)     NSString *name;
@property (nonatomic, copy)     NSString *sandbox;
@property (nonatomic, assign)   NSInteger ios_force;

@end

@interface FMCheckVersion : NSObject
/// 获取APP信息 [检测更新]
+ (void)fm_getAppsInfoAndCheckUpdata;
@end

