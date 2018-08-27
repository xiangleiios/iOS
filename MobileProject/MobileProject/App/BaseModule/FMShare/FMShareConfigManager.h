//
//  FMShareConfigManager.h
//  MobileProject
//
//  Created by Mingoy on 16/10/8.
//  Copyright © 2016年 Mingoy. All rights reserved.
//

#import <Foundation/Foundation.h>

#define FMShareConfigManagerInstance [FMShareConfigManager sharedInstance]

//配置类型 目前只支持新浪、微信、腾讯
typedef NS_ENUM(NSInteger,FMSocialPlatConfigType)
{
    FMSocialPlatConfigType_Sina,        //新浪
    FMSocialPlatConfigType_Wechat,      //微信
    FMSocialPlatConfigType_Tencent,     //腾讯
};


//平台类型 目前只支持新浪、微信聊天、微信朋友圈、QQ聊天页面、qq空间、腾讯微博
typedef NS_ENUM(NSInteger,FMSocialPlatformType)
{
    FMSocialPlatformType__UnKnown,      //未指定
    FMSocialPlatformType_Sina,          //新浪
    FMSocialPlatformType_WechatSession, //微信聊天
    FMSocialPlatformType_WechatTimeLine,//微信朋友圈
    FMSocialPlatformType_QQ,            //QQ聊天页面
    FMSocialPlatformType_Qzone,         //qq空间
    FMSocialPlatformType_TencentWb,     //腾讯微博
};

@interface FMShareConfigManager : NSObject

//友盟分享配置 友盟key,是否开启SDK调试
@property (strong, nonatomic) NSString *shareAppKey;
@property (nonatomic,getter=isLogEnabled) BOOL shareLogEnabled;

//其它配置 分享成功跟失败的提示语
@property (strong, nonatomic) NSString *shareSuccessMessage;
@property (strong, nonatomic) NSString *shareFailMessage;

//设置新浪
@property (strong, nonatomic) NSString *fmSocialPlatConfigType_Sina_AppKey;
@property (strong, nonatomic) NSString *fmSocialPlatConfigType_Sina_AppSecret;
@property (strong, nonatomic) NSString *fmSocialPlatConfigType_Sina_RedirectURL;

//设置微信
@property (strong, nonatomic) NSString *fmSocialPlatConfigType_Wechat_AppKey;
@property (strong, nonatomic) NSString *fmSocialPlatConfigType_Wechat_AppSecret;
@property (strong, nonatomic) NSString *fmSocialPlatConfigType_Wechat_RedirectURL;

//设置腾讯
@property (strong, nonatomic) NSString *fmSocialPlatConfigType_Tencent_AppKey;
@property (strong, nonatomic) NSString *fmSocialPlatConfigType_Tencent_AppSecret;
@property (strong, nonatomic) NSString *fmSocialPlatConfigType_Tencent_RedirectURL;

+ (FMShareConfigManager *)sharedInstance;


/**
 设置平台配置内容

 @param platformType 平台类型
 @param appKey       appKey
 @param appSecret    appSecret
 @param redirectURL  redirectURL
 */
- (void)setPlaform:(FMSocialPlatConfigType)platformType
            appKey:(NSString *)appKey
         appSecret:(NSString *)appSecret
       redirectURL:(NSString *)redirectURL;

@end
