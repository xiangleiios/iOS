//
//  Target_User.m
//  MobileProject
//
//  Created by Mingoy on 16/9/13.
//  Copyright © 2016年 Mingoy. All rights reserved.
//

#import "Target_User.h"
#import "UserViewController.h"

@implementation Target_User

- (UIViewController *)Action_nativeUserDetailViewController:(NSDictionary *)params
{
    UserViewController *viewController=[[UserViewController alloc]initWithRouterParams:params];
    return viewController;
}

@end
