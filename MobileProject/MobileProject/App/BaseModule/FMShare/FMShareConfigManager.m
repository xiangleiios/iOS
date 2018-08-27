//
//  FMShareConfigManager.m
//  MobileProject
//
//  Created by Mingoy on 16/10/8.
//  Copyright © 2016年 Mingoy. All rights reserved.
//

#import "FMShareConfigManager.h"

@implementation FMShareConfigManager

+ (FMShareConfigManager *)sharedInstance
{
    static FMShareConfigManager* instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [FMShareConfigManager new];
    });
    return instance;
}

- (void)setPlaform:(FMSocialPlatConfigType)platformType
            appKey:(NSString *)appKey
         appSecret:(NSString *)appSecret
       redirectURL:(NSString *)redirectURL
{
    switch (platformType) {
        case FMSocialPlatConfigType_Sina:
            self.fmSocialPlatConfigType_Sina_AppKey=appKey;
            self.fmSocialPlatConfigType_Sina_AppSecret=appSecret;
            self.fmSocialPlatConfigType_Sina_RedirectURL=redirectURL;
            break;
        case FMSocialPlatConfigType_Wechat:
            self.fmSocialPlatConfigType_Wechat_AppKey=appKey;
            self.fmSocialPlatConfigType_Wechat_AppSecret=appSecret;
            self.fmSocialPlatConfigType_Wechat_RedirectURL=redirectURL;
            break;
        case FMSocialPlatConfigType_Tencent:
            self.fmSocialPlatConfigType_Tencent_AppKey=appKey;
            self.fmSocialPlatConfigType_Tencent_AppSecret=appSecret;
            self.fmSocialPlatConfigType_Tencent_RedirectURL=redirectURL;
            break;
        default:
            break;
    }
}

@end
