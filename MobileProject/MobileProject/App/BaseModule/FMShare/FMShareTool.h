//
//  FMShareTool.h
//  MobileProject
//
//  Created by Mingoy on 16/10/10.
//  Copyright © 2016年 Mingoy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UMSocialCore/UMSocialCore.h>
#import "FMShareConfigManager.h"

@interface FMShareTool : NSObject

/**
 把FM分享类型映射到友盟的类型
 
 @param fmPlatformType <#fmPlatformType description#>
 
 @return <#return value description#>
 */
+(UMSocialPlatformType)getUMSocialPlatformFMPlatformType:(FMSocialPlatformType)fmPlatformType;

@end
