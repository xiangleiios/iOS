//
//  UIViewController+FMExtenion.m
//  MobileProject
//
//  Created by Mingo on 2017/8/13.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "UIViewController+FMExtenion.h"

@implementation UIViewController (FMExtenion)

#pragma mark - 获取当前屏幕显示的viewcontroller
+ (UIViewController *)fm_getCurrentViewController
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

@end
