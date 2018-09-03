//
//  FMHelper.h
//  MobileProject
//
//  Created by Mingo on 2017/7/5.
//  Copyright © 2017年 ZSGY. All rights reserved.
//


#import "FMHelper.h"
#import <CYLTabBarController.h>

@implementation FMHelper

#pragma mark - 创建一个分割线layer
+ (CALayer *)createLineLayer:(CGRect)frame color:(UIColor *)color{
    
    CALayer *lineLayer = [CALayer layer];
    lineLayer.speed = 1000;
    lineLayer.frame = frame;
    lineLayer.backgroundColor = color.CGColor;
    return lineLayer;
}

#pragma mark - 改变一个scrollView的最大可见contentSize.height
+ (void)changeScrollViewContentSizeHeight:(UIScrollView *)scrollView contentSizeHeight:(CGFloat)contentSizeHeight{
    
     scrollView.contentSize = CGSizeMake(0, contentSizeHeight);
}


#pragma mark - 改变contentScrollview的可见范围ContentInset(适用于键盘弹起情况)
+ (void)changeScrollViewContentInset:(UIScrollView *)scrollView heightOffset:(CGFloat)heightOffset{
    
    [UIView animateWithDuration:0.25 animations:^{
        UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, heightOffset, 0.0);
        scrollView.contentInset = contentInsets;
        scrollView.scrollIndicatorInsets = contentInsets;
    }];
}

#pragma mark - 执行一个延时执行的block
+ (void)DispatchAfterMethodBlock:(double)time block:(void (^)(void))block{
    
    double delayInSeconds = time;
    //__block LoginViewController* bself = self;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), block);
}

#pragma mark - 获取当前页面的导航控制器
+ (UINavigationController *)fm_getCurrentNav {
    UINavigationController *nav;
    AppDelegate *delegete = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIViewController *currentVc = delegete.window.rootViewController;
    
    if ([currentVc isKindOfClass:[CYLTabBarController class]]) {
        CYLTabBarController *tabVC;
        
        AppDelegate *delegete = (AppDelegate *)[UIApplication sharedApplication].delegate;
        UIViewController *vc = delegete.window.rootViewController;
        if ([vc isKindOfClass:[CYLTabBarController class]]) {
            tabVC = (CYLTabBarController *)vc;
        }
        [tabVC.view endEditing:YES];
        nav = tabVC.selectedViewController;
        return nav;
    }
    return nil;
//    if ([nav isKindOfClass:[UINavigationController class]]) {
//        nav = (UINavigationController*)currentVc;
//        return nav;
//    }else{
//        return nil;
//    }
}

#pragma mark - 弹出登录提示
+ (void)fm_showLoginAlertWithController:(UIViewController *)controller tipsStringIfNilShowDefault:(NSString *)tipsStr {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:tipsStr.length ? tipsStr : @"请登录后再操作哦！" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {}]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        LoginVC *vc= kAllocInit(LoginVC);
        [controller.navigationController pushViewController:vc animated:YES];
    }]];
    
    [controller presentViewController:alert animated:YES completion:nil];
}

#pragma mark - 跳转详情（根据不同link_type类型）
+ (void)fm_goinDetailJudgeFromModelLinkTypeStr:(FMMainModel *)model pushVc:(UIViewController *)pushVc {
    DetailsVC *vc = kAllocInit(DetailsVC);
    return;
}

#pragma mark - 景点信息详情请求
+ (void)fm_requestScenicInfo:(FMMainModel *)model pushVc:(UIViewController *)pushVc {
    
}

#pragma mark - 剧目详情请求
+ (void)fm_requestFilmInfo:(FMMainModel *)model pushVc:(UIViewController *)pushVc {
   
}
@end
