//
//  UIWindow+Hierarchy.m
//  iOS-Categories (https://github.com/shaojiankui/iOS-Categories)
//
//  Created by Jakey on 15/1/16.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import "UIWindow+Hierarchy.h"

@implementation UIWindow (Hierarchy)
+ (UIViewController *)getCurrentPresentedVC{
    
    UIWindow *keywindow = [[[UIApplication sharedApplication] delegate] window];
    UIViewController *topVC = keywindow.rootViewController;
    
    while (topVC.presentedViewController) {
        topVC = topVC.presentedViewController;
    }
    return topVC;
}

+ (UIViewController *)getCurrentVC{
    UIViewController *currentViewController = [UIWindow getCurrentPresentedVC];
    
    while ([currentViewController isKindOfClass:[UINavigationController class]]
           && [(UINavigationController *) currentViewController topViewController]) {
        
        currentViewController = [(UINavigationController *) currentViewController topViewController];
    }
    
    return currentViewController;
    
}
@end
