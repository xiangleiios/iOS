//
//  FMMediator+UserModuleActions.h
//  MobileProject
//
//  Created by Mingoy on 16/9/13.
//  Copyright © 2016年 Mingoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMMediator.h"
#import "HeaderUserConfig.h"

@interface FMMediator (UserModuleActions)

- (UIViewController *)FMMediator_User_viewControllerForDetail;

- (UIViewController *)FMMediator_User_viewControllerForDetail:(NSDictionary *)params;

@end
