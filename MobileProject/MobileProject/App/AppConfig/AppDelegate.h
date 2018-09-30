//
//  AppDelegate.h
//  MobileProject
//
//  Created by Mingoy on 16/9/13.
//  Copyright © 2016年 Mingoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMSingle.h"
#import "SQLfmdb.h"
#import "DetailsVC.h"
#import "CYLTabBarControllerConfig.h"

@interface AppDelegate : UIResponder<UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
/** 允许屏幕旋转 */
@property (assign, nonatomic) NSInteger allowRotate;
/** 首页VC 用于push广告图后返回到首页 */
@property (nonatomic, strong) UIViewController *homePushVc;
/** 数据库对象 */
@property (nonatomic, strong) SQLfmdb *fmdb;

@property (nonatomic , strong)CYLTabBarControllerConfig *tab;
//@property (assign, nonatomic) NSInteger allowRotate;
@end

