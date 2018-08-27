//
//  Target_Designer.m
//  MobileProject
//
//  Created by Mingoy on 16/9/13.
//  Copyright © 2016年 Mingoy. All rights reserved.
//

#import "Target_Designer.h"
#import "DesignerViewController.h"

typedef void (^FMUrlRouterCallbackBlock)(NSDictionary *info);

@implementation Target_Designer

- (UIViewController *)Action_nativeFetchDetailViewController:(NSDictionary *)params
{
    DesignerViewController *viewController=[[DesignerViewController alloc]initWithRouterParams:params];
    return viewController;
}

@end
