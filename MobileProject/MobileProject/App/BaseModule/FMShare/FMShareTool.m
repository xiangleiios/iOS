//
//  FMShareTool.m
//  MobileProject
//
//  Created by Mingoy on 16/10/10.
//  Copyright © 2016年 Mingoy. All rights reserved.
//

#import "FMShareTool.h"

@implementation FMShareTool

/**
 把FM分享类型映射到友盟的类型
 
 @param fmPlatformType <#fmPlatformType description#>
 
 @return <#return value description#>
 */
+(UMSocialPlatformType)getUMSocialPlatformFMPlatformType:(FMSocialPlatformType)fmPlatformType
{
    UMSocialPlatformType platFormType=UMSocialPlatformType_UnKnown;
    switch (fmPlatformType) {
        case FMSocialPlatformType_QQ:
            platFormType=UMSocialPlatformType_QQ;
            break;
        case FMSocialPlatformType_Sina:
            platFormType=UMSocialPlatformType_Sina;
            break;
        case FMSocialPlatformType_Qzone:
            platFormType=UMSocialPlatformType_Qzone;
            break;
        case FMSocialPlatformType_TencentWb:
            platFormType=UMSocialPlatformType_TencentWb;
            break;
        case FMSocialPlatformType_WechatSession:
            platFormType=UMSocialPlatformType_WechatSession;
            break;
        case FMSocialPlatformType_WechatTimeLine:
            platFormType=UMSocialPlatformType_WechatTimeLine;
            break;
        default:
            platFormType=UMSocialPlatformType_UnKnown;
            break;
    }
    
    return platFormType;
}

@end
