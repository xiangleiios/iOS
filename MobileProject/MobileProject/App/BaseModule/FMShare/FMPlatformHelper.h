//
//  FMPlatformHelper.h
//  MobileProject 第三方登录 跟 登录后用户信息的获取
//
//  Created by Mingoy on 16/10/10.
//  Copyright © 2016年 Mingoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMShareConfigManager.h"
#import <UMSocialCore/UMSocialCore.h>

/**
 授权

 @param uid         授权成功获得uid
 @param uid         授权成功获得openid QQ，微信用户openid，其他平台没有
 @param accessToken 授权成功获得accessToken
 @param error       error
 */
typedef void (^FMSocialAuthCompletionHandler)(NSString *uid,NSString *openid,NSString *accessToken,NSError *error);


/**
 取消授权

 @param result 结果
 @param error  error
 */
typedef void (^FMCancelSocialAuthCompletionHandler)(id result,NSError *error);


/**
 获得用户

 @param name    用户名称
 @param iconUrl 头像URL
 @param gender  性别 （m表示男，w表示女）
 @param error   error
 */
typedef void (^FMSocialGetUserInfoCompletionHandler)(UMSocialUserInfoResponse *userinfo,NSString *name,NSString *iconUrl,NSString *gender,NSError *error);



@interface FMPlatformHelper : NSObject


@property (nonatomic, copy) FMSocialAuthCompletionHandler socialAuthCompletionBlock;
@property (nonatomic, copy) FMCancelSocialAuthCompletionHandler cancelSocialAuthCompletionBlock;
@property (nonatomic, copy) FMSocialGetUserInfoCompletionHandler socialGetUserInfoCompletionBlock;

/**
 判断当前手机是否有安装相应的APP
 
 @param platformType 平台类型
 
 @return YES 有安装 NO 未安装
 */
+(BOOL)installPlatAppWithType:(FMSocialPlatformType)platformType;


/**
 授权

 @param platformType 平台类型
 */
+(void)authWithPlatform:(FMSocialPlatformType)platformType withCompletion:(FMSocialAuthCompletionHandler)completionHandler;


/**
 取消授权

 @param platformType 平台类型
 */
+(void)cancelAuthWithPlatform:(FMSocialPlatformType)platformType withCompletion:(FMCancelSocialAuthCompletionHandler)completionHandler;


/**
 获得用户信息

 @param platformType 平台类型
 */
+(void)getUserInfoWithPlatform:(FMSocialPlatformType)platformType withCompletion:(FMSocialGetUserInfoCompletionHandler)completionHandler;

@end
