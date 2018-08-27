//
//  FMShareHelper.m
//  MobileProject
//
//  Created by Mingoy on 16/10/9.
//  Copyright © 2016年 Mingoy. All rights reserved.
//

#import "FMShareHelper.h"
#import <UMSocialCore/UMSocialCore.h>
#import "FMShareTool.h"


@interface FMShareHelper()

@end

@implementation FMShareHelper

+ (void)shareTextDataWithPlatform:(FMSocialPlatformType)platformType withTextData:(NSString *)textData withCompletion:(FMSocialShareCompletionHandler)completionHandler
{
    UMSocialPlatformType umPlatFormType=[FMShareTool getUMSocialPlatformFMPlatformType:platformType];
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    messageObject.text=textData;
    
    //友盟分享
    [[UMSocialManager defaultManager] shareToPlatform:umPlatFormType messageObject:messageObject currentViewController:nil completion:^(id result, NSError *error) {
        completionHandler(result,error);
    }];
}

+ (void)shareUrlDataWithPlatform:(FMSocialPlatformType)platformType withShareUrl:(NSString *)shareUrl withTitle:(NSString *)title withDescr:(NSString *)descr withThumImage:(id)thumImage withCompletion:(FMSocialShareCompletionHandler)completionHandler
{
    UMSocialPlatformType umPlatFormType=[FMShareTool getUMSocialPlatformFMPlatformType:platformType];
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:title descr:descr thumImage:thumImage];
    [shareObject setWebpageUrl:shareUrl];
    messageObject.shareObject = shareObject;
    
    //友盟分享
    [[UMSocialManager defaultManager] shareToPlatform:umPlatFormType messageObject:messageObject currentViewController:nil completion:^(id result, NSError *error) {
        completionHandler(result,error);
    }];
}

+ (void)shareImageTextDataWithPlatform:(FMSocialPlatformType)platformType withShareImage:(id)shareImage withTitle:(NSString *)title withDescr:(NSString *)descr withThumImage:(id)thumImage withCompletion:(FMSocialShareCompletionHandler)completionHandler
{
    UMSocialPlatformType umPlatFormType=[FMShareTool getUMSocialPlatformFMPlatformType:platformType];
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    UMShareImageObject *shareObject = [UMShareImageObject shareObjectWithTitle:title descr:descr thumImage:thumImage];
    [shareObject setShareImage:shareImage];
    messageObject.shareObject = shareObject;
    
    //友盟分享
    [[UMSocialManager defaultManager] shareToPlatform:umPlatFormType messageObject:messageObject currentViewController:nil completion:^(id result, NSError *error) {
        completionHandler(result,error);
    }];
}

+ (void)shareVideoDataWithPlatform:(FMSocialPlatformType)platformType withShareVideoUrl:(NSString *)shareVideoUrl withTitle:(NSString *)title withDescr:(NSString *)descr withThumImage:(id)thumImage withCompletion:(FMSocialShareCompletionHandler)completionHandler
{
    UMSocialPlatformType umPlatFormType=[FMShareTool getUMSocialPlatformFMPlatformType:platformType];
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    UMShareVideoObject *shareObject = [UMShareVideoObject shareObjectWithTitle:title descr:descr thumImage:thumImage];
    [shareObject setVideoUrl:shareVideoUrl];
    messageObject.shareObject = shareObject;
    
    //友盟分享
    [[UMSocialManager defaultManager] shareToPlatform:umPlatFormType messageObject:messageObject currentViewController:nil completion:^(id result, NSError *error) {
        completionHandler(result,error);
    }];
}

+ (void)shareMusicDataWithPlatform:(FMSocialPlatformType)platformType withShareMusicUrl:(NSString *)shareMusicUrl withTitle:(NSString *)title withDescr:(NSString *)descr withThumImage:(id)thumImage withCompletion:(FMSocialShareCompletionHandler)completionHandler
{
    UMSocialPlatformType umPlatFormType=[FMShareTool getUMSocialPlatformFMPlatformType:platformType];
    
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    UMShareMusicObject *shareObject = [UMShareMusicObject shareObjectWithTitle:title descr:descr thumImage:thumImage];
    [shareObject setMusicUrl:shareMusicUrl];
    messageObject.shareObject = shareObject;
    
    //友盟分享
    [[UMSocialManager defaultManager] shareToPlatform:umPlatFormType messageObject:messageObject currentViewController:nil completion:^(id result, NSError *error) {
        completionHandler(result,error);
    }];
}

@end
