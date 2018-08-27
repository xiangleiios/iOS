//
//  FMWebShareHelper.m
//  MobileProject
//
//  Created by Mingoy on 16/10/9.
//  Copyright © 2016年 Mingoy. All rights reserved.
//

#import "FMWebShareHelper.h"
#import "FMShareHelper.h"
#import "FMShareConfigManager.h"

@implementation FMWebShareHelper

- (void)shareText:(NSString *)platformType withText:(NSString *)text
{
    //要在主线程进行
    dispatch_async(dispatch_get_main_queue(), ^{
        [FMShareHelper shareTextDataWithPlatform:[self getPlatformType:platformType] withTextData:text withCompletion:^(id result, NSError *error) {
            [self shareResultShow:error];
        }];
    });
}

- (void)shareUrl:(NSString *)platformType withShareUrl:(NSString *)shareUrl withTitle:(NSString *)title withDescr:(NSString *)descr withThumImageUrl:(NSString *)thumImageUrl
{
    //要在主线程进行
    dispatch_async(dispatch_get_main_queue(), ^{
        [FMShareHelper shareUrlDataWithPlatform:[self getPlatformType:platformType] withShareUrl:shareUrl withTitle:title withDescr:descr withThumImage:thumImageUrl withCompletion:^(id result, NSError *error) {
            [self shareResultShow:error];
        }];
    });
}

- (void)shareImageText:(NSString *)platformType withShareImageUrl:(NSString *)shareImageUrl withTitle:(NSString *)title withDescr:(NSString *)descr withThumImageUrl:(NSString *)thumImageUrl
{
    //要在主线程进行
    dispatch_async(dispatch_get_main_queue(), ^{
        [FMShareHelper shareImageTextDataWithPlatform:[self getPlatformType:platformType] withShareImage:shareImageUrl withTitle:title withDescr:descr withThumImage:thumImageUrl withCompletion:^(id result, NSError *error) {
            [self shareResultShow:error];
        }];
    });
}

/**
 转换类型

 @param platformType 平台字符串sina（新浪微博）wechatsession（微信好友）wechattimeline（微信朋友圈）tencentwb（腾讯微博）qzone(QQ空间) qq（QQ）

 @return JIA平台类型 
 */
- (FMSocialPlatformType)getPlatformType:(NSString *)platformType
{
    FMSocialPlatformType fmPlatformType=FMSocialPlatformType__UnKnown;
    if ([platformType isEqualToString:@"sina"]) {
        fmPlatformType=FMSocialPlatformType_Sina;
    }
    else if ([platformType isEqualToString:@"wechatsession"])
    {
        fmPlatformType=FMSocialPlatformType_WechatSession;
    }
    else if ([platformType isEqualToString:@"tencentwb"])
    {
        fmPlatformType=FMSocialPlatformType_TencentWb;
    }
    else if ([platformType isEqualToString:@"wechattimeline"])
    {
        fmPlatformType=FMSocialPlatformType_WechatTimeLine;
    }
    else if ([platformType isEqualToString:@"qzone"])
    {
        fmPlatformType=FMSocialPlatformType_Qzone;
    }
    else if ([platformType isEqualToString:@"qq"])
    {
        fmPlatformType=FMSocialPlatformType_QQ;
    }
    else
    {
        NSLog(@"分享指定的类型不存在，请检查平台类型字符串是否正确");
    }
    return fmPlatformType;
}

- (void)shareResultShow:(NSError *)error
{
    if(error)
    {
        NSLog(@"分享失败了");
        return;
    }
    NSString *alertMessage=FMShareConfigManagerInstance.shareSuccessMessage?:@"分享成功";
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:alertMessage delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
    [alert show];
}
@end
