  //
//  AppDelegate+ShareIntent.m
//  MobileProject
//
//  Created by 刘世玉 on 2017/4/20.
//  Copyright © 2017年 Mingoy. All rights reserved.
//

#import "AppDelegate+ShareIntent.h"
#import "XAspect.h"
#import <UMSocialCore/UMSocialCore.h>
#import "FMShareConfigManager.h"
#import "DHGuidePageHUD.h"
#import "ModelGuaideIma.h"
#import "WXApi.h"
#import "ThirdPartKeys.h"
#import "UMMobClick/MobClick.h"
// 引 JPush功能所需头 件
#import "JPUSHService.h"

@implementation AppDelegate (ShareIntent)
+ (void)registeredUMSocialSDKtoApp {
    
    //打开日志
    if(FMShareConfigManagerInstance.isLogEnabled) {
        [[UMSocialManager defaultManager] openLog:YES];
    }
        //设置友盟appkey
    [[UMSocialManager defaultManager] setUmSocialAppkey:keyUMengAppkey];
    UMConfigInstance.appKey = keyUMengAppkey;
    UMConfigInstance.channelId = @"App Store";
//    UMConfigInstance.eSType = E_UM_GAME; //仅适用于游戏场景，应用统计不用设置
    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
    //各平台的详细配置
    [WXApi registerApp:keyWeChatAppID];
    [FMShareConfigManagerInstance setPlaform:FMSocialPlatConfigType_Wechat appKey:keyWeChatAppID appSecret:keyWeChatAppSecret redirectURL:@"http://mobile.umeng.com/social"];
    NSLog(@"分享-微信平台已经配置");
    //设置微信的appId和appKey
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:FMShareConfigManagerInstance.fmSocialPlatConfigType_Wechat_AppKey appSecret:FMShareConfigManagerInstance.fmSocialPlatConfigType_Wechat_AppSecret redirectURL:FMShareConfigManagerInstance.fmSocialPlatConfigType_Wechat_RedirectURL];

    [FMShareConfigManagerInstance setPlaform:FMSocialPlatConfigType_Tencent appKey:keyQQAPPID appSecret:keyQQAPPKEY redirectURL:@"http://mobile.umeng.com/social"];
    NSLog(@"分享-腾讯平台已经配置");
    //设置分享到QQ互联的appId和appKey
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:FMShareConfigManagerInstance.fmSocialPlatConfigType_Tencent_AppKey  appSecret:FMShareConfigManagerInstance.fmSocialPlatConfigType_Tencent_AppSecret redirectURL:FMShareConfigManagerInstance.fmSocialPlatConfigType_Tencent_RedirectURL];

//    [FMShareConfigManagerInstance setPlaform:FMSocialPlatConfigType_Sina appKey:@"4000871590" appSecret:@"67c963a59dc8dfcae5b76eff6769bb2f" redirectURL:@"http://sns.whalecloud.com/sina2/callback"];
//    NSLog(@"分享-新浪平台已经配置");
//    //设置新浪的appId和appKey
//    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:FMShareConfigManagerInstance.fmSocialPlatConfigType_Sina_AppKey  appSecret:FMShareConfigManagerInstance.fmSocialPlatConfigType_Sina_AppSecret redirectURL:FMShareConfigManagerInstance.fmSocialPlatConfigType_Sina_RedirectURL];
}

#pragma mark - 加载广告
- (void)getGuideFigure {
    
    NSString *url= GETcontentsListAdvertisement;
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/json", @"text/xml",@"text/plain", @"application/json", nil];
    [manager GET:url parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        switch ([responseObject[@"status_code"] integerValue]) {
            case 200:{
                NSArray *guideFigure = responseObject[@"data"];
                NSArray *imageNameArray ;
                
                if (guideFigure.count) {
                    NSMutableArray *add = [NSMutableArray array];
                    for (NSDictionary *dic in guideFigure) {
                        ModelGuaideIma *model = [[ModelGuaideIma alloc] initWithDictionary:dic];
                        [add addObject:model];
                    }
                    
                    imageNameArray = add;
                    [FMSingle shareSingle].is1ShowNilGuaideIma = 0;
                    // 创建并添加引导页
                    DHGuidePageHUD *guidePage = [[DHGuidePageHUD alloc] dh_initWithFrame:self.window.frame imageNameArray:imageNameArray buttonIsHidden:YES];
                    
                    guidePage.pushVC = self.homePushVc;
                    [self.window addSubview:guidePage];
                }else{
                    [FMSingle shareSingle].is1ShowNilGuaideIma = 1;
                }
                break;
            }
            default:
                break;
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
    
}

@end
