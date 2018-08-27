//
//  FMAnalyticsConfigManager.m
//  MobileProject
//
//  Created by Mingoy on 16/9/22.
//  Copyright © 2016年 Mingoy. All rights reserved.
//

#import "FMAnalyticsConfigManager.h"

@implementation FMAnalyticsConfigManager

+ (FMAnalyticsConfigManager *)sharedInstance
{
    static FMAnalyticsConfigManager* instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [FMAnalyticsConfigManager new];
    });
    return instance;
}

@end
