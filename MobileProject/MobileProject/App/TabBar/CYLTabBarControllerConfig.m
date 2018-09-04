//
//  CYLTabBarControllerConfig.m
//  MobileProject
//
//  Created by Mingo on 2017/7/19.
//  Copyright © 2017年 ZSGY. All rights reserved.
//

#import "CYLTabBarControllerConfig.h"
#import "FMBaseNavigationController.h"
#import "FMMineVC.h"
#import "UIImage+FMExtension.h"
#import "XLHomeVC.h"
#import "StudentsVC.h"
@implementation CYLTabBarControllerConfig

- (CYLTabBarController *)tabBarController {
    if (_tabBarController == nil) {
        
        //首页
        XLHomeVC * firstViewController = [[XLHomeVC alloc] init];
        EasyNavigationController *firstNavigationController = [[EasyNavigationController alloc]initWithRootViewController:firstViewController];
//        FMBaseNavigationController * firstNavigationController = [[FMBaseNavigationController alloc] initWithRootViewController:firstViewController];
//        [firstNavigationController.navigationBar setTintColor:kWhiteColor];
        self.homePushVc = firstViewController;

        //活动

        StudentsVC * secondViewController01 = [[StudentsVC alloc] init];
        EasyNavigationController * secondNavigationController01 = [[EasyNavigationController alloc]initWithRootViewController:secondViewController01];
        
        
        //我的
        FMMineVC * fourthViewController = [[FMMineVC alloc] init];
        EasyNavigationController * fourthNavigationController = [[EasyNavigationController alloc]initWithRootViewController:fourthViewController];
        
        NSArray * tabBarItemsAttributes = [self tabBarItemsAttributes];
        NSArray * viewControllers = @[firstNavigationController,secondNavigationController01,fourthNavigationController];
        
        CYLTabBarController * tabBarController = [[CYLTabBarController alloc] init];
        tabBarController.tabBarItemsAttributes = tabBarItemsAttributes;
        tabBarController.viewControllers = viewControllers;
        [self customizeTabBarAppearance];
        
        _tabBarController = tabBarController;
//        _tabBarController.tabBarHeight = kTabBarH;
        
    }
    
    return _tabBarController;
}


- (NSArray *)tabBarItemsAttributes {
    NSDictionary * tabBarItem1Attribute01 = @{
                                            CYLTabBarItemTitle : @"首页",
                                            CYLTabBarItemImage : @"home_nor",
                                            CYLTabBarItemSelectedImage : @"home_down"
                                            };
    NSDictionary * tabBarItemAttribute02 = @{
                                             CYLTabBarItemTitle : @"学员",
                                             CYLTabBarItemImage : @"student_nor",
                                             CYLTabBarItemSelectedImage : @"student_down"
                                             };
    NSDictionary * tabBarItemAttribute05 = @{
                                             CYLTabBarItemTitle : @"我的",
                                             CYLTabBarItemImage : @"my_nor",
                                             CYLTabBarItemSelectedImage : @"my_down"
                                             };
     NSArray * tarBarItemsAttrbutes = @[tabBarItem1Attribute01,tabBarItemAttribute02,tabBarItemAttribute05];
    
    return tarBarItemsAttrbutes;
}


/**
 *  更多TabBar自定义设置：比如：tabBarItem 的选中和不选中文字和背景图片属性、tabbar 背景图片属性
 */
- (void)customizeTabBarAppearance {
    
    //去除 TabBar 自带的顶部阴影
//    [[UITabBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    // 普通状态下的文字属性
//    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
//    normalAttrs[NSForegroundColorAttributeName] = [UIColor blackColor];
//    
//    // 选中状态下的文字属性
//    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
//    selectedAttrs[NSForegroundColorAttributeName] = kNavBarColor;
    
    //设置tabbar按钮未选中状态文字大小、颜色
    UIFont *unSelectFont = [UIFont boldSystemFontOfSize:12];
    UIColor *unSelectColor = [UIColor grayColor];
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    [normalAttrs setValue:unSelectFont forKey:NSFontAttributeName];
    [normalAttrs setValue:unSelectColor forKey:NSForegroundColorAttributeName];
    
    //设置tabbar按钮选中状态文字大小、颜色
    UIFont *selectFont = [UIFont boldSystemFontOfSize:12];
    UIColor *selectColor = [UIColor blackColor];
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    [selectedAttrs setValue:selectFont forKey:NSFontAttributeName];
    [selectedAttrs setValue:selectColor forKey:NSForegroundColorAttributeName];
//    
    // 设置文字属性
    UITabBarItem *tabBar = [UITabBarItem appearance];
    [tabBar setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [tabBar setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
    
    // TabBarItem选中后那个被选中的item的背景颜色
//    [[UITabBar appearance] setSelectionIndicatorImage:[self imageFromColor:[UIColor colorWithRed:26 / 255.0 green:163 / 255.0 blue:133 / 255.0 alpha:1] forSize:CGSizeMake([UIScreen mainScreen].bounds.size.width / 5.0f, 49) withCornerRadius:0]];
   
    
    // set the bar background color
    // 设置背景图片
     UITabBar *tabBarAppearance = [UITabBar appearance];
     [tabBarAppearance setBackgroundImage:[UIImage fm_imageWithColor:kWhiteColor]];
}

- (UIImage *)imageFromColor:(UIColor *)color forSize:(CGSize)size withCornerRadius:(CGFloat)radius {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Begin a new image that will be the new image with the rounded corners
    // (here with the size of an UIImageView)
    UIGraphicsBeginImageContext(size);
    
    // Add a clip before drawing anything, in the shape of an rounded rect
    [[UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:radius] addClip];
    // Draw your image
    [image drawInRect:rect];
    
    // Get the image, here setting the UIImageView image
    image = UIGraphicsGetImageFromCurrentImageContext();
    
    // Lets forget about that we were drawing
    UIGraphicsEndImageContext();
    return image;
}

@end
