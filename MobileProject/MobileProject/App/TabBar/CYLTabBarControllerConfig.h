//
//  CYLTabBarControllerConfig.h
//  MobileProject
//
//  Created by Mingo on 2017/7/19.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CYLTabBarController.h"
@interface CYLTabBarControllerConfig : NSObject
@property (nonatomic, strong) UIViewController *homePushVc; //用于启动广告的 push 和 pop
@property (nonatomic, retain) CYLTabBarController * tabBarController;

@end
