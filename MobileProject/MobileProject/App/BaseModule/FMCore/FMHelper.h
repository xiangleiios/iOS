//
//  FMHelper.h
//  MobileProject
//
//  Created by Mingo on 2017/7/5.
//  Copyright © 2017年 ZSGY. All rights reserved.
//


#import <Foundation/Foundation.h>

@interface FMHelper : NSObject

/// 创建一个分割线layer
+ (CALayer *)createLineLayer:(CGRect)frame color:(UIColor *)color;

/// 改变一个scrollView的最大可见contentSize.height
+ (void)changeScrollViewContentSizeHeight:(UIScrollView *)scrollView contentSizeHeight:(CGFloat)contentSizeHeight;

/// 改变contentScrollview的可见范围ContentInset(适用于键盘弹起情况)
+ (void)changeScrollViewContentInset:(UIScrollView *)scrollView heightOffset:(CGFloat)heightOffset;

/// 执行一个延时执行的block
+ (void)DispatchAfterMethodBlock:(double)time block:(void (^)(void))block;

/// 获取当前页面的导航控制器
+ (UINavigationController *)fm_getCurrentNav;

/// 弹出登录提示
+ (void)fm_showLoginAlertWithController:(UIViewController *)controller tipsStringIfNilShowDefault:(NSString *)tipsStr;

/// 轮播图跳转详情（根据不同link_type类型）
+ (void)fm_goinDetailJudgeFromModelLinkTypeStr:(FMMainModel *)model pushVc:(UIViewController *)pushVc;
@end
