//
//  FMPlatformHelper.m
//  MobileProject
//
//  Created by Mingoy on 16/10/10.
//  Copyright © 2016年 Mingoy. All rights reserved.
//

#import "FMPlatformHelper.h"
#import "FMShareTool.h"
#import <UMSocialCore/UMSocialCore.h>

@implementation FMPlatformHelper

+(BOOL)installPlatAppWithType:(FMSocialPlatformType)platformType
{
    BOOL result=NO;
    
    result=[[UMSocialManager defaultManager] isInstall:[FMShareTool getUMSocialPlatformFMPlatformType:platformType]];
    
    return result;
}


/**
 授权
 
 @param platformType 平台类型
 */
+(void)authWithPlatform:(FMSocialPlatformType)platformType withCompletion:(FMSocialAuthCompletionHandler)completionHandler
{
    [[UMSocialManager defaultManager] authWithPlatform:[FMShareTool getUMSocialPlatformFMPlatformType:platformType] currentViewController:nil completion:^(id result, NSError *error) {
        UMSocialAuthResponse *authresponse=result;
        completionHandler(authresponse.uid,authresponse.openid,authresponse.accessToken,error);
    }];
}


/**
 取消授权
 
 @param platformType 平台类型
 */
+(void)cancelAuthWithPlatform:(FMSocialPlatformType)platformType withCompletion:(FMCancelSocialAuthCompletionHandler)completionHandler
{
    [[UMSocialManager defaultManager] cancelAuthWithPlatform:[FMShareTool getUMSocialPlatformFMPlatformType:platformType] completion:^(id result, NSError *error) {
        completionHandler(result,error);
    }];
}


/**
 获得用户信息
 
 @param platformType 平台类型
 */
+(void)getUserInfoWithPlatform:(FMSocialPlatformType)platformType withCompletion:(FMSocialGetUserInfoCompletionHandler)completionHandler
{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:[FMShareTool getUMSocialPlatformFMPlatformType:platformType] currentViewController:nil completion:^(id result, NSError *error) {
        UMSocialUserInfoResponse *userinfo =result;
        completionHandler(userinfo,userinfo.name,userinfo.iconurl,userinfo.gender,error);
    }];
}

@end
