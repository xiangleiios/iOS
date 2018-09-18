//
//  FMAnalyticsHelper.m
//  MobileProject
//
//  Created by 袁凤鸣 on 16/9/22.
//  Copyright © 2016年 袁凤鸣. All rights reserved.

#import "FMAnalyticsHelper.h"
//#import "UMMobClick/MobClick.h"
#import "FMAnalyticsConfigManager.h"
#import "Aspects.h"

@implementation FMAnalyticsHelper

+ (void)fmAnalyticsViewController {
    //放到异步线程去执行
    __weak typeof(self) ws = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [UIViewController aspect_hookSelector:@selector(viewWillAppear:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> info, BOOL animated){
            UIViewController *controller = [info instance];
            BOOL filterResult=[ws fileterWithControllerName:NSStringFromClass([controller class])];
            if (filterResult) {
                [ws beginLogPageView:[controller class]];
            }
        } error:NULL];
        
        [UIViewController aspect_hookSelector:@selector(viewWillDisappear:) withOptions:AspectPositionAfter usingBlock:^(id<AspectInfo> info, BOOL animated){
            UIViewController *controller = [info instance];
            BOOL filterResult=[ws fileterWithControllerName:NSStringFromClass([controller class])];
            if (filterResult) {
                [ws endLogPageView:[controller class]];
            }
        } error:NULL];
    });
}

//+ (void)beginLogPageView:(__unsafe_unretained Class)pageView {
//    [MobClick beginLogPageView:NSStringFromClass(pageView)];
//    return;
//}
//
//+ (void)endLogPageView:(__unsafe_unretained Class)pageView {
//    [MobClick endLogPageView:NSStringFromClass(pageView)];
//    return;
//}
//
//+(void)beginLogPageViewName:(NSString *)pageViewName
//{
//    [MobClick beginLogPageView:pageViewName];
//    return;
//}
//
//+(void)endLogPageViewName:(NSString *)pageViewName
//{
//    [MobClick endLogPageView:pageViewName];
//    return;
//}
//
//+(void)logEvent:(NSString*)eventId
//{
//    [MobClick event:eventId];
//}
//
//+(void)logEvent:(NSString*)eventId attributes:(NSDictionary *)attributes
//{
//    [MobClick event:eventId attributes:attributes];
//}

#pragma mark 自定义代码区

+(BOOL)fileterWithControllerName:(NSString *)controllerName
{
    BOOL Result=NO;
    
    if (FMAnalyticsConfigManagerInstance.prefixFilterArray.count==0&&FMAnalyticsConfigManagerInstance.noFileterNameArray.count==0&&FMAnalyticsConfigManagerInstance.fileterNameArray.count==0) {
        return YES;
    }
    
    //判断是否在符合前缀里面
    if (FMAnalyticsConfigManagerInstance.prefixFilterArray) {
        for (NSString *prefixItem in FMAnalyticsConfigManagerInstance.prefixFilterArray) {
            if ([controllerName hasPrefix:prefixItem]) {
                Result=YES;
                break;
            }
        }
    }
    //若有符合前缀则执行下面的内容 再进行判断当前页面是否要被省略掉的页面
    if (Result) {
        if ([FMAnalyticsConfigManagerInstance.noFileterNameArray containsObject:controllerName]) {
            Result=NO;
        }
    }
    else
    {
        if ([FMAnalyticsConfigManagerInstance.fileterNameArray containsObject:controllerName]) {
            Result=YES;
        }
    }
    
    return Result;
}

@end
