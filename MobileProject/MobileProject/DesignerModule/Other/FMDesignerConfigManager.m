
//
//  jiaConfigManager.m
//  MobileProject
//
//  Created by Mingoy on 16/9/20.
//  Copyright © 2016年 Mingoy. All rights reserved.
//

#import "FMDesignerConfigManager.h"

@implementation FMDesignerConfigManager

+ (FMDesignerConfigManager *)sharedInstance
{
    static FMDesignerConfigManager* instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [FMDesignerConfigManager new];
    });
    
    return instance;
}

@end
