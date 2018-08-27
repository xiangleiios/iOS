//
//  UIWindow+Hierarchy.h
//  iOS-Categories (https://github.com/shaojiankui/iOS-Categories)
//
//  Created by Jakey on 15/1/16.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIWindow (Hierarchy)
/// 获取当前屏幕中present出来的viewcontroller。
+ (UIViewController *)getCurrentPresentedVC;

/// 获取当前屏幕显示的viewcontroller
+ (UIViewController *)getCurrentVC;
@end
