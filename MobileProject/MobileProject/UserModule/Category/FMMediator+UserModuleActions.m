//
//  FMMediator+UserModuleActions.m
//  MobileProject
//
//  Created by Mingoy on 16/9/13.
//  Copyright © 2016年 Mingoy. All rights reserved.
//

#import "FMMediator+UserModuleActions.h"

//模块的常量
NSString * const kFMMediatorTargetUser = @"User";
NSString * const kFMMediatorActionNativUserDetailViewController = @"nativeUserDetailViewController";

@implementation FMMediator (UserModuleActions)

- (UIViewController *)FMMediator_User_viewControllerForDetail
{
    return [self FMMediator_User_viewControllerForDetail:nil];
}

- (UIViewController *)FMMediator_User_viewControllerForDetail:(NSDictionary *)params
{
    UIViewController *viewController = [self performTarget:kFMMediatorTargetUser
                                                    action:kFMMediatorActionNativUserDetailViewController
                                                    params:params];
    if ([viewController isKindOfClass:[UIViewController class]]) {
        // view controller 交付出去之后，可以由外界选择是push还是present
        return viewController;
    } else {
        // 这里处理异常场景，具体如何处理取决于产品
        return [[UIViewController alloc] init];
    }
}

@end
