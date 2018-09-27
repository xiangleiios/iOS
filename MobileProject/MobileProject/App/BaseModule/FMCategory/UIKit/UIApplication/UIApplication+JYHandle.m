//
//  UIApplication+JYHandle.m
//  JYExtension
//
//  Created by Dely on 2017/8/15.
//  Copyright © 2017年 Dely. All rights reserved.
//

#import "UIApplication+JYHandle.h"

@implementation UIApplication (JYHandle)

// 应用程序之间跳转
+ (void)quickOpenURLString:(NSString *)urlString{
    UIApplication *app = [UIApplication sharedApplication];
    NSURL *url = [NSURL URLWithString:urlString];
    if ([app canOpenURL:url]) {
        [app openURL:url];
    }
}


+ (void)goToAppSetting{
    [UIApplication quickOpenURLString:UIApplicationOpenSettingsURLString];
}

+ (void)goToTelephone:(NSString *)telephone{
    NSString *urlString = [@"tel://" stringByAppendingString:telephone];
    [UIApplication quickOpenURLString:urlString];
}




@end
